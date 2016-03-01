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
		<title>�󒍊Ǘ��V�X�e��</title>
	</head>
	<body>
	<h1>��������</h1>
	
	
<!-- �G���[���b�Z�[�W�\�� -->
<%  
    ErrorStorage errorCodeX = (ErrorStorage) request.getAttribute("errorCode");
    //�G���[�R�[�h��get
    int errorCode = errorCodeX.getErrorCode();
    
    if(errorCodeX != null ){
    	String errorMesseage = null;
    	
    	if(errorCode == 5){
    		//�G���[���b�Z�[�W��get
    		errorMesseage = errorCodeX.getErrorMesseage005();
    		 %> <p> <%= errorMesseage %> </p> <%
    	}
    }
%>



	<form action="OrderSelectController" method="post">
		<input type="submit" name='backToPrimary' value='�߂�' />	</br>
	</form>
	

	<form action="OrderDetailController" method="post">
		<p>��No
        <select name="orderNumber">
		<%
 		SelectModel searchModel = (SelectModel) request.getAttribute("searchModel");
		if(searchModel != null){

			ArrayList<OrderInfoList> results = searchModel.getOrderInfoListResults();

    		if(results.size()!=0){
	 			for(common.OrderInfoList re :results){
	 				int orderNumber= re.getOrderNumber();		//��No
	 				%>
						<option value="<%= orderNumber %>"><%= orderNumber %></option>
					<%
	 			}
   		 	}
    		
		}
	
		%>
		</select>
			<input name="detailShow" type="submit" value="�ڍו\��" />
		</p>
	</form>

	<table border="3">
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
	if(searchModel != null){
		ArrayList<OrderInfoList> orderInfoList = searchModel.getOrderInfoListResults();
 		//�Z�b�V������List���Z�b�g
		session.setAttribute("orderInfoList", orderInfoList);
		
    	if(orderInfoList.size()!=0){
	 		for(OrderInfoList or : orderInfoList){
				int orderNumber= or.getOrderNumber();		//��No
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
		out.println("</table>");
	} 
%>

	</body>
</htmt>
