#include <crow_all.h>

int main()
{
  crow::SimpleApp app;

  CROW_ROUTE(app, "/")([](){
  return "Hello world";
  });
  
  CROW_ROUTE(app, "/add").methods("POST"_method)
  ([](const crow::request& req){
      auto x = crow::json::load(req.body);
      if (!x)
        return crow::response(crow::status::BAD_REQUEST); // same as crow::response(400)
      int sum = x["operandOne"].i()+x["operandTwo"].i();
      std::ostringstream os;
      os << sum;
      return crow::response{os.str()};
  });

  CROW_ROUTE(app, "/subtract").methods("POST"_method)
  ([](const crow::request& req){
    auto x = crow::json::load(req.body);
    if (!x)
      return crow::response(crow::status::BAD_REQUEST); // same as crow::response(400)
    int sum = x["operandOne"].i()-x["operandTwo"].i();
    std::ostringstream os;
    os << sum;
    return crow::response{os.str()};
  });


  app.port(6003).multithreaded().run();
}