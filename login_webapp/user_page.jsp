<%@ page language="java" import="com.example.UserData" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>login page</title>
    </head>
    <body>
       

        <%
        if (session.getAttribute("name") == null) {
        
            String user = request.getParameter("username");

            String[] name = {"bappa", "pranit", "rikon"};
            String[] city = {"kolkata", "bangalore", "delhi"};
            int[] offered = {1,1,0};
            String user_city="null";
            int offer_status=-1;

            for (int i=0; i< name.length; i++){
                
                if(name[i].equals(user)){
                user_city = city[i];
                offer_status = offered[i];
                break;
                }
            }

            session.setAttribute("name", user);
            session.setAttribute("city", user_city);
            session.setAttribute("ofsts", offer_status);
        }

            String filepath = application.getRealPath("WEB-INF/classes/com/example/user_details.txt") ;
            String result = UserData.getDetails("bappa", filepath);
            out.print("hi, your gift is a "+ result.split(",")[1] + ".   ");

        //nothing occured in loop, username not found
        if ((Integer) session.getAttribute("ofsts") == -1) 
            out.print("please enter valid username.");
        else{
        %>

        <h2>hi <%= session.getAttribute("name").toString()%></h2>
        <h2>your interview location was  <%= session.getAttribute("city").toString()%></h2>

        <%
        if ((Integer) session.getAttribute("ofsts") == 1) {
            %>
            <p>Congratulations, you are selected for the job. </p>
            <a href="offer.jsp"><button style="color:white; background-color: green;"> Check offer letter </button></a>
        <%
        }
    }
        %>
    <br><br>
        <a href="login.jsp"><button style="color:white; background-color: blue;"> back </button></a>
    </body>
</html>