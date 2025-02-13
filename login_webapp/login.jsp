<%@ page language="java" import="com.example.BMICalculator" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
session.invalidate();
%>

<!DOCTYPE html>
<html>
<head>
    <title>login page</title>
</head>
<body>
    <h2>Log in to our portal</h2>
    <form action="user_page.jsp" method="post">
        <label>username:</label>
        <input type="text" name="username">
        <br>
        <input type="submit" value="login">
    </form>
    <br><br>

   

</body>
</html>
