<%@page contentType="text/html" pageEncoding="windows-31j"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="common.OrderInfoList"%>
<%@page import="common.OrderItemList"%>
<%@page import="common.SelectModel"%>
<%@page session="true"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Context-Type" content="text/html"; charset="windows-31j" > 
		<title>受注詳細表示</title>
	</head>
	<body>
		<h1>受注詳細表示</h1>
				
		<form action="OrderDetailController" method="post">
			<input type="submit" name='backToSelect' value='戻る' /><br/></br>
		</form>



	<table border=3>
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
				int orderNo = (Integer)session.getAttribute("orderNo");
				String word = (String)session.getAttribute("word");
				
			    SelectModel select = new SelectModel();
				ArrayList<OrderInfoList> orderInfoList = select.getOrderList(word);
				
				if (orderInfoList.size() != 0) {
					for (OrderInfoList or : orderInfoList) {
						 if (or.getOrderNumber() == orderNo) {
							 int orderNumber= or.getOrderNumber();			//受注No
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
				}
			%></table><br />
	
	<table border=3>
		<tr>
			<td>商品コード</td>
			<td>商品名</td>
			<td>単価</td>
			<td>数量</td>
			
			<%
			ArrayList<OrderItemList> orderItemList = select.getOrderItemList(orderNo);
				for (OrderItemList or : orderItemList) {
					int itemCode = or.getItemCode();
					String itemName = or.getItemName();
					int itemQuantity = or.getItemQuantity();
					double price = or.getItemPrice();

					out.println(String.format("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td>", 
							itemCode, itemName, price, itemQuantity));
				}
			%></table></br>

	<form action="OrderDetailController" method="post">
		<input type="submit" name='deletion' value="受注削除" />
	</form>
	</body>
</htmt>
