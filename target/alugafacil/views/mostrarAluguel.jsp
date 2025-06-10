<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>AlugaFácil - Dados do Aluguel Registrado</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap">
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
            max-width: 800px;
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
        h2 {
            color: #138443;
            font-size: 20px;
            margin-top: 25px;
            margin-bottom: 15px;
            border-left: 4px solid #138443;
            padding-left: 15px;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 6px;
            border: 1px solid #c3e6cb;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
        }
        .info-group {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 6px;
            border-left: 4px solid #138443;
        }
        .info-item {
            margin-bottom: 10px;
            display: flex;
            flex-wrap: wrap;
        }
        .info-item:last-child {
            margin-bottom: 0;
        }
        .info-label {
            font-weight: 600;
            color: #555;
            min-width: 180px;
            margin-right: 10px;
        }
        .info-value {
            color: #333;
            flex: 1;
        }
        .valor-final {
            background-color: #138443;
            color: white;
            padding: 15px;
            border-radius: 6px;
            text-align: center;
            font-size: 18px;
            font-weight: 600;
            margin: 20px 0;
        }
        .buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
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
            text-decoration: none;
            display: inline-block;
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
    <h1>Aluguel Registrado com Sucesso!</h1>
    
    <div class="success-message">
        ✅ O aluguel foi registrado com sucesso no sistema AlugaFácil
    </div>

    <div class="info-group">
        <h2>Dados do Inquilino</h2>
        <div class="info-item">
            <span class="info-label">Nome:</span>
            <span class="info-value">${aluguel.inquilino.nome}</span>
        </div>
        <div class="info-item">
            <span class="info-label">CPF:</span>
            <span class="info-value">${aluguel.inquilino.cpf}</span>
        </div>
        <div class="info-item">
            <span class="info-label">Telefone:</span>
            <span class="info-value">${aluguel.inquilino.telefone}</span>
        </div>
    </div>

    <div class="info-group">
        <h2>Dados do Imóvel</h2>
        <div class="info-item">
            <span class="info-label">Endereço:</span>
            <span class="info-value">${aluguel.imovel.endereco}</span>
        </div>
        <div class="info-item">
            <span class="info-label">Tipo:</span>
            <span class="info-value">${aluguel.imovel.tipo}</span>
        </div>
        <div class="info-item">
            <span class="info-label">Valor do Imóvel:</span>
            <span class="info-value">R$ <fmt:formatNumber value="${aluguel.imovel.valorAluguel}" type="currency" currencySymbol="" maxFractionDigits="2"/></span>
        </div>
    </div>

    <div class="info-group">
        <h2>Dados do Aluguel</h2>
        <div class="info-item">
            <span class="info-label">Valor do Aluguel:</span>
            <span class="info-value">R$ <fmt:formatNumber value="${aluguel.valorAluguel}" type="currency" currencySymbol="" maxFractionDigits="2"/></span>
        </div>
        <div class="info-item">
            <span class="info-label">Data de Vencimento:</span>
            <span class="info-value"><fmt:formatDate value="${aluguel.dataVencimento}" pattern="dd/MM/yyyy"/></span>
        </div>
        <div class="info-item">
            <span class="info-label">Data de Pagamento:</span>
            <span class="info-value"><fmt:formatDate value="${aluguel.dataPagamento}" pattern="dd/MM/yyyy"/></span>
        </div>
        <div class="info-item">
            <span class="info-label">Multa (%):</span>
            <span class="info-value">${aluguel.multaPorcentagem}%</span>
        </div>
        <div class="info-item">
            <span class="info-label">Juros ao dia (%):</span>
            <span class="info-value">${aluguel.jurosPorDia}%</span>
        </div>
    </div>

    <div class="valor-final">
        💰 Valor Final (com Multa e Juros): R$ <fmt:formatNumber value="${aluguel.valorFinal}" type="currency" currencySymbol="" maxFractionDigits="2"/>
    </div>

    <div class="buttons">
        <a href="${pageContext.request.contextPath}/views/menu.jsp" class="btn btn-secondary">Voltar ao Menu</a>
        <a href="${pageContext.request.contextPath}/listarAlugueis" class="btn btn-primary">Ver Todos os Aluguéis</a>
    </div>
</div>
</body>
</html>