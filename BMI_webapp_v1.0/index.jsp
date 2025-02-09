<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>BMI Calculator</title>
</head>
<body>
    <h2>BMI Calculator</h2>
    <form action="result.jsp" method="post">
        <label>Weight (kg):</label>
        <input type="text" name="weight" required><br><br>
        <label>Height (cm):</label>
        <input type="text" name="height" required><br><br>
        <input type="submit" value="Calculate BMI">
    </form>
</body>
</html>
