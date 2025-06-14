<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.bean.Usuario" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Passo 1: Verifica se o usuário está logado. Se não, redireciona. --%>
<c:if test="${empty sessionScope.usuario}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="pt-br" class="h-100">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bem-vindo | Meu Cérebro, Meu Universo</title>

        <%-- Ícone do Site --%>
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/img/icone.jpg"/>

        <%-- Bootstrap e Ícones --%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <%-- Seus Arquivos CSS --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>
    <body class="d-flex flex-column h-100 index-body">

        <%-- Fundo animado --%>
        <div class="stars"></div>

        <%-- Cabeçalho (Navbar) --%>
        <header>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">
                <div class="container-fluid">
                    <a class="navbar-brand glow-text" href="home.jsp">
                        <i class="bi bi-brain"></i>🧠 Universo de ${sessionScope.usuario.nome}
                    </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto align-items-center">

                            <li class="nav-item">
                                <a class="btn btn-outline-info ms-2" href="${pageContext.request.contextPath}/FilmeServlet?action=listar">Filmes</a>
                            </li>

                            <%-- Botões específicos para o tipo de usuário --%>
                            <c:if test="${sessionScope.usuario.tipo == 'admin'}">
                                <li class="nav-item">
                                    <a class="btn btn-outline-info ms-2" href="${pageContext.request.contextPath}/FilmeServlet?action=novo"> <i class="bi bi-gear"></i> Gerenciar</a>
                                </li>
                            </c:if>

                            <li class="nav-item">
                                <a class="btn btn-outline-danger ms-2" href="index.jsp">
                                    <i class="bi bi-box-arrow-right"></i> Sair
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <%-- Conteúdo Principal --%>
        <main class="container text-center text-light d-flex flex-column justify-content-center align-items-center flex-grow-1">

            <h1 class="text-center typing glow-text" >Seu cosmos de ideias foi carregado, ${sessionScope.usuario.nome}!</h1>

            <p class="lead mt-3 mb-4" style="max-width:  1000px; font-size: 1.60rem; font-weight: 500;">
                Decifre o Cérebro Através da Lente dos Filmes. 
                Adentre um domínio onde a tela se desdobra em labirintos neurais. 
                Cada cena, uma nova conexão.
            </p>

            <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">

                <%-- Lógica para mostrar botões diferentes para Admin e Comum --%>
                <c:choose>
                    <c:when test="${sessionScope.usuario.tipo == 'admin'}">
                        <a href="${pageContext.request.contextPath}/FilmeServlet?action=novo" class="btn btn-outline-light btn-lg px-4" style="background-color: #8a2be2;">
                            <i class="bi bi-gear-fill"></i> Gerenciar Filmes
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/FilmeServlet?action=sugerir" class="btn btn-outline-light btn-lg px-4" style="background-color: #00bfff;">
                            <i class="bi bi-plus-circle"></i> Sugerir um Filme
                        </a>
                    </c:otherwise>
                </c:choose>

                <a href="${pageContext.request.contextPath}/FilmeServlet?action=listar" class="btn btn-outline-light btn-lg px-4">
                    <i class="bi bi-film"></i> Ver Todos os Filmes
                </a>
            </div>

        </main>

        <%-- Rodapé --%>
        <footer class="mt-auto text-center text-light py-3">
            <hr class="bg-light w-75 mx-auto">
            <p class="mb-1">
                <i class="bi bi-stars"></i> <em>Sabia que uma lembrança cinematográfica pode ativar mais áreas do cérebro do que qualquer outro estímulo?</em>
            </p>
            <small>© 2025 Mente ativa, Universo Infinito — desenvolvido com criatividade e ciência por RAISSA ANUNCIAÇÃO & HECTOR BERNHARDT.</small>
        </footer>

        <%-- Scripts Globais --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
    </body>
</html>
