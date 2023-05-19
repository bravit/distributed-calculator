package com.example.calc;

import spark.Request;
import spark.Response;
import com.fasterxml.jackson.databind.ObjectMapper;

class MultiplicationHelper implements spark.Route {
    @Override
    public Object handle(Request request, Response response) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        Operands ops = mapper.readValue(request.body(), Operands.class);
        System.out.printf("Calculating %2.1f * %2.1f%n", ops.operandOne, ops.operandTwo);
        return Float.toString(ops.operandOne * ops.operandTwo);
    }
}