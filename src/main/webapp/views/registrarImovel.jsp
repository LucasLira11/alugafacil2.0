<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Registrar Novo Imóvel</title>
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f8;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            width: 90%;
            max-width: 500px;
            margin-top: 20px;
        }

        h1 {
            color: #138443;
            text-align: center;
            font-size: 28px;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #138443;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        input[type="text"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: #138443;
            box-shadow: 0 0 5px rgba(19, 132, 67, 0.3);
        }

        .buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Poppins', sans-serif;
        }

        .btn-primary {
            background-color: #138443;
            color: white;
        }

        .btn-secondary {
            background-color: #f4f6f8;
            color: #555;
            border: 1px solid #ddd;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .btn-primary:hover {
            background-color: #0e6832;
        }

        .btn-secondary:hover {
            background-color: #e9ecef;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>➕ Registrar Novo Imóvel</h1>
    
    <form action="${pageContext.request.contextPath}/imovel" method="post">
        <input type="hidden" name="action" value="registrar">
        
        <div class="form-group">
            <label for="endereco">Endereço:</label>
            <input type="text" id="endereco" name="endereco" required>
        </div>
        <div class="form-group">
            <label for="tipo">Tipo:</label>
            <input type="text" id="tipo" name="tipo" required>
        </div>
        <div class="form-group">
            <label for="valorAluguel">Valor do Aluguel:</label>
            <input type="number" step="0.01" id="valorAluguel" name="valorAluguel" required>
        </div>
        <div class="buttons">
            <a href="${pageContext.request.contextPath}/imovel/listar" class="btn btn-secondary" style="text-decoration: none;">Cancelar</a>
            <button type="submit" class="btn btn-primary">Registrar</button>
        </div>
    </form>
</div>
</body>
</html>