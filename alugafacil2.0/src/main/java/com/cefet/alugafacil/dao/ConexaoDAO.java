package com.cefet.alugafacil.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoDAO {

    // 1. Defina as novas credenciais do Render aqui
    private static final String HOST = "dpg-cl45aujuib2s73dujn70-a";
    private static final String PORT = "5432";
    private static final String DATABASE = "alugafacildb";
    private static final String USER = "alugafacildb_user";
    // !! IMPORTANTE: Copie a senha do seu painel do Render e cole aqui !!
    private static final String PASSWORD = "cHU2wDrVa0WAxUb3aEMHshxazIIPbcCf";

    // 2. A URL de conexão foi atualizada para o formato do PostgreSQL
    private static final String URL = "jdbc:postgresql://" + HOST + ":" + PORT + "/" + DATABASE;

    public static Connection getConnection() throws SQLException {
        try {
            // 3. O nome do driver foi alterado para o do PostgreSQL
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC do PostgreSQL não encontrado.", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}