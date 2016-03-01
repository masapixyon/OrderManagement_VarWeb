<!-- 文字コードwindows-31jによるHTML文書 -->

<%@page contentType="text/html" pageEncoding="windows-31j"%>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="java.util.*"%>
<%@page import="sessionEntry.EntryController" %>
<%@page import="sessionEntry.ItemOrderPutInList" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-31j" />
<title>削除完了</title>
</head>
<body>
	
	<p>受注を削除しました</p>
	<form action="OrderDetailController" method="post" >
			<input type="submit" name='backToPrimary' value='戻る' /> </br>
	</form>

</body>
</html>
