from flask import Flask, render_template, request

app = Flask(__name__)

def factorial(n):
    if n < 0:
        raise ValueError("Negative numbers are not allowed")

    result = 1

    for i in range(2, n + 1):
        result *= i

    return result

@app.route("/", methods=["GET", "POST"])
def home():
    answer = None

    if request.method == "POST":
        number = int(request.form["number"])
        answer = factorial(number)

    return render_template("index.html", answer=answer)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)