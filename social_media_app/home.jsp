<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    // Retrieve username from login form
    String username;

    if (session.getAttribute("uname") == null) {
        username = request.getParameter("username");
        session.setAttribute("uname", username);
    } else {
        username = (String) session.getAttribute("uname");
    }

    if (username == null || username.trim().isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get database path
    String dbPath = application.getRealPath("/WEB-INF/socialmedia.db");
    String dbUrl = "jdbc:sqlite:" + dbPath;

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection(dbUrl);

        stmt = conn.prepareStatement("SELECT id FROM users WHERE username = ?");
        stmt.setString(1, username);
        rs = stmt.executeQuery();

        int userId = -1;
        if (rs.next()) {
            userId = rs.getInt("id");
            session.setAttribute("userId", userId);
        } else {
            response.sendRedirect("login.jsp");
            return;
        }
        rs.close();
        stmt.close();
%>


<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
</head>
<body>

    <h2>Welcome, <%= username %>! <span id='friendCount' style="color: blue;">friends count....</span></h2>

    <% if ("admin".equals(username)) { %>
        <h3>Add New User</h3>
        <form action="add_user.jsp" method="post">
            <input type="text" name="new_username" placeholder="Enter new username" required>
            <button type="submit">Add User</button>
        </form>
    <% } %>
    

    <!-- Post Form -->
    <h3>Make a Post</h3>
    <form action="post.jsp" method="post">
        <input type="hidden" name="user_id" value="<%= userId %>">
        <textarea name="post" required></textarea>
        <button type="submit">Post</button>
    </form>

    <!-- View Friend Request -->
    <h3>Friend Request</h3>
    <%
        stmt = conn.prepareStatement("SELECT sender_id, username FROM friend_requests "
            + "JOIN users ON sender_id = id "
            + "WHERE receiver_id = ? AND status = 'pending'");
        stmt.setInt(1, userId);
        rs = stmt.executeQuery();
        
        while (rs.next()) {
    %>
        <p><%= rs.getString("username") %> sent you a friend request.</p>
        <form action="friend_request.jsp" method="post">
            <input type="hidden" name="sender_id" value="<%= rs.getInt("sender_id") %>">
            <input type="hidden" name="receiver_id" value="<%= userId %>">
            <button type="submit" name="action" value="accept">Accept</button>
            <button type="submit" name="action" value="decline">Decline</button>
        </form>
    <% } %>

<!-- see your friends -->
<h3>Your Friends</h3>


<%
int count=0;
    stmt = conn.prepareStatement("SELECT username FROM users WHERE id IN ("
        + " SELECT receiver_id FROM friend_requests WHERE status='accepted' AND sender_id=?"
        + " UNION "
        + " SELECT sender_id FROM friend_requests WHERE status='accepted' AND receiver_id=?)");

    stmt.setInt(1, userId);
    stmt.setInt(2, userId);
    rs = stmt.executeQuery();
    

    while (rs.next()) {
        count++;
        out.print("<p style='color:green'>" + rs.getString("username") + "</p>");
    }
%>

<script>
    document.getElementById("friendCount").innerHTML = " (Friends:  <%= count %>)";
</script>

    <!-- Send Friend Request -->
    <h3>Send Friend Request</h3>
    <form action="friend_request.jsp" method="post">
        <input type="hidden" name="sender_id" value="<%= userId %>">
        <select name="receiver_id">
    <%
        stmt = conn.prepareStatement("SELECT id, username FROM users WHERE id != ? AND id NOT IN ("
            + "SELECT sender_id FROM friend_requests WHERE receiver_id = ? AND status IN ('pending', 'accepted') "
            + "UNION "
            + "SELECT receiver_id FROM friend_requests WHERE sender_id = ? AND status IN ('pending', 'accepted'))");

        stmt.setInt(1, userId);
        stmt.setInt(2, userId);
        stmt.setInt(3, userId);
        rs = stmt.executeQuery();

        while (rs.next()) {
    %>
            <option value="<%= rs.getInt("id") %>"><%= rs.getString("username") %></option>
    <% } %>
        </select>
        <button type="submit" name="action" value="send">Send Request</button>
    </form>

    <!-- View Friend Posts -->
    <h3>Friend Posts</h3>
    <%
        stmt = conn.prepareStatement("SELECT username, post, time_stamp FROM user_posts "
                                   + "JOIN users ON user_posts.user_id = users.id "
                                   + "WHERE user_posts.user_id IN ("
                                   + "SELECT sender_id FROM friend_requests WHERE receiver_id = ? AND status = 'accepted' "
                                   + "UNION SELECT receiver_id FROM friend_requests WHERE sender_id = ? AND status = 'accepted') "
                                   + "ORDER BY time_stamp DESC");
        stmt.setInt(1, userId);
        stmt.setInt(2, userId);
        rs = stmt.executeQuery();

        while (rs.next()) {
    %>
        <p><strong><%= rs.getString("username") %></strong>: <%= rs.getString("post") %> <i>(<%= rs.getString("time_stamp") %>)</i></p>
    <% } %>

</body>
</html>

<%
    } catch (Exception e) {
        out.println("Database error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<a href="login.jsp"><button>back</button></a>
