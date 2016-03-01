package sessionSearch;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sessionDelete.DeleteModel;

@WebServlet(name = "OrderDetailController", urlPatterns = {"/OrderDetailController"})
public class OrderDetailController extends HttpServlet {
    
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {	
		
		HttpSession session = req.getSession(true);
		
		//戻るボタン押下
        if(req.getParameter("backToSelect") != null) {
			getServletContext().getRequestDispatcher("/OrderSelectController").forward(req, resp);
		}
        
        //削除ボタン押下
        else if(req.getParameter("deletion") != null) {
        	int orderNo = (int) session.getAttribute("orderNo");
        	DeleteModel.Delete(orderNo);
        	getServletContext().getRequestDispatcher("/doneDelection.jsp").forward(req, resp);
        	
        }
        else if(req.getParameter("backToPrimary") != null) {
        	getServletContext().getRequestDispatcher("/primary.jsp").forward(req, resp);
        	
        }
        //詳細表示ボタンを押下された場合
        else{
        	if(req.getParameter("detailShow") != null) {
        		
        		//詳細検索で選ばれた受注番号
        		String orderNoStr = req.getParameter("orderNumber");
        		int orderNo = Integer.parseInt( orderNoStr );
        		
        		//sessionでwordで検索されたListを取得
				session.setAttribute("orderNo", new Integer(orderNo));
				
			getServletContext().getRequestDispatcher("/orderDetailInfo.jsp").forward(req, resp);
			
        	}
        }
	}
}