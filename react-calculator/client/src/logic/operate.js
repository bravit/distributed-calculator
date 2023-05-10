const operationMap = {
  "+ (Java)": "java/add",
  "+ (Go)": "go/add",
  "- (C#)": "csharp/subtract",
  "- (PHP)": "php/subtract",
  "x (Python)": "python/multiply",
  "x (Rust)": "rust/multiply",
  "÷ (NodeJS)": "node/divide",
  "÷ (Kotlin)": "kotlin/divide"
};

export default async function operate(operandOne, operandTwo, operationSymbol) {

  operandOne = operandOne || "0";
  operandTwo = operandTwo || (operationSymbol === "÷" || operationSymbol === 'x' ? "1" : "0"); //If dividing or multiplying, then 1 maintains current value in cases of null

  const operation = operationMap[operationSymbol];
  console.log(`Calling ${operation} service`);

  const rawResponse = await fetch(`/calculate/${operation}`, {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      operandOne,
      operandTwo
    }),
  });
  const response = await rawResponse.json();

  return response.toString();
}