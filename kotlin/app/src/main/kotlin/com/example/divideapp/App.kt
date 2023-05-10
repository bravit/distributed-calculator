package com.example.divideapp

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import io.ktor.server.request.*
import kotlinx.serialization.*
import kotlinx.serialization.json.*

class App {
    val greeting: String
        get() {
            return "Hello World!"
        }
}

fun main() {
    embeddedServer(Netty, port = 4002) {
        routing {
            post("/divide") {
                val request = Json.decodeFromString<Operands>(call.receiveText())
                println("Dividing ${request.operandOne} by ${request.operandTwo} (Kotlin)")
                val result = request.operandOne / request.operandTwo
                call.respondText("$result")
            }
        }
    }.start(wait = true)
}
