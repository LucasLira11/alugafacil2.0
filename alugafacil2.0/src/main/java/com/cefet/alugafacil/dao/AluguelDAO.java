package com.cefet.alugafacil.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cefet.alugafacil.modelo.Aluguel;
import com.cefet.alugafacil.modelo.Imovel;
import com.cefet.alugafacil.modelo.Inquilino;

public class AluguelDAO {
    
    // Método para listar todos os alugueis
    public List<Aluguel> listarTodos() throws SQLException {
        List<Aluguel> lista = new ArrayList<>();
        String sql = "SELECT a.id, a.data_inicio, a.data_fim, a.valor_aluguel, a.multa_porcentagem, " +
                    "a.juros_por_dia, a.data_vencimento, a.data_pagamento, " +
                    "i.id AS inquilino_id, i.nome AS inquilino_nome, i.cpf AS inquilino_cpf, i.telefone AS inquilino_telefone, " +
                    "im.id AS imovel_id, im.endereco, im.tipo, im.valorAluguel AS imovel_valor " +
                    "FROM aluguel a " +
                    "JOIN inquilinos i ON a.inquilino_id = i.id " +
                    "JOIN imoveis im ON a.imovel_id = im.id";

        try (Connection connection = ConexaoDAO.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Aluguel aluguel = new Aluguel();
                aluguel.setId(rs.getInt("id"));
                aluguel.setDataInicio(rs.getDate("data_inicio"));
                aluguel.setDataFim(rs.getDate("data_fim"));
                aluguel.setValorAluguel(rs.getDouble("valor_aluguel"));
                aluguel.setMultaPorcentagem(rs.getDouble("multa_porcentagem"));
                aluguel.setJurosPorDia(rs.getDouble("juros_por_dia"));
                aluguel.setDataVencimento(rs.getDate("data_vencimento"));
                aluguel.setDataPagamento(rs.getDate("data_pagamento"));

                Inquilino inquilino = new Inquilino();
                inquilino.setId(rs.getInt("inquilino_id"));
                inquilino.setNome(rs.getString("inquilino_nome"));
                inquilino.setCpf(rs.getString("inquilino_cpf"));
                inquilino.setTelefone(rs.getString("inquilino_telefone"));
                aluguel.setInquilino(inquilino);

                Imovel imovel = new Imovel();
                imovel.setId(rs.getInt("imovel_id"));
                imovel.setEndereco(rs.getString("endereco"));
                imovel.setTipo(rs.getString("tipo"));
                imovel.setValorAluguel(rs.getDouble("imovel_valor"));
                aluguel.setImovel(imovel);

                lista.add(aluguel);
            }
        }
        return lista;
    }

    // Método para salvar aluguel
    public void salvar(Aluguel aluguel) throws SQLException {
        String sql = "INSERT INTO aluguel (data_inicio, data_fim, inquilino_id, imovel_id, valor_aluguel, " +
                    "multa_porcentagem, juros_por_dia, data_vencimento, data_pagamento) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = ConexaoDAO.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            java.sql.Date dataInicioSql = aluguel.getDataInicio() != null ? 
                new java.sql.Date(aluguel.getDataInicio().getTime()) : null;
            java.sql.Date dataFimSql = aluguel.getDataFim() != null ? 
                new java.sql.Date(aluguel.getDataFim().getTime()) : null;
            java.sql.Date dataVencimentoSql = new java.sql.Date(aluguel.getDataVencimento().getTime());
            java.sql.Date dataPagamentoSql = new java.sql.Date(aluguel.getDataPagamento().getTime());

            ps.setDate(1, dataInicioSql);
            ps.setDate(2, dataFimSql);
            ps.setInt(3, aluguel.getInquilino().getId());
            ps.setInt(4, aluguel.getImovel().getId());
            ps.setDouble(5, aluguel.getValorAluguel());
            ps.setDouble(6, aluguel.getMultaPorcentagem());
            ps.setDouble(7, aluguel.getJurosPorDia());
            ps.setDate(8, dataVencimentoSql);
            ps.setDate(9, dataPagamentoSql);
            
            ps.executeUpdate();
        }
    }

    // Método para excluir aluguel
    public void excluir(int id) throws SQLException {
        String sql = "DELETE FROM aluguel WHERE id = ?";
        try (Connection connection = ConexaoDAO.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // ===== MÉTODO DE BUSCA CORRIGIDO =====
    public List<Aluguel> buscarPorSubstring(String termo) throws SQLException {
        List<Aluguel> lista = new ArrayList<>();
        String sql = "SELECT a.id, a.data_inicio, a.data_fim, a.valor_aluguel, a.multa_porcentagem, " +
                     "a.juros_por_dia, a.data_vencimento, a.data_pagamento, " +
                     "i.id AS inquilino_id, i.nome AS inquilino_nome, i.cpf AS inquilino_cpf, i.telefone AS inquilino_telefone, " +
                     "im.id AS imovel_id, im.endereco, im.tipo, im.valorAluguel AS imovel_valor " +
                     "FROM aluguel a " +
                     "JOIN inquilinos i ON a.inquilino_id = i.id " +
                     "JOIN imoveis im ON a.imovel_id = im.id " +
                     "WHERE i.nome LIKE ? OR i.cpf LIKE ? OR im.endereco LIKE ? OR im.tipo LIKE ?";

        try (Connection connection = ConexaoDAO.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            String termoBusca = "%" + termo + "%";
            ps.setString(1, termoBusca);
            ps.setString(2, termoBusca);
            ps.setString(3, termoBusca);
            ps.setString(4, termoBusca);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Aluguel aluguel = new Aluguel();
                    aluguel.setId(rs.getInt("id"));
                    aluguel.setDataInicio(rs.getDate("data_inicio"));
                    aluguel.setDataFim(rs.getDate("data_fim"));
                    aluguel.setValorAluguel(rs.getDouble("valor_aluguel"));
                    aluguel.setMultaPorcentagem(rs.getDouble("multa_porcentagem"));
                    aluguel.setJurosPorDia(rs.getDouble("juros_por_dia"));
                    aluguel.setDataVencimento(rs.getDate("data_vencimento"));
                    aluguel.setDataPagamento(rs.getDate("data_pagamento"));

                    Inquilino inquilino = new Inquilino();
                    inquilino.setId(rs.getInt("inquilino_id"));
                    inquilino.setNome(rs.getString("inquilino_nome"));
                    inquilino.setCpf(rs.getString("inquilino_cpf"));
                    inquilino.setTelefone(rs.getString("inquilino_telefone"));
                    aluguel.setInquilino(inquilino);

                    Imovel imovel = new Imovel();
                    imovel.setId(rs.getInt("imovel_id"));
                    imovel.setEndereco(rs.getString("endereco"));
                    imovel.setTipo(rs.getString("tipo"));
                    imovel.setValorAluguel(rs.getDouble("imovel_valor"));
                    aluguel.setImovel(imovel);

                    lista.add(aluguel);
                }
            }
        }
        return lista;
    }

    public Aluguel buscarPorId(int id) throws SQLException {
        // ... (este método permanece o mesmo)
        String sql = "SELECT a.id, a.data_inicio, a.data_fim, a.valor_aluguel, a.multa_porcentagem, " +
                    "a.juros_por_dia, a.data_vencimento, a.data_pagamento, " +
                    "i.id AS inquilino_id, i.nome AS inquilino_nome, i.cpf AS inquilino_cpf, i.telefone AS inquilino_telefone, " +
                    "im.id AS imovel_id, im.endereco, im.tipo, im.valorAluguel AS imovel_valor " +
                    "FROM aluguel a " +
                    "JOIN inquilinos i ON a.inquilino_id = i.id " +
                    "JOIN imoveis im ON a.imovel_id = im.id " +
                    "WHERE a.id = ?";

        try (Connection connection = ConexaoDAO.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Aluguel aluguel = new Aluguel();
                    aluguel.setId(rs.getInt("id"));
                    aluguel.setDataInicio(rs.getDate("data_inicio"));
                    aluguel.setDataFim(rs.getDate("data_fim"));
                    aluguel.setValorAluguel(rs.getDouble("valor_aluguel"));
                    aluguel.setMultaPorcentagem(rs.getDouble("multa_porcentagem"));
                    aluguel.setJurosPorDia(rs.getDouble("juros_por_dia"));
                    aluguel.setDataVencimento(rs.getDate("data_vencimento"));
                    aluguel.setDataPagamento(rs.getDate("data_pagamento"));

                    Inquilino inquilino = new Inquilino();
                    inquilino.setId(rs.getInt("inquilino_id"));
                    inquilino.setNome(rs.getString("inquilino_nome"));
                    inquilino.setCpf(rs.getString("inquilino_cpf"));
                    inquilino.setTelefone(rs.getString("inquilino_telefone"));
                    aluguel.setInquilino(inquilino);

                    Imovel imovel = new Imovel();
                    imovel.setId(rs.getInt("imovel_id"));
                    imovel.setEndereco(rs.getString("endereco"));
                    imovel.setTipo(rs.getString("tipo"));
                    imovel.setValorAluguel(rs.getDouble("imovel_valor"));
                    aluguel.setImovel(imovel);
                    
                    return aluguel;
                }
            }
        }
        return null; 
    }
}