<%@ page language="java" import="com.example.BMICalculator" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>BMI Calculator</title>
</head>
<body>
    <h2>BMI Calculator</h2>
    <form method="post">
        <label>Weight (kg):</label>
        <input type="text" name="weight" value="<%= request.getParameter("weight") != null ? request.getParameter("weight") : "" %>" required>
        <br><br>
        <label>Height (cm):</label>
        <input type="text" name="height" value="<%= request.getParameter("height") != null ? request.getParameter("height") : "" %>" required>
        <br><br>
        <input type="submit" value="Calculate BMI">
    </form>
    <br><br>

    <%
        try {
            double weight = Double.parseDouble(request.getParameter("weight"));
            double height = Double.parseDouble(request.getParameter("height"));
            double bmi = BMICalculator.getBMI(weight, height);
            String bodyType, colorClass;
            if (bmi<18)  bodyType="underweight";
            else if (bmi > 25) bodyType="obese";
            else bodyType="normal";

            colorClass = (bodyType=="normal") ? "green" : "red";
    %>
            <p>Your BMI is: <%= bmi %></p>
            <p >Your body type is: <span style="color : <%= colorClass %>"><%= bodyType %></span></p>

            
    <%
        } catch (Exception e) { if (!e.toString().contains("NullPointerException")) {
    %>
            <p>Invalid input. Please enter valid numbers.</p>
    <%
        }}
    %>

</body>
</html>
