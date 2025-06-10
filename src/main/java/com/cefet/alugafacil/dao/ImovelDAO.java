package com.cefet.alugafacil.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cefet.alugafacil.modelo.Imovel;

public class ImovelDAO {

    public void incluir(Imovel imovel) throws SQLException {
        String sql = "INSERT INTO imoveis (endereco, tipo, valorAluguel) VALUES (?, ?, ?)";
        try (Connection c = ConexaoDAO.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, imovel.getEndereco());
            ps.setString(2, imovel.getTipo());
            ps.setDouble(3, imovel.getValorAluguel());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) imovel.setId(rs.getInt(1));
            }
        }
    }

    public void excluir(int id) throws SQLException {
        String sql = "DELETE FROM imoveis WHERE id = ?";
        try (Connection c = ConexaoDAO.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // MÉTODO CORRIGIDO E RENOMEADO
    public List<Imovel> listarTodos() throws SQLException {
        List<Imovel> lista = new ArrayList<>();
        String sql = "SELECT * FROM imoveis";
        try (Connection c = ConexaoDAO.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Imovel i = new Imovel();
                i.setId(rs.getInt("id"));
                i.setEndereco(rs.getString("endereco"));
                i.setTipo(rs.getString("tipo"));
                i.setValorAluguel(rs.getDouble("valorAluguel"));
                lista.add(i);
            }
        }
        return lista;
    }

    public Imovel buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM imoveis WHERE id = ?";
        try (Connection c = ConexaoDAO.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Imovel i = new Imovel();
                    i.setId(rs.getInt("id"));
                    i.setEndereco(rs.getString("endereco"));
                    i.setTipo(rs.getString("tipo"));
                    i.setValorAluguel(rs.getDouble("valorAluguel"));
                    return i;
                }
            }
        }
        return null;
    }

    public void alterar(Imovel imovel) throws SQLException {
    String sql = "UPDATE imoveis SET endereco = ?, tipo = ?, valorAluguel = ? WHERE id = ?";
    try (Connection c = ConexaoDAO.getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setString(1, imovel.getEndereco());
        ps.setString(2, imovel.getTipo());
        ps.setDouble(3, imovel.getValorAluguel());
        ps.setInt(4, imovel.getId());
        ps.executeUpdate();
        }
    }
}