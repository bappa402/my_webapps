<%@ page language="java" import="com.example.BMICalculator" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>BMI Result</title>
</head>
<body>
    <h2>BMI Calculation Result</h2>
    <%
        try {
            double weight = Double.parseDouble(request.getParameter("weight"));
            double height = Double.parseDouble(request.getParameter("height"));
            double bmi = BMICalculator.getBMI(weight, height);
            String bodyType;
            if (bmi<18)  bodyType="underweight";
            else if (bmi > 25) bodyType="obese";
            else bodyType="normal";
    %>
            <p>Your BMI is: <%= bmi %></p>
            <p>Your body type is: <%= bodyType %></p>
    <%
        } catch (Exception e) {
    %>
            <p>Invalid input. Please enter valid numbers.</p>
    <%
        }
    %>
    <br>
    <a href="index.jsp">Back</a>
</body>
</html>
