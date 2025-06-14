package com.controller;

import com.bean.Filme;
import com.bean.Usuario;
import com.model.FilmeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "FilmeServlet", urlPatterns = {"/FilmeServlet"})
public class FilmeServlet extends HttpServlet {

    private FilmeDAO filmeDAO;

    @Override
    public void init() {
        try {
            filmeDAO = new FilmeDAO();
        } catch (Exception e) {
            throw new RuntimeException("Falha ao inicializar FilmeDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action") == null ? "listar" : request.getParameter("action");

        try {
            switch (action) {
                case "listar": listarFilmes(request, response); break;
                case "novo": showAdminForm(request, response); break;
                case "sugerir": showUserSuggestions(request, response); break;
                case "editar": showEditModal(request, response); break;
                case "excluir": deletarFilme(request, response); break;
                default: response.sendRedirect("home.jsp"); break;
            }
        } catch (Exception e) {
            throw new ServletException("Erro no doGet do FilmeServlet", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            salvarFilme(request, response);
        } catch (Exception e) {
            throw new ServletException("Erro no doPost do FilmeServlet", e);
        }
    }

    private void showAdminForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("listaFilmes", filmeDAO.listar());
        request.getRequestDispatcher("formFilme.jsp").forward(request, response);
    }

    private void showUserSuggestions(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("listaFilmes", filmeDAO.listar());
        request.getRequestDispatcher("sugerirFilme.jsp").forward(request, response);
    }
    
    private void listarFilmes(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Filme> todosFilmes = filmeDAO.listar();
        List<Filme> adminFilmes = new ArrayList<>();
        List<Filme> userFilmes = new ArrayList<>();

        for (Filme f : todosFilmes) {
            if ("Administrador".equalsIgnoreCase(f.getNomeUsuario())) {
                adminFilmes.add(f);
            } else {
                userFilmes.add(f);
            }
        }
        
        request.setAttribute("adminFilmes", adminFilmes);
        request.setAttribute("userFilmes", userFilmes);
        request.getRequestDispatcher("listarFilmes.jsp").forward(request, response);
    }

    private void showEditModal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int idEditar = Integer.parseInt(request.getParameter("id"));
        Filme filmeParaEditar = filmeDAO.buscarPorId(idEditar);
        request.setAttribute("filmeParaEditar", filmeParaEditar);

        String returnPageAction = request.getParameter("returnPage");
        switch (returnPageAction) {
            case "sugerir": showUserSuggestions(request, response); break;
            case "novo": showAdminForm(request, response); break;
            case "listar": default: listarFilmes(request, response); break;
        }
    }

    private void deletarFilme(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuario");
        int idExcluir = Integer.parseInt(request.getParameter("id"));
        Filme filmeExcluir = filmeDAO.buscarPorId(idExcluir);

        if (usuarioLogado != null && filmeExcluir != null && ("admin".equals(usuarioLogado.getTipo()) || usuarioLogado.getId() == filmeExcluir.getUsuarioId())) {
            filmeDAO.excluir(idExcluir);
            String returnPageAction = request.getParameter("returnPage");
            response.sendRedirect("FilmeServlet?action=" + returnPageAction);
        } else {
            response.sendRedirect("home.jsp");
        }
    }

    private void salvarFilme(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        
        Filme filme = new Filme();
        filme.setTitulo(request.getParameter("titulo"));
        filme.setGenero(request.getParameter("genero"));
        filme.setNota(Double.parseDouble(request.getParameter("nota")));
        filme.setDescricao(request.getParameter("descricao"));
        filme.setTrailerLink(request.getParameter("trailerLink"));

        if ("atualizar".equals(action)) {
            filme.setId(Integer.parseInt(request.getParameter("id")));
            filmeDAO.atualizar(filme);
        } else {
            Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
            if(usuario != null) filme.setUsuarioId(usuario.getId());
            filmeDAO.inserir(filme);
        }

        String returnPageAction = request.getParameter("returnPage");
        switch (returnPageAction) {
            case "sugerir": showUserSuggestions(request, response); break;
            case "listar": listarFilmes(request, response); break;
            case "novo": default: showAdminForm(request, response); break;
        }
    }
}
