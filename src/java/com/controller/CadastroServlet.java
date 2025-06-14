package com.controller;

import java.io.IOException;
import java.io.PrintWriter; // Mantido, pois estava no seu código original.
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.bean.Usuario;
import com.model.UsuarioDAO;

/**
 *
 * @author Raissa
 */
@WebServlet("/CadastroServlet")
public class CadastroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // === ADICIONANDO UTF-8 NOVAMENTE (DEFINITIVO) ===
        request.setCharacterEncoding("UTF-8"); // Para ler parâmetros de entrada (nome, email, senha) como UTF-8
        response.setContentType("text/html;charset=UTF-8"); // Para a resposta HTTP ser tratada como UTF-8
        // ===============================================

        String nome = request.getParameter("nome").trim();
        String email = request.getParameter("email").trim().toLowerCase();
        String senha = request.getParameter("senha").trim();

        Usuario usuario = new Usuario();
        usuario.setNome(nome);
        usuario.setEmail(email);
        usuario.setSenha(senha);

        try {
            UsuarioDAO dao = new UsuarioDAO();
            boolean sucesso = dao.cadastrar(usuario);

            if (sucesso) {
                response.sendRedirect("login.jsp");
            } else {
                response.sendRedirect("cadastro.jsp?erro=Erro+ao+cadastrar");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cadastro.jsp?erro=" + e.getMessage());
        }
    }

    // Adicionado o método doGet() por boa prática, JÁ COM UTF-8.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // === ADICIONANDO UTF-8 NOVAMENTE (DEFINITIVO) ===
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        // ===============================================
        response.sendRedirect("cadastro.jsp");
    }
}