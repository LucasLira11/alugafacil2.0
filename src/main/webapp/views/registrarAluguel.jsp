<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Registrar Aluguel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
        input[type="number"],
        input[type="date"],
        select {
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
        input[type="date"]:focus,
        select:focus {
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
    <h1>📝 Registrar Novo Aluguel</h1>

    <form action="${pageContext.request.contextPath}/aluguel" method="post">
        <input type="hidden" name="action" value="registrar">

        <div class="form-group">
            <label for="inquilinoId">Inquilino:</label>
            <select id="inquilinoId" name="inquilinoId" required>
                <option value="">Selecione um inquilino...</option>
                <c:forEach var="inquilino" items="${inquilinos}">
                    <option value="${inquilino.id}">${inquilino.nome} (CPF: ${inquilino.cpf})</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group-inline">
            <div class="form-group">
                <label for="imovelId">Imóvel:</label>
                <select id="imovelId" name="imovelId" onchange="atualizarCamposImovel()" required>
                    <option value="" data-valor="">Selecione um imóvel...</option>
                    <c:forEach var="imovel" items="${imoveis}">
                        <%-- O truque está aqui: guardamos o valor do aluguel em um atributo data-* --%>
                        <option value="${imovel.id}" data-valor="${imovel.valorAluguel}">
                            ${imovel.endereco}
                        </option>
                    </c:forEach>
                </select>

        <div class="form-group">
            <label for="valorAluguel">Valor do Aluguel (R$):</label>
            <input type="number" step="0.01" id="valorAluguel" name="valorAluguel" required>
        </div>

        <div class="form-group">
            <label for="multaPorcentagem">Multa por Atraso (%):</label>
            <input type="number" step="0.01" id="multaPorcentagem" name="multaPorcentagem" required>
        </div>

        <div class="form-group">
            <label for="jurosPorDia">Juros por Dia de Atraso (R$):</label>
            <input type="number" step="0.01" id="jurosPorDia" name="jurosPorDia" required>
        </div>

        <div class="form-group">
            <label for="dataVencimento">Data de Vencimento do Primeiro Aluguel:</label>
            <input type="date" id="dataVencimento" name="dataVencimento" required>
        </div>
        
        <div class="form-group">
            <label for="dataPagamento">Data de Pagamento (deixe em branco se ainda não pago):</label>
            <input type="date" id="dataPagamento" name="dataPagamento">
        </div>

        <div class="buttons">
             <a href="${pageContext.request.contextPath}/views/menu.jsp" class="btn btn-secondary" style="text-decoration: none;">Cancelar</a>
            <button type="submit" class="btn btn-primary">Registrar Aluguel</button>
        </div>
    </form>
</div>

<script>
    function atualizarCamposImovel() {
        const selectImovel = document.getElementById('imovelId');
        const valorAluguelInput = document.getElementById('valorAluguel');
        const btnEditarImovel = document.getElementById('btnEditarImovel');

        // Pega a <option> que foi selecionada
        const selectedOption = selectImovel.options[selectImovel.selectedIndex];

        // 1. Atualiza o valor do aluguel
        // Pega o valor do atributo 'data-valor' da option selecionada
        if (selectedOption && selectedOption.dataset.valor) {
            valorAluguelInput.value = selectedOption.dataset.valor;
        } else {
            valorAluguelInput.value = ''; // Limpa se nenhuma opção válida for selecionada
        }

        // 2. Habilita ou desabilita o botão de editar
        if (selectImovel.value) {
            btnEditarImovel.disabled = false;
        } else {
            btnEditarImovel.disabled = true;
        }
    }

    function editarImovelSelecionado() {
        const selectImovel = document.getElementById('imovelId');
        const imovelId = selectImovel.value;

        if (imovelId) {
            // Redireciona para a página de edição do imóvel, usando a rota que já criamos
            window.location.href = '${pageContext.request.contextPath}/imovel/editar?id=' + imovelId;
        }
    }
    
    // Chama a função uma vez no carregamento da página para garantir que o botão comece desabilitado
    document.addEventListener('DOMContentLoaded', function() {
        atualizarCamposImovel();
    });
</script>

</body>
</html>