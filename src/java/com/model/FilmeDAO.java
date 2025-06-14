package com.model;

import com.bean.Filme;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FilmeDAO {

    public void inserir(Filme f) throws Exception {
        // MUDANÇA: Adicionado trailer_link na query e um 6º placeholder '?'
        String sql = "INSERT INTO filmes (nome_filme, genero, nota, descricao, usuario_id, trailer_link) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexaoBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, f.getTitulo());
            stmt.setString(2, f.getGenero());
            stmt.setDouble(3, f.getNota());
            stmt.setString(4, f.getDescricao());
            stmt.setInt(5, f.getUsuarioId());
            // MUDANÇA: Adicionado o sexto parâmetro para o link do trailer
            stmt.setString(6, f.getTrailerLink());
            stmt.executeUpdate();
        }
    }

    public void atualizar(Filme f) throws Exception {
        // MUDANÇA: Adicionado trailer_link=? na query de atualização
        String sql = "UPDATE filmes SET nome_filme=?, genero=?, nota=?, descricao=?, trailer_link=? WHERE id_filme=?";
        try (Connection conn = ConexaoBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, f.getTitulo());
            stmt.setString(2, f.getGenero());
            stmt.setDouble(3, f.getNota());
            stmt.setString(4, f.getDescricao());
            // MUDANÇA: Adicionado o quinto parâmetro para o trailer
            stmt.setString(5, f.getTrailerLink());
            // MUDANÇA: O ID do filme agora é o sexto parâmetro
            stmt.setInt(6, f.getId());
            stmt.executeUpdate();
        }
    }

    public void excluir(int id) throws Exception {
        String sql = "DELETE FROM filmes WHERE id_filme=?";
        try (Connection conn = ConexaoBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public Filme buscarPorId(int id) throws Exception {
        String sql = "SELECT f.*, u.nome AS nome_usuario FROM filmes f LEFT JOIN usuarios u ON f.usuario_id = u.id_usuario WHERE f.id_filme=?";
        try (Connection conn = ConexaoBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRowToFilme(rs);
            }
        }
        return null;
    }

    public List<Filme> listar() throws Exception {
        List<Filme> lista = new ArrayList<>();
        String sql = "SELECT f.*, u.nome AS nome_usuario FROM filmes f LEFT JOIN usuarios u ON f.usuario_id = u.id_usuario ORDER BY f.id_filme DESC";
        try (Connection conn = ConexaoBD.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                lista.add(mapRowToFilme(rs));
            }
        }
        return lista;
    }

    // Método auxiliar para não repetir código
    private Filme mapRowToFilme(ResultSet rs) throws SQLException {
        Filme f = new Filme();
        f.setId(rs.getInt("id_filme"));
        f.setTitulo(rs.getString("nome_filme"));
        f.setGenero(rs.getString("genero"));
        f.setNota(rs.getDouble("nota"));
        f.setDescricao(rs.getString("descricao"));
        f.setUsuarioId(rs.getInt("usuario_id"));
        f.setNomeUsuario(rs.getString("nome_usuario"));
        // MUDANÇA: Buscando o valor do trailer_link
        f.setTrailerLink(rs.getString("trailer_link"));
        return f;
    }
}
