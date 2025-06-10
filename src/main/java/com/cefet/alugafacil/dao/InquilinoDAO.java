package com.cefet.alugafacil.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cefet.alugafacil.modelo.Inquilino;

public class InquilinoDAO {

    public void incluir(Inquilino inquilino) throws SQLException {
        String sql = "INSERT INTO inquilinos (nome, cpf, telefone) VALUES (?, ?, ?)";
        try (Connection c = ConexaoDAO.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, inquilino.getNome());
            ps.setString(2, inquilino.getCpf());
            ps.setString(3, inquilino.getTelefone());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) inquilino.setId(rs.getInt(1));
            }
        }
    }

    public void excluir(int id) throws SQLException {
        String sql = "DELETE FROM inquilinos WHERE id = ?";
        try (Connection c = ConexaoDAO.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // MÉTODO CORRIGIDO E RENOMEADO
    public List<Inquilino> listarTodos() throws SQLException {
        List<Inquilino> lista = new ArrayList<>();
        String sql = "SELECT * FROM inquilinos";
        try (Connection c = ConexaoDAO.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Inquilino i = new Inquilino();
                i.setId(rs.getInt("id"));
                i.setNome(rs.getString("nome"));
                i.setCpf(rs.getString("cpf"));
                i.setTelefone(rs.getString("telefone"));
                lista.add(i);
            }
        }
        return lista;
    }

    public Inquilino buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM inquilinos WHERE id = ?";
        try (Connection c = ConexaoDAO.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Inquilino i = new Inquilino();
                    i.setId(rs.getInt("id"));
                    i.setNome(rs.getString("nome"));
                    i.setCpf(rs.getString("cpf"));
                    i.setTelefone(rs.getString("telefone"));
                    return i;
                }
            }
        }
        return null;
    }

    public void alterar(Inquilino inquilino) throws SQLException {
    String sql = "UPDATE inquilinos SET nome = ?, cpf = ?, telefone = ? WHERE id = ?";
    try (Connection c = ConexaoDAO.getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setString(1, inquilino.getNome());
        ps.setString(2, inquilino.getCpf());
        ps.setString(3, inquilino.getTelefone());
        ps.setInt(4, inquilino.getId());
        ps.executeUpdate();
        }
    }
}