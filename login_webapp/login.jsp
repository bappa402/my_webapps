<%@ page language="java" import="com.example.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
session.invalidate();
%>

<!DOCTYPE html>
<html>
<head>
    <title>login page</title>
    <style>
        body {
            font-size: 20px; /* Change default font size */
        }

        
        button{
                font-size: 15px;
                padding: 8px;
                color:white; 
                background-color: blue
            }
    </style>
</head>
<body>
    <h2>Log in to our portal</h2>
    <form action="user_page.jsp" method="post">
        <label>username:</label>
        <input type="text" name="username">
        <br><br><br>
        <button type="submit">Login</button>
    </form>
    <br><br>

   

</body>
</html>
