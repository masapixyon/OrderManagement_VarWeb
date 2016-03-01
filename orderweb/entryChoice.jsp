<!-- 文字コードwindows-31jによるHTML文書 -->

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
<title>受注管理システム</title>
	<script language="JavaScript">
	<!--		
    	function checkForm() {
			if (document.f1.itemCode.value == "" || document.f1.quantity.value == "") {
				alert('商品コードと数量を入力してください');
				document.f1.itemCode.focus();
				return false;
			}
			return true;
		} 
	//-->
	</script>
	
</head>
<body>

	<h1>受注商品選択</h1>
	<form name="f1"  method="get" action="EntryController" onSubmit="return checkForm()">
			商品コード<input type="text" name="itemCode" />
			数量<input type="text" name="quantity" />
			<input type="submit" name= "itemChoice" value='商品選択' /> </br> 
	</form>
	
	<form action="EntryController" method="get" >
			<input type="submit" name='next' value="商品選択確定" /> </br>
			<!-- リセットボタン　-->
			<input type="submit" name='reset' value='リセット' /> </br>
			<input type="submit" name='back' value='戻る' /> </br>
	</form>




	<!-- エラーメッセージ表示 -->
<%  
    ErrorStorage errorCodeX = (ErrorStorage) request.getAttribute("errorCode");
    //エラーコードをget
    int errorCode = errorCodeX.getErrorCode();
    
    if(errorCodeX != null ){
    	String errorMesseage = null;
    	
    	if(errorCode == 1){
    		//エラーメッセージをget
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
			
			
		ArrayList<ItemOrderList> itemOrderList = new ArrayList<ItemOrderList>();
		sessionEntry.ItemOrderPutInList list = (sessionEntry.ItemOrderPutInList) request.getAttribute("list");
		//orderRegistrationで戻るを押された場合,requestでデータを貰わない
		//初期状態で受け取った場合は元々list自体が空なので問題はない
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
		    
		if (list != null) {
			itemOrderList = list.getList();
			for (ItemOrderList it : itemOrderList) {
				totalMoney = it.getTotalMoney();
				tax = it.getTotalTax();
				reqestMoney = it.getReqestMoney();
			}
		}
	%>
			
	<p>合計金額：<%= totalMoney %> 消費税額：<%= tax %> 請求金額：<%= reqestMoney %></p>
	

	
	
	<hr>



	<!--  商品一覧表示  -->

	<p>商品一覧</p>
	<table border=3>
		<tr>
			<td>商品コード</td>
			<td>商品名</td>
			<td>単価</td>
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
					"<tr><td>%d　　　　</td><td>%s</td><td>%s</td></tr>",
					itemCode, itemName ,itemPrice));
		} 
		out.println("</table>");
%>
	
</body>
</html>
