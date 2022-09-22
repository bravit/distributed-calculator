package com.example.adderapp;

import spark.Request;
import spark.Response;
import com.google.gson.Gson;

class AdditionHelper implements spark.Route {
    @Override
    public Object handle(Request request, Response response) {
        Gson gson = new Gson();
        Operands ops = gson.fromJson(request.body(), Operands.class);
        System.out.printf("Calculating %2.1f + %2.1f%n", ops.operandOne, ops.operandTwo);
        return Float.toString(ops.operandOne + ops.operandTwo);
    }
}