<%@ page contentType="text/html; charset=Windows-31J" %>
<%@ page pageEncoding="Windows-31J" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
		<meta http-equiv="Context-Type" content="text/html"; charset="utf-8" > 
     <title>受注管理システム</title>
   </head>
 <body>
 <h1>受注管理システム</h1>
 <form action="./OrderSelectController" method="post">
 <p>
     顧客名:<input type="text" name="searchWord" />
     <input type="submit" value="受注検索" />
 </p>
 </form>
 <form>
 <p>
     <input type="button" onclick="location.href='entryChoice.jsp'" value="受注登録">

 </p>
 </form>
 </body>
 </html>