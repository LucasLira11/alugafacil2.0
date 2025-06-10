<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Inquilino</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <h1>✏️ Editar Inquilino</h1>
    <form action="${pageContext.request.contextPath}/inquilino" method="post">
        <input type="hidden" name="action" value="alterar">
        <input type="hidden" name="id" value="${inquilino.id}">

        <div class="form-group">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" value="${inquilino.nome}" required>
        </div>
        <div class="form-group">
            <label for="cpf">CPF:</label>
            <input type="text" id="cpf" name="cpf" value="${inquilino.cpf}" required>
        </div>
        <div class="form-group">
            <label for="telefone">Telefone:</label>
            <input type="text" id="telefone" name="telefone" value="${inquilino.telefone}" required>
        </div>
        <div class="buttons">
            <a href="${pageContext.request.contextPath}/inquilino/listar" class="btn btn-secondary" style="text-decoration: none;">Cancelar</a>
            <button type="submit" class="btn btn-primary">Salvar Alterações</button>
        </div>
    </form>
</div>
</body>
</html>