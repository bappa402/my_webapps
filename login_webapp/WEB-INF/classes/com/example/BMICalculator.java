package com.example;

public class BMICalculator {
    public static double getBMI(double weight, double height) {
        if (height <= 0) throw new IllegalArgumentException("Height must be greater than zero.");
        height = height / 100;
        return weight / (height * height);
    }
}
