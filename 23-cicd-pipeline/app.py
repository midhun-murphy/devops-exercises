from flask import Flask, render_template, request

app = Flask(__name__)


@app.route("/", methods=["GET", "POST"])
def index():
    result = None
    operation = None
    error = None

    if request.method == "POST":
        try:
            a = float(request.form["num1"])
            b = float(request.form["num2"])
            operation = request.form["operation"]

            if operation == "add":
                result = a + b
                operation = "Addition"

            elif operation == "subtract":
                result = a - b
                operation = "Subtraction"

            elif operation == "multiply":
                result = a * b
                operation = "Multiplication"

            elif operation == "divide":
                if b == 0:
                    error = "Division by zero is not allowed."
                else:
                    result = a / b
                    operation = "Division"

        except ValueError:
            error = "Please enter valid numbers."

    return render_template(
        "index.html",
        result=result,
        operation=operation,
        error=error,
        version="1.0.0"
    )


@app.route("/health")
def health():
    return {"status": "UP"}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)