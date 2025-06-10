<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>Dados do Inquilino</title>
</head>
<body>
    <h1>Dados Registrados:</h1>
    <p><strong>Nome:</strong> ${inquilino.nome}</p>
    <p><strong>CPF:</strong> ${inquilino.cpf}</p>
    <p><strong>Telefone:</strong> ${inquilino.telefone}</p>
    <form action="${pageContext.request.contextPath}/views/menu.jsp" style="margin-top: 20px;">
        <input type="submit" value="Voltar ao Menu Principal">
    </form>    
</body>
</html>
