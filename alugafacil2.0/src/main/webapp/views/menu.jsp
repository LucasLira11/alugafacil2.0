<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>AlugaFacil - Menu Simples</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f8;
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header {
            background-color: white;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .logo {
            width: 180px;
            margin-bottom: 10px;
        }

        .menu-buttons {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            padding: 40px 20px;
            flex-grow: 1;
        }

        .menu-button {
            background-color: white;
            color: #138443;
            border: 2px solid #138443;
            border-radius: 8px;
            padding: 15px 0;
            width: 80%;
            max-width: 300px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
        }

        .menu-button:hover {
            background-color: #138443;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        footer {
            background-color: #138443;
            color: white;
            text-align: center;
            padding: 15px;
            font-size: 14px;
            margin-top: auto;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>AlugaFacil</h1>
        <p>Sistema de Gerenciamento de Alugueis</p>
    </div>
    
    <div class="menu-buttons">
        <a href="/alugafacil/inquilino/listar" class="menu-button">Manter Inquilinos</a>
        <a href="/alugafacil/imovel/listar" class="menu-button">Manter Imoveis</a>
        <a href="registrarInquilino.jsp" class="menu-button">Registrar Inquilino</a>
        <a href="registrarImovel.jsp" class="menu-button">Registrar Imovel</a>
        <a href="/alugafacil/aluguel/registrar" class="menu-button">Registrar Aluguel</a>
        <a href="/alugafacil/aluguel/listar" class="menu-button">Listar todos os dados</a>
    </div>
    
    <footer>
        <p>&copy; 2024 AlugaFacil - Sistema de Gerenciamento de Alugueis</p>
    </footer>
</body>
</html>