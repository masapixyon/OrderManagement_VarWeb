<!-- 文字コードwindows-31jによるHTML文書 -->

<%@page contentType="text/html" pageEncoding="windows-31j"%>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="java.util.*"%>
<%@page import="sessionEntry.ItemOrderList" %>
<%@page import="sessionEntry.EntryController" %>
<%@page import="sessionEntry.ItemOrderPutInList" %>

<%@page import="sessionEntry.RegistrationController" %>
<%@page import="common.SelectModel" %>
<%@page import="common.CustomList" %>
<%@page import="common.SalesList" %>
<%@page import="common.ErrorStorage" %>
<%@page session="true"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-31j" />
<title>受注管理システム</title>
</head>
<body>
	<h1>受注登録</h1>

	<!-- 　登録情報付与　　-->
	<p><form action="RegistrationController" method="get" >

	
	<!--　 年　　-->
		受注年月日<select name="year">
		<%for(int y = 2010; y <= 2018; y++){%>
			<option value="<%= y %>" > <%= y %></option>
		<% } %>
		
	<!-- 　月 　-->
		</select>年<select name="month">
		<%for(int m = 1; m <= 12; m++){%>
			<option value="<%= m %>" > <%= m %></option>
		<% } %>
		
	<!-- 　日 　-->
		</select>月<select name="day">
		<%for(int d = 1; d <= 31; d++){%>
			<option value="<%= d %>" > <%= d %></option>
		<% } %>
		
		
	<!--　 顧客 　-->
		</select>　顧客<select name="customCode">	
			<% 
				SelectModel select = new SelectModel();
				ArrayList<CustomList> customList = select.getCustomResult();

				String customName;
				int customCode;
				for( CustomList custom : customList){
					customName = custom.getCustomName();
					customCode = custom.getCustomCode();
			%>
				<option value="<%= customCode %>"> <%= customName %> ( <%= customCode %> ) </option>
			<% } %>
			
	<!-- 　担当者　 -->
		</select>　担当者<select name="salesCode">
			<%
				select = new SelectModel();
				ArrayList <SalesList> salesList = select.getSalesResult();
			
				String salesName;
				String salesCode;
				for( SalesList sales : salesList){
					salesName = sales.getSalesName();
					salesCode = sales.getSalesCode();
			%>
				<option value="<%= salesCode %>"> <%= salesName %> ( <%= salesCode %> ) </option>
			<% } %>
		</select>
		<input type="submit" name= "entry" value='登録' /> </br> 
	</form></p>
	
	
	
	
		<!-- エラーメッセージ表示 -->
<%  
    ErrorStorage errorCodeX = (ErrorStorage) request.getAttribute("errorCode");
    //エラーコードをget
    int errorCode = errorCodeX.getErrorCode();
    
    if(errorCodeX != null ){
    	String errorMesseage = null;
    	
    	if(errorCode == 4){
    		//エラーメッセージをget
    		errorMesseage = errorCodeX.getErrorMesseage004();
    		 %> <p> <%= errorMesseage %> </p> <%
    	}
    }
%>
	
	<p>受注商品一覧</p>
	<table border="3">
		<tr>
			<td>商品コード</td>
			<td>商品名</td>
			<td>単価</td>
			<td>数量</td>
			<td>金額</td>
			<td>税込金額</td>
		</tr>
		
		<!--  受注一覧の追加表示 -->
		
		<%
		//EntryControllerでSetされたitemOrderListをsessionを使って取得
		ArrayList<ItemOrderList> itemOrderList = (ArrayList<ItemOrderList>)session.getAttribute("list");
    	if( itemOrderList != null){

			for (ItemOrderList it : itemOrderList) {
				int itemCodeIO = it.getItemCode();
				String itemNameIO = it.getItemName();
				double itemPriceIO = it.getItemPrice();
				int itemQuantityIO = it.getItemQuantity();
				double amountOfMoneyIO = it.getAmountOfMoney();
				double taxIncludedIO = it.getTaxIncluded();
				
				String StrItemPriceIO = String.format("%.1f", itemPriceIO);
				String StrAmoustOfMoneyIO = String.format("%.1f", amountOfMoneyIO);
				String StrTaxIncludedIO = String.format("%.1f", taxIncludedIO);
				
				out.println(String.format("<tr><td>%d　　　　</td><td>%s</td><td>%s</td><td>%d</td><td>%s</td><td>%s</td></tr>",
						itemCodeIO, itemNameIO, StrItemPriceIO, itemQuantityIO, amountOfMoneyIO, StrTaxIncludedIO));
			} 
		}
		%>
	</table>
	
	
	<!-- 合計金額、消費税金額、請求金額の表示  -->
		<%
		double totalMoney = 0.0;
		double tax = 0.0;
		double reqestMoney = 0.0;
		    
		if (itemOrderList != null) {
			for (ItemOrderList it : itemOrderList) {
				totalMoney = it.getTotalMoney();
				tax = it.getTotalTax();
				reqestMoney = it.getReqestMoney();
			}
		}
	%>
	
	
			
	<p>合計金額：<%= totalMoney %> 消費税額：<%= tax %> 請求金額：<%= reqestMoney %></p>
	
	<form action="RegistrationController" method="get" >
			<input type="submit" name='back' value='戻る' /> </br>
	</form>
</body>
</html>
