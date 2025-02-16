<%@ page language="java" import="com.example.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>login page</title>
    </head>
    <body>
       <%
       String username = session.getAttribute("name").toString();
       %>

       <p>Hi <b><%= username%></b></p>
       <p>you are offered a package of 5 LPA. here are the details below...........</p>

       <a href="user_page.jsp"><button style="color:white; background-color: blue;">back</button></a>
        
    </body>
</html>