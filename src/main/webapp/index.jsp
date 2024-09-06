<html>
<head>
    <title>Faisal's Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e0e0e0;
            text-align: center;
            padding: 50px;
        }
        .container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            display: inline-block;
            padding: 30px;
            width: 350px;
        }
        h2 {
            color: #333;
            margin-bottom: 30px;
        }
        .input-group {
            margin-bottom: 20px;
        }
        input[type="text"] {
            padding: 10px;
            width: calc(100% - 22px);
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        select {
            padding: 10px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            margin-bottom: 20px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #2980b9;
        }
        .calculator-icon {
            margin-bottom: 30px;
        }
        .calculator-icon img {
            width: 80px;
            height: 80px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="calculator-icon">
            <img src="./calculator_icon.svg" alt="Calculator Icon" />
        </div>
        <h2>Simple Calculator</h2>
        <form action="calculate" method="post">
            <div class="input-group">
                <input type="text" name="num1" placeholder="First Number" required />
            </div>
            <div class="input-group">
                <select name="operation">
                    <option value="add">+</option>
                    <option value="subtract">-</option>
                    <option value="multiply">*</option>
                    <option value="divide">/</option>
                </select>
            </div>
            <div class="input-group">
                <input type="text" name="num2" placeholder="Second Number" required />
            </div>
            <input type="submit" value="Calculate" />
        </form>
    </div>
</body>
</html>
