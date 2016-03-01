<!-- �����R�[�hwindows-31j�ɂ��HTML���� -->

<%@page contentType="text/html" pageEncoding="windows-31j"%>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="java.util.*"%>
<%@page import="common.SelectModel" %>
<%@page import="common.ItemList" %>
<%@page import="sessionEntry.ItemOrderList" %>
<%@page import="sessionEntry.EntryController" %>
<%@page import="sessionEntry.ItemOrderPutInList" %>
<%@page import="common.ErrorStorage" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-31j" />
<title>�󒍊Ǘ��V�X�e��</title>
	<script language="JavaScript">
	<!--		
    	function checkForm() {
			if (document.f1.itemCode.value == "" || document.f1.quantity.value == "") {
				alert('���i�R�[�h�Ɛ��ʂ���͂��Ă�������');
				document.f1.itemCode.focus();
				return false;
			}
			return true;
		} 
	//-->
	</script>
	
</head>
<body>

	<h1>�󒍏��i�I��</h1>
	<form name="f1"  method="get" action="EntryController" onSubmit="return checkForm()">
			���i�R�[�h<input type="text" name="itemCode" />
			����<input type="text" name="quantity" />
			<input type="submit" name= "itemChoice" value='���i�I��' /> </br> 
	</form>
	
	<form action="EntryController" method="get" >
			<input type="submit" name='next' value="���i�I���m��" /> </br>
			<!-- ���Z�b�g�{�^���@-->
			<input type="submit" name='reset' value='���Z�b�g' /> </br>
			<input type="submit" name='back' value='�߂�' /> </br>
	</form>




	<!-- �G���[���b�Z�[�W�\�� -->
<%  
    ErrorStorage errorCodeX = (ErrorStorage) request.getAttribute("errorCode");
    //�G���[�R�[�h��get
    int errorCode = errorCodeX.getErrorCode();
    
    if(errorCodeX != null ){
    	String errorMesseage = null;
    	
    	if(errorCode == 1){
    		//�G���[���b�Z�[�W��get
    		errorMesseage = errorCodeX.getErrorMesseage001();
    		 %> <p> <%= errorMesseage %> </p> <%
    	}
    	if(errorCode == 2){
    		errorMesseage = errorCodeX.getErrorMesseage002();
    		 %> <p> <%= errorMesseage %> </p> <%
    	}
    	if(errorCode == 3){
    		errorMesseage = errorCodeX.getErrorMesseage003();
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
			
			
		ArrayList<ItemOrderList> itemOrderList = new ArrayList<ItemOrderList>();
		sessionEntry.ItemOrderPutInList list = (sessionEntry.ItemOrderPutInList) request.getAttribute("list");
		//orderRegistration�Ŗ߂�������ꂽ�ꍇ,request�Ńf�[�^����Ȃ�
		//������ԂŎ󂯎�����ꍇ�͌��Xlist���̂���Ȃ̂Ŗ��͂Ȃ�
		if( list == null){
		    list = new ItemOrderPutInList();
		    
		}if( list != null){
			itemOrderList = list.getList();
			 
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
		    
		if (list != null) {
			itemOrderList = list.getList();
			for (ItemOrderList it : itemOrderList) {
				totalMoney = it.getTotalMoney();
				tax = it.getTotalTax();
				reqestMoney = it.getReqestMoney();
			}
		}
	%>
			
	<p>���v���z�F<%= totalMoney %> ����Ŋz�F<%= tax %> �������z�F<%= reqestMoney %></p>
	

	
	
	<hr>



	<!--  ���i�ꗗ�\��  -->

	<p>���i�ꗗ</p>
	<table border=3>
		<tr>
			<td>���i�R�[�h</td>
			<td>���i��</td>
			<td>�P��</td>
		</tr>
		<%
		SelectModel select = new SelectModel();
		ArrayList <ItemList> itemList = select.getItemResult();
		String itemName;
		int itemCode;
		double itemPrice;
		
		for( ItemList item : itemList ){
			itemCode = item.getItemCode();
			itemName = item.getItemName();
            itemPrice = item.getItemPrice();
            
			out.println(String.format(
					"<tr><td>%d�@�@�@�@</td><td>%s</td><td>%s</td></tr>",
					itemCode, itemName ,itemPrice));
		} 
		out.println("</table>");
%>
	
</body>
</html>
