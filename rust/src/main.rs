use actix_web::{post, web, App, HttpServer, Responder};
use serde::Deserialize;
use serde_aux::prelude::*;

#[derive(Deserialize)]
#[serde(rename_all = "camelCase")]
struct Operands {
    #[serde(deserialize_with = "deserialize_number_from_string")]
    operand_one: f32,
    #[serde(deserialize_with = "deserialize_number_from_string")]
    operand_two: f32
}

#[post("/multiply")]
async fn multiply(operands: web::Json<Operands>) -> impl Responder {
    println!("Calculating {} * {} with Rust", operands.operand_one, operands.operand_two);
    serde_json::to_string(&(operands.operand_one * operands.operand_two))
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new().service(multiply)
    })
    .bind(("127.0.0.1", 5002))?
    .run()
    .await
}