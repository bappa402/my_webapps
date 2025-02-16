<%@ page language="java" import="java.io.*, java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String username = request.getParameter("username");
    String filepath = application.getRealPath("WEB-INF/classes/com/example/user_details.txt");

    if (username != null && !username.trim().isEmpty()) {
        File file = new File(filepath);
        File tempFile = new File(filepath + ".tmp"); // Temporary file

        try {
            BufferedReader reader = new BufferedReader(new FileReader(file));
            BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile));

            String line;
            boolean found = false;

            while ((line = reader.readLine()) != null) {
                if (!line.startsWith(username + ",")) { // Skip the user to remove
                    writer.write(line + System.lineSeparator());
                } else {
                    found = true;
                }
            }

            reader.close();
            writer.close();

            if (found) {
                file.delete(); // Delete old file
                tempFile.renameTo(file); // Rename temp file to original
                out.println("User " + username + " removed successfully!");
            } else {
                tempFile.delete(); // Cleanup if user not found
                out.println("User not found!");
            }

        } catch (IOException e) {
            out.println("Error removing user: " + e.getMessage());
        }
    } else {
        out.println("Invalid username!");
    }
%>

<br><br>
<a href="user_page.jsp"><button>Back</button></a>
