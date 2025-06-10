package com.cefet.alugafacil.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.cefet.alugafacil.dao.AluguelDAO;
import com.cefet.alugafacil.dao.ImovelDAO;
import com.cefet.alugafacil.dao.InquilinoDAO;
import com.cefet.alugafacil.modelo.Aluguel;
import com.cefet.alugafacil.modelo.Imovel;
import com.cefet.alugafacil.modelo.Inquilino;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/aluguel", "/aluguel/*"})
public class AluguelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private AluguelDAO aluguelDAO;
    private InquilinoDAO inquilinoDAO;
    private ImovelDAO imovelDAO;
    private SimpleDateFormat dateFormat;
    
    @Override
    public void init() {
        this.aluguelDAO = new AluguelDAO();
        this.inquilinoDAO = new InquilinoDAO();
        this.imovelDAO = new ImovelDAO();
        this.dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/listar";
        }
        
        try {
            switch (action) {
                case "/registrar":
                    showRegistrationForm(request, response);
                    break;
                case "/listar":
                default:
                    listRentals(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "listar";
        }
        
        try {
            switch (action) {
                case "registrar":
                    createRental(request, response);
                    break;
                case "excluir":
                    deleteRental(request, response);
                    break;
                default:
                    listRentals(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    private void showRegistrationForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        List<Inquilino> inquilinos = inquilinoDAO.listarTodos();
        List<Imovel> imoveis = imovelDAO.listarTodos();
        request.setAttribute("inquilinos", inquilinos);
        request.setAttribute("imoveis", imoveis);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/registrarAluguel.jsp");
        dispatcher.forward(request, response);
    }
    
    private void listRentals(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String searchTerm = request.getParameter("search");
        List<Aluguel> alugueis;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            alugueis = aluguelDAO.buscarPorSubstring(searchTerm);
        } else {
            alugueis = aluguelDAO.listarTodos();
        }

        request.setAttribute("alugueis", alugueis);
        request.setAttribute("searchTerm", searchTerm);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/listarDados.jsp");
        dispatcher.forward(request, response);
    }

    private void createRental(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException, java.text.ParseException {
        int inquilinoId = Integer.parseInt(request.getParameter("inquilinoId"));
        int imovelId = Integer.parseInt(request.getParameter("imovelId"));
        double valorAluguel = Double.parseDouble(request.getParameter("valorAluguel"));
        double multaPorcentagem = Double.parseDouble(request.getParameter("multaPorcentagem"));
        double jurosPorDia = Double.parseDouble(request.getParameter("jurosPorDia"));
        Date dataVencimento = dateFormat.parse(request.getParameter("dataVencimento"));
        Date dataPagamento = dateFormat.parse(request.getParameter("dataPagamento"));

        Inquilino inquilino = inquilinoDAO.buscarPorId(inquilinoId);
        Imovel imovel = imovelDAO.buscarPorId(imovelId);

        Aluguel aluguel = new Aluguel();
        aluguel.setInquilino(inquilino);
        aluguel.setImovel(imovel);
        aluguel.setValorAluguel(valorAluguel);
        aluguel.setMultaPorcentagem(multaPorcentagem);
        aluguel.setJurosPorDia(jurosPorDia);
        aluguel.setDataVencimento(dataVencimento);
        aluguel.setDataPagamento(dataPagamento);
        aluguel.setDataInicio(new Date());

        aluguelDAO.salvar(aluguel);
        response.sendRedirect(request.getContextPath() + "/aluguel/listar");
    }
    
    private void deleteRental(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, SQLException {
        int aluguelId = Integer.parseInt(request.getParameter("id"));
        String searchTerm = request.getParameter("search");
        
        aluguelDAO.excluir(aluguelId);
        
        String redirectURL = request.getContextPath() + "/aluguel/listar";
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            redirectURL += "?search=" + java.net.URLEncoder.encode(searchTerm, "UTF-8");
        }
        response.sendRedirect(redirectURL);
    }
}