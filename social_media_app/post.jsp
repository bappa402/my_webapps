<%@ page import="java.sql.*" %>
<%
    int userId = Integer.parseInt(request.getParameter("user_id"));
    String postText = request.getParameter("post");

    // Get the real path of the database inside WEB-INF
    String dbPath = application.getRealPath("/WEB-INF/socialmedia.db");
    String dbUrl = "jdbc:sqlite:" + dbPath;

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Establish database connection
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection(dbUrl);

        // Insert the post into the database
        stmt = conn.prepareStatement("INSERT INTO user_posts (user_id, post, time_stamp) VALUES (?, ?, datetime('now', 'localtime'))");
        stmt.setInt(1, userId);
        stmt.setString(2, postText);
        stmt.executeUpdate();

        response.sendRedirect("home.jsp"); // Redirect back to home page

    } catch (Exception e) {
        out.println("Database error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        // Close resources
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
