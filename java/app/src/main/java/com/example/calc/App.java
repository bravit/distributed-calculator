/*
 * This Java source file was generated by the Gradle 'init' task.
 */
package com.example.calc;

import static spark.Spark.*;

public class App {
    public String getGreeting() {
        return "Hello World!";
    }

    public void serve(spark.Request req, spark.Response res) {

    }

    public static void main(String[] args) {
        port(6002);
        post("/add", new AdditionHelper());
        post("/multiply", new MultiplicationHelper());
    }
}
