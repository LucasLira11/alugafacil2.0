<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Manter Imóveis</title>
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
    margin-top: 20px;
}
h1 {
    color: #138443;
    text-align: center;
    font-size: 28px;
    margin-bottom: 25px;
    padding-bottom: 10px;
    border-bottom: 2px solid #138443;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
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
input[type="number"],
input[type="date"] {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
}
input[type="text"]:focus,
input[type="number"]:focus,
input[type="date"]:focus {
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
}
.btn-clear:hover {
    background-color: #5a6268;
}

/* Tabela */
.table-container {
    overflow-x: auto;
}
table {
    width: 100%;
    border-collapse: collapse;
    text-align: left; /* Alinhamento geral para a esquerda */
    min-width: 800px;
}
th, td {
    padding: 15px 10px; /* Mais preenchimento vertical */
    border-bottom: 1px solid #ddd;
    font-size: 14px;
    vertical-align: middle; /* <<-- ESTA É A CORREÇÃO PRINCIPAL -->> */
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

/* Botões da tabela e Ações */
.action-buttons-container {
    display: flex;
    gap: 10px;
    justify-content: flex-start; /* Alinha botões à esquerda na célula */
    align-items: center;
}
.action-buttons-container form {
    margin: 0; /* Remove margem do formulário de exclusão */
}
.btn-add {
    background-color: #138443;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
    text-decoration: none;
    display: inline-block;
}
.btn-add:hover {
    background-color: #0e6832;
}
.btn-edit {
    padding: 6px 12px;
    border-radius: 4px;
    font-weight: 600;
    background-color: #6c757d;
    color: white;
    text-decoration: none;
    transition: all 0.3s;
    font-size: 12px;
}
.btn-edit:hover {
    background-color: #5a6268;
}
.btn-delete {
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    font-weight: 600;
    background-color: #dc3545;
    color: white;
    cursor: pointer;
    transition: all 0.3s;
    font-size: 12px;
}
.btn-delete:hover {
    background-color: #c82333;
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

/* Rodapé */
.footer-actions {
    margin-top: 25px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 15px;
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
}
.btn-back:hover {
    background-color: #0e6832;
}
    </style>
</head>
<body>
<div class="container">
    <h1>🏘️ Manter Imóveis</h1>

    <div class="footer-actions" style="justify-content: flex-start; margin-bottom: 20px;">
        <a href="${pageContext.request.contextPath}/imovel/registrar" class="btn-add">+ Adicionar Novo Imóvel</a>
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Endereço</th>
                <th>Tipo</th>
                <th>Valor do Aluguel</th>
                <th style="width: 200px;">Ações</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty listaImoveis}">
                    <c:forEach var="imovel" items="${listaImoveis}">
                        <tr>
                            <td>${imovel.id}</td>
                            <td>${imovel.endereco}</td>
                            <td>${imovel.tipo}</td>
                            <td><fmt:formatNumber value="${imovel.valorAluguel}" type="currency" currencySymbol="R$ "/></td>
                            <td>
                                <div class="action-buttons-container">
                                    <a href="${pageContext.request.contextPath}/imovel/editar?id=${imovel.id}" class="btn-edit">Editar</a>
                                    <form action="${pageContext.request.contextPath}/imovel" method="post" onsubmit="return confirm('Tem certeza que deseja excluir este imóvel?');">
                                        <input type="hidden" name="action" value="excluir">
                                        <input type="hidden" name="id" value="${imovel.id}">
                                        <button type="submit" class="btn-delete">Excluir</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5">
                            <div class="no-data">Nenhum imóvel cadastrado.</div>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <div class="footer-actions">
        <a href="${pageContext.request.contextPath}/views/menu.jsp" class="btn-back" style="text-decoration: none;">← Voltar ao Menu</a>
    </div>
</div>
</body>
</html>