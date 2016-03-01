package sessionEntry;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import common.ErrorStorage;
import common.SelectModel;

import javax.servlet.annotation.*;

@WebServlet(name = "EntryController", urlPatterns = {"/EntryController"})
public class EntryController extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		
		ErrorStorage errorCode = new ErrorStorage();
		
		//商品選択ボタンを押下時
		//ArrayListに追加処理
		if(req.getParameter("itemChoice") != null) {

			String tempItemCode = req.getParameter("itemCode");
			String tempQuantity = req.getParameter("quantity");
			int itemCode = 0;
			int quantity = 0;

			if (tempItemCode != null){
				try{
					itemCode = Integer.parseInt( tempItemCode );
					quantity = Integer.parseInt( tempQuantity );
					
					SelectModel itemCodeSearchModel = new SelectModel();
					
					//一商品の情報取得
					if (itemCode != 0) {
						itemCodeSearchModel.getItemResult(itemCode);
						req.setAttribute("itemCodeSearchModel", itemCodeSearchModel);
					}
					
					//一個の商品をListに追加するメソッド
					ItemOrderPutInList list = new ItemOrderPutInList();
					list.getItemOrderList(req);       
					req.setAttribute("list", list);


					//エラーメッセージの追加
					//"ERROR CODE 001 入力された商品コードは既に選択済みです"をset
					
					int errorCodeI = ItemOrderPutInList.getErrorCode();
					if(errorCodeI == 1){
						errorCode.setErrorCode(1);
						req.setAttribute("errorCode", errorCode);
					}
				}
				
				//エラーメッセージの追加
				//"ERROR CODE 002 商品コードや数量に入力できるのは数値のみです"をset
				
				catch ( NumberFormatException e ) {      
					errorCode.setErrorCode(2);
					req.setAttribute("errorCode", errorCode);
				}
			}
			getServletContext().getRequestDispatcher("/entryChoice.jsp").forward(req, resp);
		}
		
		
		//商品選択確定ボタンを押下時
		//itemOrderListをsessionを使ってSetする
		
		if(req.getParameter("next") != null) {

			HttpSession session = req.getSession(true);
			ArrayList<ItemOrderList> itemOrderList = new ArrayList<ItemOrderList>();
			
			ItemOrderPutInList list = new ItemOrderPutInList();
			itemOrderList = list.getList();
			
			
			//itemOrderListに受注商品が設定されていれば、登録画面に遷移
			//しかし、受注商品が設定されてない場合、登録画面に遷移せず、またエラーコードを設定する。
			
			if(itemOrderList.size() != 0){
				
				session.setAttribute("list", itemOrderList);
				getServletContext().getRequestDispatcher("/orderRegistration.jsp").forward(req, resp);
				
			}else{
				//エラーメッセージの追加
				//"ERROR CODE 003 商品選択確定を行うには、受注選択をする必要があります"をset
				
				errorCode.setErrorCode(3);
				req.setAttribute("errorCode", errorCode);
				getServletContext().getRequestDispatcher("/entryChoice.jsp").forward(req, resp);
			}
		}
		
		
		
		//リセットボタンの押下時
		if(req.getParameter("reset") != null) {
			ItemOrderPutInList.getList().clear();
			getServletContext().getRequestDispatcher("/entryChoice.jsp").forward(req, resp);
		}
		
		
		
		//戻るボタンの押下時
		//初期画面に戻った場合、なぜかgetList()が初期化されていない
		if(req.getParameter("back") != null) {
			ItemOrderPutInList.getList().clear();
			getServletContext().getRequestDispatcher("/primary.jsp").forward(req, resp);
		}
	}
}
