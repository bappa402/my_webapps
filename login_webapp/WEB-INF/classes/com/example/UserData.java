package com.example;

import java.io.*;
import java.util.Scanner;

public class UserData {
    public static void insertData(String name, String city) {
        System.out.println(name + "," + city);
    }

    public static String getCurrentPath(){
        return "current path of java class is: "+ System.getProperty("user.dir");
    }


    public static String[] getUserList(String filepath){
        File file = new File(filepath);
        String users[] = new String[100];
        int i=0;

        try (Scanner sc = new Scanner(file)) { // Try-with-resources (closes Scanner automatically)
            while (sc.hasNextLine() && i < users.length) {
                String line = sc.nextLine();
                users[i] = line.split(",")[0];
                i++;
                
            }
            return users;
        } catch (FileNotFoundException e) {
            System.out.println("file not found");
            return null;
        }
    }

    public static String getDetails(String name, String filepath) {
        File file = new File(filepath);
        try (Scanner sc = new Scanner(file)) { // Try-with-resources (closes Scanner automatically)
            while (sc.hasNextLine()) {
                String line = sc.nextLine();

                if (line.contains(name + ","))
                    return line;

            }
            return "user not found";
        } catch (FileNotFoundException e) {
            return "file not found";
        }

    }

    void main() {
        // insertData("bappa", "kolkata");
        String filepath = "example\\user_details.txt";
        for (String s: getUserList(filepath)){
            System.out.println(s);
        }
        //System.out.println(getCurrentPath());
        
    }
}