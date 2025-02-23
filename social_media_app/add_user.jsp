<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    // Ensure the user is logged in and is 'admin'
    String adminUser = (String) session.getAttribute("uname");
    if (!"admin".equals(adminUser)) {
        response.sendRedirect("home.jsp");
        return;
    }

    // Get new username from form
    String newUsername = request.getParameter("new_username");

    // Database path
    String dbPath = application.getRealPath("/WEB-INF/socialmedia.db");
    String dbUrl = "jdbc:sqlite:" + dbPath;

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Establish database connection
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection(dbUrl);

        // Insert new user into the database
        stmt = conn.prepareStatement("INSERT INTO users (username) VALUES (?)");
        stmt.setString(1, newUsername);
        stmt.executeUpdate();

        out.println("<p>User added successfully!</p>");
        response.sendRedirect("home.jsp");

    } catch (Exception e) {
        out.println("Database error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
