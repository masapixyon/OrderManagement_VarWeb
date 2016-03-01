package sessionEntry;

import java.io.*;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.*;
import javax.servlet.http.*;

import common.ErrorStorage;

import javax.servlet.annotation.*;
@WebServlet(name = "RegistrationController", urlPatterns = {"/RegistrationController"})
public class RegistrationController extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		
		ErrorStorage errorCode = new ErrorStorage();
		
		if(req.getParameter("entry") != null) {
			try{
				//年月日の取得
				int year = 0;
				int month = 0;
				int day = 0;
				String yearStr = req.getParameter("year");
				String monthStr = req.getParameter("month");
				String dayStr = req.getParameter("day");

				year = Integer.parseInt( yearStr );       //String型をint型に変換
				month = Integer.parseInt( monthStr );
				day = Integer.parseInt( dayStr );

				Calendar cal = Calendar.getInstance();
				cal.setLenient(false);
				cal.set(year, month-1, day);
				//セットした時間を取得
				//不適切な月日がgetされた場合、例外エラー
				cal.getTime().getTime();

				
				//受注商品を登録
				HttpSession session = req.getSession(true);
				ArrayList<ItemOrderList> itemOrderList = (ArrayList<ItemOrderList>)session.getAttribute("list");
					
				String customCodeStr = req.getParameter("customCode");
				int customCode = Integer.parseInt( customCodeStr ); 
				String salesCode = req.getParameter("salesCode");

		    	if( itemOrderList != null){
		    		
		    		double totalMoney = 0, totalTax = 0, reqestMoney = 0;
					for (ItemOrderList it : itemOrderList) {
						totalMoney = it.getTotalMoney();
						totalTax = it.getTotalTax();
						reqestMoney = it.getReqestMoney();
					}
						
						//Insert( order_titleとorder_detailに登録 )
						InsertModel.insertOT( cal, customCode, salesCode,
								totalMoney, totalTax, reqestMoney, itemOrderList); 
					 
				}
				
				
				getServletContext().getRequestDispatcher("/completion.jsp").forward(req, resp);
				
			} catch (IllegalArgumentException e) {       //不適切な引数の場合
				
				//エラーメッセージの追加
				//"ERROR CODE 004 入力された年月日は存在しません"をset
				
				errorCode.setErrorCode(4);
				req.setAttribute("errorCode", errorCode);
				getServletContext().getRequestDispatcher("/orderRegistration.jsp").forward(req, resp);
			}

		}
		
		if(req.getParameter("back") != null) {
			getServletContext().getRequestDispatcher("/entryChoice.jsp").forward(req, resp);
		}
	}
}
