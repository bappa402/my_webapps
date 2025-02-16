<%@ page language="java" import="java.io.*, java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Grant Payment</title>
</head>
<body>

<%
    String filepath = application.getRealPath("WEB-INF/classes/com/example/user_details.txt");
    String usernameToGrant = request.getParameter("username"); // Get submitted username

    if (usernameToGrant != null && !usernameToGrant.trim().isEmpty()) {
        File file = new File(filepath);
        List<String> updatedLines = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            boolean userFound = false;

            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");

                if (parts.length == 2 && parts[0].trim().equalsIgnoreCase(usernameToGrant.trim())) {
                    line = parts[0] + ",success"; // Change status to 'success'
                    userFound = true;
                }
                updatedLines.add(line);
            }

            if (userFound) {
                try (BufferedWriter bw = new BufferedWriter(new FileWriter(file))) {
                    for (String updatedLine : updatedLines) {
                        bw.write(updatedLine);
                        bw.newLine();
                    }
                    out.println("<p>Status updated successfully for user: <b>" + usernameToGrant + "</b></p>");
                }
            } else {
                out.println("<p>User not found!</p>");
            }

        } catch (IOException e) {
            out.println("<p>Error updating user status.</p>");
        }
    }
%>


<br>
<a href="user_page.jsp"><button>Back</button></a>

</body>
</html>
