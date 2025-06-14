package com.controller;

import com.bean.Filme;
import com.model.FilmeDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
// import jakarta.servlet.annotation.WebServlet; // Removendo o comentário da importação, pois já faz parte do seu código.

@WebServlet("/formFilme") // isso define o caminho acessado no navegador
public class FormFilmeServlet extends HttpServlet {

    @Override // Boa prática adicionar @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // === ADICIONANDO UTF-8 NOVAMENTE (DEFINITIVO) ===
        request.setCharacterEncoding("UTF-8"); // Para ler parâmetros de entrada (id) como UTF-8
        response.setContentType("text/html;charset=UTF-8"); // Para a resposta HTTP ser tratada como UTF-8
        // ===============================================

        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                FilmeDAO dao = new FilmeDAO();
                Filme filme = dao.buscarPorId(id);
                request.setAttribute("filme", filme);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher rd = request.getRequestDispatcher("formFilme.jsp");
        rd.forward(request, response);
    }

    // === ADICIONANDO MÉTODO doPost() (COM UTF-8) ===
    // Esta Servlet é mapeada para "/formFilme".
    // Se o formulário em formFilme.jsp usa method="post" (que é o caso do formulário de CRUD de filmes),
    // o doPost() precisa existir para receber esses dados.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // === ADICIONANDO UTF-8 NOVAMENTE (DEFINITIVO) ===
        request.setCharacterEncoding("UTF-8"); // Para garantir que a requisição POST seja UTF-8
        response.setContentType("text/html;charset=UTF-8"); // Para garantir que a resposta seja UTF-8
        // ===============================================

        // Já que esta Servlet tem o mapeamento "/formFilme", e a FilmeServlet lida com "inserir" e "atualizar",
        // este doPost() pode apenas redirecionar para a FilmeServlet ou para a própria formFilme.jsp
        // se não houver lógica específica de processamento de POST aqui.
        // A sua FilmeServlet é quem processa as ações "inserir" e "atualizar" do formFilme.jsp,
        // então este doPost() aqui seria um "pass-through" ou um redirecionamento de fallback.
        // Por simplicidade e para não bagunçar seu fluxo principal, vamos redirecionar
        // para a FilmeServlet, que processa as ações de inserir/atualizar.
        // Ou, você pode redirecionar de volta para formFilme.jsp se não há lógica POST aqui.
        // VOU REDIRECIONAR PARA A FILMESERVLET COM AÇÃO LISTAR, COMO UM FALLBACK SE ALGUÉM POSTAR AQUI.
        response.sendRedirect("FilmeServlet?action=listar"); // Exemplo de fallback.
    }
}
