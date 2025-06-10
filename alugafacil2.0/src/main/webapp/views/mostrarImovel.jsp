<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>Dados do Imóvel</title>
</head>
<body>
    <h1>Dados do Imóvel Registrado:</h1>
    <p><strong>Endereço:</strong> ${imovel.endereco}</p>
    <p><strong>Tipo:</strong> ${imovel.tipo}</p>
    <p><strong>Valor do Aluguel:</strong> R$ ${imovel.valorAluguel}</p>
    <form action="${pageContext.request.contextPath}/views/menu.jsp" style="margin-top: 20px;">
        <input type="submit" value="Voltar ao Menu Principal">
    </form>    
</body>
</html>
