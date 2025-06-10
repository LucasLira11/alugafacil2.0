package com.cefet.alugafacil.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.cefet.alugafacil.dao.InquilinoDAO;
import com.cefet.alugafacil.modelo.Inquilino;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/inquilino/*")
public class InquilinoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InquilinoDAO inquilinoDAO;

    @Override
    public void init() {
        inquilinoDAO = new InquilinoDAO();
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
                    listarInquilinos(request, response);
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
                    incluirInquilino(request, response);
                    break;
                case "alterar":
                    alterarInquilino(request, response);
                    break;
                case "excluir":
                    excluirInquilino(request, response);
                    break;
                default:
                    listarInquilinos(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listarInquilinos(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Inquilino> listaInquilinos = inquilinoDAO.listarTodos();
        request.setAttribute("listaInquilinos", listaInquilinos);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/listarInquilinos.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioRegistro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/registrarInquilino.jsp");
        dispatcher.forward(request, response);
    }

    private void mostrarFormularioEdicao(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Inquilino inquilinoExistente = inquilinoDAO.buscarPorId(id);
        request.setAttribute("inquilino", inquilinoExistente);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/editarInquilino.jsp");
        dispatcher.forward(request, response);
    }

    private void incluirInquilino(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String telefone = request.getParameter("telefone");
        Inquilino novoInquilino = new Inquilino(0, nome, cpf, telefone);
        inquilinoDAO.incluir(novoInquilino);
        response.sendRedirect(request.getContextPath() + "/inquilino/listar");
    }

    private void alterarInquilino(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String telefone = request.getParameter("telefone");
        Inquilino inquilino = new Inquilino(id, nome, cpf, telefone);
        inquilinoDAO.alterar(inquilino);
        response.sendRedirect(request.getContextPath() + "/inquilino/listar");
    }

    private void excluirInquilino(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        inquilinoDAO.excluir(id);
        response.sendRedirect(request.getContextPath() + "/inquilino/listar");
    }
}