<html>
<head>
    <title>Calculation Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            text-align: center;
            padding: 50px;
        }
        .container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            display: inline-block;
            padding: 30px;
            width: 300px;
        }
        h2 {
            color: #333;
        }
        p {
            font-size: 24px;
            color: #27ae60;
            font-weight: bold;
        }
        .icon {
            width: 50px;
            height: 50px;
        }
        .result-icon {
            margin-top: 20px;
            margin-bottom: 20px;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #3498db;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        a:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Calculation Result</h2>
        <div class="result-icon">
            <img src="calculator_icon.svg" alt="Calculator Icon" class="icon" />
        </div>
        <p>The result is: ${result}</p>
        <a href="index.jsp">Back to Calculator</a>
    </div>
</body>
</html>
