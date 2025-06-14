package com.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.bean.Usuario;
import com.model.UsuarioDAO;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email").trim().toLowerCase();
        String senha = request.getParameter("senha").trim();

        try {
            UsuarioDAO dao = new UsuarioDAO();
            Usuario usuario = dao.login(email, senha);

            if (usuario != null) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);

                if ("admin".equals(usuario.getTipo())) {
                    // CORREÇÃO: Chama o FilmeServlet para preparar a página do admin
                    response.sendRedirect("FilmeServlet?action=novo");
                } else {
                    response.sendRedirect("home.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?erro=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?erro=2");
        }
    }
}
