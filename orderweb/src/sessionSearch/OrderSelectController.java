package sessionSearch;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SelectModel;
import common.ErrorStorage;
import sessionEntry.ItemOrderPutInList;

@WebServlet(name = "OrderSelectController", urlPatterns = {"/OrderSelectController"})
public class OrderSelectController extends HttpServlet {
    
	ErrorStorage errorCode = new ErrorStorage();
	
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		// 文字コードなど指定
		resp.setContentType("text/html; charset=windows-31J");
		resp.setCharacterEncoding("windows-31J");	
		String word = null;
		HttpSession session = req.getSession(true);

		if(req.getParameter("backToPrimary") != null) {
			
			getServletContext().getRequestDispatcher("/primary.jsp").forward(req, resp);
			
		}
		
		
		//orderDetailInfo.jspで戻るを押下された場合に実行
		else if(req.getParameter("backToSelect") != null) {
			
			//sessionに確保してたものを取得
			word = (String) session.getAttribute("word");
			
			if (word != null) {
				SelectModel searchModel = new SelectModel();
				searchModel.getOrderList(word);

				req.setAttribute("searchModel", searchModel);
			}

			getServletContext().getRequestDispatcher("/orderSelectInfo.jsp").forward(req, resp);
		}
		
			
		//primary.jspで受注検索ボタンを押下時
		else{		
			word = req.getParameter("searchWord");
			word = new String(word.getBytes("8859_1"),"windows-31J");
			
			//次のページで戻るを押された場合でも表示するために、sessionに確保
			session.setAttribute("word", word);
			
			
			if (word != null) {
				SelectModel searchModel = new SelectModel();
				searchModel.getOrderList(word);
				 
				 //エラーメッセージ
				 //"ERROR CODE 005 : 検索された文字に該当する受注記録は存在しません"を格納
				 if(searchModel.getJudgeToHaveOrderInfoList() == false){
					 errorCode.setErrorCode(5);
					 req.setAttribute("errorCode", errorCode);
				 }
				 
				 req.setAttribute("searchModel", searchModel);		 
			}
			
			getServletContext().getRequestDispatcher("/orderSelectInfo.jsp").forward(req, resp);
		}
	}
}