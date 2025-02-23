<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String action = request.getParameter("action");
    String senderIdStr = request.getParameter("sender_id");
    String receiverIdStr = request.getParameter("receiver_id");

    // Validate input to prevent errors
    if (senderIdStr == null || receiverIdStr == null || senderIdStr.isEmpty() || receiverIdStr.isEmpty()) {
        response.sendRedirect("home.jsp");
        return;
    }
    
    int senderId = Integer.parseInt(senderIdStr);
    int receiverId = Integer.parseInt(receiverIdStr);

    String dbPath = application.getRealPath("/WEB-INF/socialmedia.db");
    String dbUrl = "jdbc:sqlite:" + dbPath;

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection(dbUrl);

        if ("send".equals(action)) {
            // Ensure receiverId is a valid user
            stmt = conn.prepareStatement("SELECT id FROM users WHERE id = ?");
            stmt.setInt(1, receiverId);
            ResultSet userCheck = stmt.executeQuery();
            if (!userCheck.next()) {
                response.sendRedirect("home.jsp");
                return;
            }

            // Check if a request already exists
            stmt = conn.prepareStatement("SELECT status FROM friend_requests WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)");
            stmt.setInt(1, senderId);
            stmt.setInt(2, receiverId);
            stmt.setInt(3, receiverId);
            stmt.setInt(4, senderId);
            ResultSet checkRs = stmt.executeQuery();

            if (checkRs.next()) {
                String status = checkRs.getString("status");
                if ("pending".equals(status) || "accepted".equals(status)) {
                    response.sendRedirect("home.jsp");
                    return;
                }
            }

            // Insert new request if none exists or previous was declined
            stmt = conn.prepareStatement("INSERT INTO friend_requests (sender_id, receiver_id, status) VALUES (?, ?, 'pending')");
            stmt.setInt(1, senderId);
            stmt.setInt(2, receiverId);
            stmt.executeUpdate();

        } else {
            String status = "accept".equals(action) ? "accepted" : "declined";
            stmt = conn.prepareStatement("UPDATE friend_requests SET status = ? WHERE sender_id = ? AND receiver_id = ?");
            stmt.setString(1, status);
            stmt.setInt(2, senderId);
            stmt.setInt(3, receiverId);
            stmt.executeUpdate();
        }
        
        response.sendRedirect("home.jsp");

    } catch (Exception e) {
        out.println("Database error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
