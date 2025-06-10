package com.cefet.alugafacil.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.cefet.alugafacil.dao.ImovelDAO;
import com.cefet.alugafacil.modelo.Imovel;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/imovel/*")
public class ImovelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ImovelDAO imovelDAO;

    @Override
    public void init() {
        imovelDAO = new ImovelDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/listar";
        }

        try {
            switch (action) {
                case "/registrar":
                    mostrarFormularioRegistro(request, response);
                    break;
                case "/editar":
                    mostrarFormularioEdicao(request, response);
                    break;
                case "/listar":
                default:
                    listarImoveis(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "registrar":
                    incluirImovel(request, response);
                    break;
                case "alterar":
                    alterarImovel(request, response);
                    break;
                case "excluir":
                    excluirImovel(request, response);
                    break;
                default:
                    listarImoveis(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listarImoveis(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Imovel> listaImoveis = imovelDAO.listarTodos();
        request.setAttribute("listaImoveis", listaImoveis);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/listarImoveis.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioRegistro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/registrarImovel.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioEdicao(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Imovel imovelExistente = imovelDAO.buscarPorId(id);
        request.setAttribute("imovel", imovelExistente);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/editarImovel.jsp");
        dispatcher.forward(request, response);
    }

    private void incluirImovel(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String endereco = request.getParameter("endereco");
        String tipo = request.getParameter("tipo");
        double valorAluguel = Double.parseDouble(request.getParameter("valorAluguel"));
        Imovel novoImovel = new Imovel(0, endereco, tipo, valorAluguel);
        imovelDAO.incluir(novoImovel);
        response.sendRedirect(request.getContextPath() + "/imovel/listar");
    }

    private void alterarImovel(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String endereco = request.getParameter("endereco");
        String tipo = request.getParameter("tipo");
        double valorAluguel = Double.parseDouble(request.getParameter("valorAluguel"));
        Imovel imovel = new Imovel(id, endereco, tipo, valorAluguel);
        imovelDAO.alterar(imovel);
        response.sendRedirect(request.getContextPath() + "/imovel/listar");
    }

    private void excluirImovel(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        imovelDAO.excluir(id);
        response.sendRedirect(request.getContextPath() + "/imovel/listar");
    }
}