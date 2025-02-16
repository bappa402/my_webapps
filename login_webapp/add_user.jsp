<%@ page language="java" import="java.io.*, java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String username = request.getParameter("username");
    String filepath = application.getRealPath("WEB-INF/classes/com/example/user_details.txt");

    if (username != null && !username.trim().isEmpty()) {
        try {
            File file = new File(filepath);
            FileWriter fw = new FileWriter(file, true); // Append mode
            BufferedWriter bw = new BufferedWriter(fw);
            PrintWriter pw = new PrintWriter(bw);

            pw.println(username + ",unpaid"); // Add user with unpaid status
            pw.close();
            out.println("User " + username + " added successfully!");

        } catch (IOException e) {
            out.println("Error adding user: " + e.getMessage());
        }
    } else {
        out.println("Invalid username!");
    }
%>

<br><br>
<a href="user_page.jsp"><button>Back</button></a>
