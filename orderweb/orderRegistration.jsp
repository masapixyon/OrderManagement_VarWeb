<!-- �����R�[�hwindows-31j�ɂ��HTML���� -->

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
<title>�󒍊Ǘ��V�X�e��</title>
</head>
<body>
	<h1>�󒍓o�^</h1>

	<!-- �@�o�^���t�^�@�@-->
	<p><form action="RegistrationController" method="get" >

	
	<!--�@ �N�@�@-->
		�󒍔N����<select name="year">
		<%for(int y = 2010; y <= 2018; y++){%>
			<option value="<%= y %>" > <%= y %></option>
		<% } %>
		
	<!-- �@�� �@-->
		</select>�N<select name="month">
		<%for(int m = 1; m <= 12; m++){%>
			<option value="<%= m %>" > <%= m %></option>
		<% } %>
		
	<!-- �@�� �@-->
		</select>��<select name="day">
		<%for(int d = 1; d <= 31; d++){%>
			<option value="<%= d %>" > <%= d %></option>
		<% } %>
		
		
	<!--�@ �ڋq �@-->
		</select>�@�ڋq<select name="customCode">	
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
			
	<!-- �@�S���ҁ@ -->
		</select>�@�S����<select name="salesCode">
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
		<input type="submit" name= "entry" value='�o�^' /> </br> 
	</form></p>
	
	
	
	
		<!-- �G���[���b�Z�[�W�\�� -->
<%  
    ErrorStorage errorCodeX = (ErrorStorage) request.getAttribute("errorCode");
    //�G���[�R�[�h��get
    int errorCode = errorCodeX.getErrorCode();
    
    if(errorCodeX != null ){
    	String errorMesseage = null;
    	
    	if(errorCode == 4){
    		//�G���[���b�Z�[�W��get
    		errorMesseage = errorCodeX.getErrorMesseage004();
    		 %> <p> <%= errorMesseage %> </p> <%
    	}
    }
%>
	
	<p>�󒍏��i�ꗗ</p>
	<table border="3">
		<tr>
			<td>���i�R�[�h</td>
			<td>���i��</td>
			<td>�P��</td>
			<td>����</td>
			<td>���z</td>
			<td>�ō����z</td>
		</tr>
		
		<!--  �󒍈ꗗ�̒ǉ��\�� -->
		
		<%
		//EntryController��Set���ꂽitemOrderList��session���g���Ď擾
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
				
				out.println(String.format("<tr><td>%d�@�@�@�@</td><td>%s</td><td>%s</td><td>%d</td><td>%s</td><td>%s</td></tr>",
						itemCodeIO, itemNameIO, StrItemPriceIO, itemQuantityIO, amountOfMoneyIO, StrTaxIncludedIO));
			} 
		}
		%>
	</table>
	
	
	<!-- ���v���z�A����ŋ��z�A�������z�̕\��  -->
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
	
	
			
	<p>���v���z�F<%= totalMoney %> ����Ŋz�F<%= tax %> �������z�F<%= reqestMoney %></p>
	
	<form action="RegistrationController" method="get" >
			<input type="submit" name='back' value='�߂�' /> </br>
	</form>
</body>
</html>
