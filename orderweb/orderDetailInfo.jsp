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
		<title>�󒍏ڍו\��</title>
	</head>
	<body>
		<h1>�󒍏ڍו\��</h1>
				
		<form action="OrderDetailController" method="post">
			<input type="submit" name='backToSelect' value='�߂�' /><br/></br>
		</form>



	<table border=3>
		<tr>
			<td>��No</td>
			<td>�󒍓��t</td>
			<td>�ڋq�R�[�h</td>
			<td>�ڋq��</td>
			<td>�S���҃R�[�h</td>
			<td>�S���Җ�</td>
			<td>���v���z</td>
			<td>�����</td>
			<td>�������z</td>
			<%
				int orderNo = (Integer)session.getAttribute("orderNo");
				String word = (String)session.getAttribute("word");
				
			    SelectModel select = new SelectModel();
				ArrayList<OrderInfoList> orderInfoList = select.getOrderList(word);
				
				if (orderInfoList.size() != 0) {
					for (OrderInfoList or : orderInfoList) {
						 if (or.getOrderNumber() == orderNo) {
							 int orderNumber= or.getOrderNumber();			//��No
								Date orderData = or.getOrderDate();			//�󒍓��t
								int customCode = or.getCustomCode();		//�ڋq�R�[�h
								String customName = or.getCustomName();		//�ڋq���O
								String salesCode =	or.getSalesCode();		//�S���҃R�[�h
								String salesName = or.getSalesName();		//�S���Җ��O
								double totalMoney = or.getTotalMoney();		//���v���z
								double tax = or.getTax();					//�����
								double requestMoney = or.getRequestMoney();//�������z
					
								out.println(String.format("<tr><td>%d</td><td>%s</td><td>%d</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td>",
									orderNumber,orderData,customCode,customName,salesCode,salesName,totalMoney,tax,requestMoney));
						} 
					}
				}
			%></table><br />
	
	<table border=3>
		<tr>
			<td>���i�R�[�h</td>
			<td>���i��</td>
			<td>�P��</td>
			<td>����</td>
			
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
		<input type="submit" name='deletion' value="�󒍍폜" />
	</form>
	</body>
</htmt>
