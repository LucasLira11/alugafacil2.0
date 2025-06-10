<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Imóvel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <h1>✏️ Editar Imóvel</h1>
    <form action="${pageContext.request.contextPath}/imovel" method="post">
        <input type="hidden" name="action" value="alterar">
        <input type="hidden" name="id" value="${imovel.id}">

        <div class="form-group">
            <label for="endereco">Endereço:</label>
            <input type="text" id="endereco" name="endereco" value="${imovel.endereco}" required>
        </div>
        <div class="form-group">
            <label for="tipo">Tipo:</label>
            <input type="text" id="tipo" name="tipo" value="${imovel.tipo}" required>
        </div>
        <div class="form-group">
            <label for="valorAluguel">Valor do Aluguel:</label>
            <input type="number" step="0.01" id="valorAluguel" name="valorAluguel" value="${imovel.valorAluguel}" required>
        </div>
        <div class="buttons">
            <a href="${pageContext.request.contextPath}/imovel/listar" class="btn btn-secondary" style="text-decoration: none;">Cancelar</a>
            <button type="submit" class="btn btn-primary">Salvar Alterações</button>
        </div>
    </form>
</div>
</body>
</html>