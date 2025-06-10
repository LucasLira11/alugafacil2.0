<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>AlugaFácil - Listagem de Aluguéis</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 1200px;
        }
        h1 {
            color: #138443;
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #138443;
            padding-bottom: 10px;
            font-size: 28px;
        }
        
        /* Mensagens de Alerta */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 6px;
            font-weight: 600;
            text-align: center;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* Seção de Pesquisa */
        .search-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 1px solid #e9ecef;
        }
        .search-title {
            color: #138443;
            font-weight: 600;
            margin-bottom: 15px;
            font-size: 18px;
        }
        .search-form {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }
        .search-input {
            flex: 1;
            min-width: 200px;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            font-family: 'Poppins', sans-serif;
        }
        .search-input:focus {
            outline: none;
            border-color: #138443;
            box-shadow: 0 0 5px rgba(19, 132, 67, 0.3);
        }
        .search-buttons {
            display: flex;
            gap: 10px;
        }
        .btn-search {
            background-color: #138443;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Poppins', sans-serif;
        }
        .btn-clear {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Poppins', sans-serif;
        }
        .btn-search:hover {
            background-color: #0e6832;
            transform: translateY(-1px);
        }
        .btn-clear:hover {
            background-color: #5a6268;
            transform: translateY(-1px);
        }
        
        /* Resultados da pesquisa */
        .search-results {
            margin-bottom: 20px;
            padding: 10px 15px;
            background-color: #e8f5e8;
            border-left: 4px solid #138443;
            border-radius: 4px;
        }
        .search-results strong {
            color: #138443;
        }
        
        .no-data {
            text-align: center;
            color: #666;
            font-size: 18px;
            margin: 40px 0;
            padding: 30px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }
        
        /* Tabela */
        .table-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            min-width: 800px;
        }
        th, td {
            padding: 12px 8px;
            border-bottom: 1px solid #ddd;
            font-size: 14px;
        }
        th {
            background-color: #138443;
            color: white;
            font-weight: 600;
            position: sticky;
            top: 0;
        }
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        tr:hover {
            background-color: #e8f5e8;
        }
        
        /* Botões da tabela */
        .btn-delete {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            background-color: #dc3545;
            color: white;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Poppins', sans-serif;
            font-size: 12px;
        }
        .btn-delete:hover {
            background-color: #c82333;
            transform: translateY(-1px);
        }
        
        /* Rodapé */
        .footer-actions {
            margin-top: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        .total-count {
            color: #666;
            font-size: 14px;
        }
        .btn-back {
            background-color: #138443;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Poppins', sans-serif;
        }
        .btn-back:hover {
            background-color: #0e6832;
            transform: translateY(-1px);
        }
        
        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
                align-items: stretch;
            }
            .search-buttons {
                justify-content: center;
            }
            .footer-actions {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🏠 Listagem de Aluguéis</h1>
    
    <div class="search-section">
        <div class="search-title">Pesquisar Aluguéis</div>
        <form class="search-form" action="${pageContext.request.contextPath}/aluguel/listar" method="get">
            <input type="text" name="search" class="search-input" value="${searchTerm}" placeholder="Buscar por nome, CPF, endereço, tipo...">
            <div class="search-buttons">
                <button type="submit" class="btn-search">Pesquisar</button>
                <a href="${pageContext.request.contextPath}/aluguel/listar" class="btn-clear" style="text-decoration: none;">Limpar</a>
            </div>
        </form>
    </div>

    <c:if test="${not empty searchTerm}">
        <div class="search-results">
            Resultados para: <strong>"${searchTerm}"</strong>
        </div>
    </c:if>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Inquilino</th>
                    <th>CPF</th>
                    <th>Imóvel</th>
                    <th>Tipo</th>
                    <th>Valor Aluguel</th>
                    <th>Vencimento</th>
                    <th>Data Pagamento</th>
                    <th>Valor Final</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty alugueis}">
                        <c:forEach var="aluguel" items="${alugueis}">
                            <tr>
                                <td>${aluguel.inquilino.nome}</td>
                                <td>${aluguel.inquilino.cpf}</td>
                                <td>${aluguel.imovel.endereco}</td>
                                <td>${aluguel.imovel.tipo}</td>
                                <td><fmt:formatNumber value="${aluguel.valorAluguel}" type="currency" currencySymbol="R$ "/></td>
                                <td><fmt:formatDate value="${aluguel.dataVencimento}" pattern="dd/MM/yyyy"/></td>
                                <td>
                                    <c:if test="${not empty aluguel.dataPagamento}">
                                        <fmt:formatDate value="${aluguel.dataPagamento}" pattern="dd/MM/yyyy"/>
                                    </c:if>
                                    <c:if test="${empty aluguel.dataPagamento}">
                                        -
                                    </c:if>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${aluguel.calcularValorFinal()}" type="currency" currencySymbol="R$ "/>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/aluguel" method="post" onsubmit="return confirm('Tem certeza que deseja excluir?');">
                                        <input type="hidden" name="action" value="excluir">
                                        <input type="hidden" name="id" value="${aluguel.id}">
                                        <input type="hidden" name="search" value="${searchTerm}">
                                        <button type="submit" class="btn-delete">Excluir</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="9">
                                <div class="no-data">Nenhum aluguel encontrado.</div>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    <div class="footer-actions">
        <div class="total-count">Total de registros: ${alugueis.size()}</div>
        <a href="${pageContext.request.contextPath}/views/menu.jsp" class="btn-back" style="text-decoration: none;">← Voltar ao Menu</a>
    </div>
</div>
</body>
</html>