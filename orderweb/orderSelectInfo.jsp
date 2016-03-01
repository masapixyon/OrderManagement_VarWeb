<%@page contentType="text/html" pageEncoding="windows-31j"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import ="common.SelectModel"%>
<%@page import ="common.OrderInfoList"%>
<%@page import ="common.ErrorStorage"%>
<%@page session="true"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Context-Type" content="text/html"; charset="windows-31" > 
		<title>受注管理システム</title>
	</head>
	<body>
	<h1>検索結果</h1>
	
	
<!-- エラーメッセージ表示 -->
<%  
    ErrorStorage errorCodeX = (ErrorStorage) request.getAttribute("errorCode");
    //エラーコードをget
    int errorCode = errorCodeX.getErrorCode();
    
    if(errorCodeX != null ){
    	String errorMesseage = null;
    	
    	if(errorCode == 5){
    		//エラーメッセージをget
    		errorMesseage = errorCodeX.getErrorMesseage005();
    		 %> <p> <%= errorMesseage %> </p> <%
    	}
    }
%>



	<form action="OrderSelectController" method="post">
		<input type="submit" name='backToPrimary' value='戻る' />	</br>
	</form>
	

	<form action="OrderDetailController" method="post">
		<p>受注No
        <select name="orderNumber">
		<%
 		SelectModel searchModel = (SelectModel) request.getAttribute("searchModel");
		if(searchModel != null){

			ArrayList<OrderInfoList> results = searchModel.getOrderInfoListResults();

    		if(results.size()!=0){
	 			for(common.OrderInfoList re :results){
	 				int orderNumber= re.getOrderNumber();		//受注No
	 				%>
						<option value="<%= orderNumber %>"><%= orderNumber %></option>
					<%
	 			}
   		 	}
    		
		}
	
		%>
		</select>
			<input name="detailShow" type="submit" value="詳細表示" />
		</p>
	</form>

	<table border="3">
		<tr>
			<td>受注No</td>
			<td>受注日付</td>
			<td>顧客コード</td>
			<td>顧客名</td>
			<td>担当者コード</td>
			<td>担当者名</td>
			<td>合計金額</td>
			<td>消費税</td>
			<td>請求金額</td>
<%
	if(searchModel != null){
		ArrayList<OrderInfoList> orderInfoList = searchModel.getOrderInfoListResults();
 		//セッションにListをセット
		session.setAttribute("orderInfoList", orderInfoList);
		
    	if(orderInfoList.size()!=0){
	 		for(OrderInfoList or : orderInfoList){
				int orderNumber= or.getOrderNumber();		//受注No
				Date orderData = or.getOrderDate();			//受注日付
				int customCode = or.getCustomCode();		//顧客コード
				String customName = or.getCustomName();		//顧客名前
				String salesCode =	or.getSalesCode();		//担当者コード
				String salesName = or.getSalesName();		//担当者名前
				double totalMoney = or.getTotalMoney();		//合計金額
				double tax = or.getTax();					//消費税
				double requestMoney = or.getRequestMoney();//請求金額
	
				out.println(String.format("<tr><td>%d</td><td>%s</td><td>%d</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td>",
					orderNumber,orderData,customCode,customName,salesCode,salesName,totalMoney,tax,requestMoney));
			} 
    	}
		out.println("</table>");
	} 
%>

	</body>
</htmt>
