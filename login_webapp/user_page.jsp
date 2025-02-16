<%@ page language="java" import="com.example.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Page</title>
    <style>
        body {
            font-size: 20px;
        }
        button {
            font-size: 15px;
            padding: 8px;
            color: white;
            background-color: blue;
            margin: 5px;
        }
        table {
            border-collapse: collapse;
            width: 50%;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }
    </style>
</head>
<body>

<%
    if (session.getAttribute("name") == null) {
        String user = request.getParameter("username");
        session.setAttribute("name", user);

        String filepath = application.getRealPath("WEB-INF/classes/com/example/user_details.txt");
        String user_info = UserData.getDetails(user, filepath);
        session.setAttribute("uinfo", user_info);
    }

    String user_info = session.getAttribute("uinfo").toString();
    String username = session.getAttribute("name").toString();
    String filepath = application.getRealPath("WEB-INF/classes/com/example/user_details.txt");

    if (user_info.contains("not found")) {
        out.print("Invalid username");
    } else {
        if (username.toLowerCase().equals("admin")) {
            out.println("Hi Admin<br><br>");
            
            // Create Table Header
            out.println("<table>");
            out.println("<tr><th>Username</th><th>Status</th></tr>");
            
            // Get User List
            String[] users = UserData.getUserList(filepath);
            for (String name : users) {
                if (name != null && !name.equals("admin")) { // Avoid null entries
                    String status = UserData.getDetails(name, filepath).split(",")[1]; // Fetch actual status
                    out.println("<tr><td>" + name + "</td><td>" + status + "</td></tr>");
                }
            }
            
            out.println("</table><br><br>"); // Close table
%>

            <!-- Grant Payment Form -->
            <form action="grant_payment.jsp" method="post">
                <label>Enter user to grant payment:</label>
                <input type="text" name="username" required>
                <button type="submit">Grant</button>
            </form>
            
            <!-- Add User Form -->
            <form action="add_user.jsp" method="post">
                <label>Enter new user:</label>
                <input type="text" name="username" required>
                <button type="submit">Add User</button>
            </form>

            <!-- Remove User Form -->
            <form action="remove_user.jsp" method="post">
                <label>Enter user to remove:</label>
                <input type="text" name="username" required>
                <button type="submit" style="background-color: red;">Remove User</button>
            </form>

<%
        } else {
            String[] infoParts = user_info.split(",");
            if (infoParts.length > 1) {
                out.print("Username: <b>" + username + "</b>");
                out.print("<br>Payment status: <b>" + infoParts[1] + "</b>");
                out.print("<br><br><br>");

                if (infoParts[1].equals("success")) {
                    out.println("<a href='video.jsp'><button>Enjoy Watching Video</button></a>");
                }
                
            } else {
                out.print("Invalid user data format");
            }
        }
    }
%>

<br><br>
<a href="login.jsp"><button>Back</button></a>

</body>
</html>
