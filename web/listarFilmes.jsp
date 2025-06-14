<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.bean.Filme, com.bean.Usuario, java.util.function.Function, java.util.regex.Pattern, java.util.regex.Matcher" %>
<%
    // Helper para extrair o ID do vídeo do YouTube
    Function<String, String> getYouTubeId = (url) -> {
        if (url == null || url.trim().isEmpty()) return null;
        String pattern = "(?<=watch\\?v=|/videos/|embed\\/|youtu.be\\/|\\/v\\/|\\/e\\/|watch\\?v%3D|watch\\?feature=player_embedded&v=|%2Fvideos%2F|embed%2Fvideos%2F|youtu.be%2F|\\/v%2F)[^#\\&\\?\\n]*";
        Matcher matcher = Pattern.compile(pattern).matcher(url);
        return matcher.find() ? matcher.group() : null;
    };

    List<Filme> adminFilmes = (List<Filme>) request.getAttribute("adminFilmes");
    List<Filme> userFilmes = (List<Filme>) request.getAttribute("userFilmes");
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
    Filme filmeParaEditar = (Filme) request.getAttribute("filmeParaEditar");
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>🎬 Filmes do Universo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="shortcut icon" href="assets/img/icone.jpg"/>
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        body { font-family: 'Poppins', sans-serif; }
        .filme-bloco { background: rgba(22, 22, 44, 0.7); border-radius: 20px; padding: 2.5rem; margin-bottom: 3rem; backdrop-filter: blur(8px); }
        .admin-section { border: 2px solid #8a2be2; }
        .user-section { border: 2px solid #00bfff; }
        .filme-titulo-geral { text-align: center; font-weight: 700; font-size: 2rem; margin-bottom: 2rem; color: #e0dfff; text-shadow: 0 0 10px #c084fc, 0 0 20px #6f42c1; }
        .section-title-admin { color: #ba55d3; }
        .section-title-user { color: #00bfff; }
        .table th, .table td { vertical-align: middle; }
        
        /* Estilo para a célula do filme com thumbnail */
        .filme-info { display: flex; align-items: center; gap: 15px; min-width: 250px; }
        .filme-info img { width: 100px; height: 56px; object-fit: cover; border-radius: 8px; border: 1px solid rgba(255,255,255,0.2); transition: transform 0.2s ease; }
        .filme-info img:hover { transform: scale(1.1); }
        
        .card-img-container { position: relative; cursor: pointer; overflow: hidden; }
        .card-img-container img { transition: transform .3s ease; width: 100%; aspect-ratio: 16/9; object-fit: cover; }
        .card-img-container:hover img { transform: scale(1.05); }
        .card-img-container .play-icon {
            position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
            font-size: 4rem; color: rgba(255, 0, 0, .9); opacity: .8; transition: all .2s ease-in-out;
            text-shadow: 0 0 15px rgba(0,0,0,.7); pointer-events: none;
        }
        .card-img-container:hover .play-icon { opacity: 1; transform: translate(-50%, -50%) scale(1.1); }

        /* Estilo do Modal */
        .modal-content {
            background-color: rgba(20, 4, 28, 0.85) !important;
            backdrop-filter: blur(8px);
            border: 1px solid #c74fac;
            border-radius: 1rem;
            box-shadow: 0 0 35px rgba(199, 79, 172, 0.3);
        }
        .modal-header { border-bottom: 1px solid rgba(199, 79, 172, 0.3) !important; }
        .modal-header .modal-title { color: #ee92b2; text-shadow: 0 0 10px #ee92b2; }
        .modal-body .form-label { color: #ee92b2; }
        .modal-body .form-control {
            background-color: rgba(12, 4, 20, 0.7);
            border: 1px solid rgba(199, 79, 172, 0.5);
            color: #fff;
        }
        .modal-body .form-control:focus {
            background-color: rgba(12, 4, 20, 0.9);
            border-color: #ee92b2;
            box-shadow: 0 0 10px rgba(238, 146, 178, 0.5);
            color: #fff;
        }
    </style>
</head>
<body class="index-body text-white">
    <div class="stars"></div>

    <nav class="navbar navbar-expand-lg navbar-dark bg-black shadow">
        <div class="container-fluid">
            <a class="navbar-brand glow-text" href="home.jsp">🧠 Mente ativa, universo infinito.</a>
            <div class="ms-auto d-flex gap-2">
                <% if (usuarioLogado != null && "admin".equals(usuarioLogado.getTipo())) { %>
                    <a href="FilmeServlet?action=novo" class="btn btn-outline-info ms-2" style="background-color: #8a2be2;"><i class="bi bi-gear"></i> Gerenciar</a>
                <% } else if (usuarioLogado != null) { %>
                    <a href="FilmeServlet?action=sugerir" class="btn btn-outline-info ms-2" style="background-color: #00bfff;"><i class="bi bi-lightbulb"></i> Sugerir</a>
                <% } %>
                <a href="home.jsp" class="btn btn-outline-info ms-2"><i class="bi bi-house-door"></i> Home</a>
            </div>
        </div>
    </nav>

    <main class="container my-5">
        <h2 class="typing container glow-text text-center text-light d-flex flex-column justify-content-center align-items-center">🎥  Filmes Favoritos do Universo</h2>

        <%-- Tabela de Filmes do Admin --%>
        <% if (adminFilmes != null && !adminFilmes.isEmpty()) { %>
        <div class="filme-bloco admin-section mb-5">
            <h3 class="section-title-admin mb-4 glow-text">🌟 Filmes do Administrador</h3>
            <div class="table-responsive">
                <table class="table table-dark table-hover align-middle">
                    <thead>
                        <tr>
                            <th>Filme</th>
                            <th>Gênero</th>
                            <th>Nota</th>
                            <th>Descrição</th> <%-- ADICIONADO: Coluna Descrição --%>
                            <th class="text-center">Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Filme f : adminFilmes) { String videoId = getYouTubeId.apply(f.getTrailerLink()); %>
                        <tr>
                            <td>
                                <div class="filme-info">
                                    <% if (videoId != null) { %><a href="<%= f.getTrailerLink() %>" target="_blank"><img src="https://img.youtube.com/vi/<%= videoId %>/mqdefault.jpg" alt="Capa"></a><% } %>
                                    <span><%= f.getTitulo() %></span>
                                </div>
                            </td>
                            <td><%= f.getGenero() %></td>
                            <td><%= f.getNota() %></td>
                            <td><%= f.getDescricao() %></td> <%-- ADICIONADO: Conteúdo da Descrição --%>
                            <td class="text-center">
                                <div class="d-flex justify-content-center gap-2">
                                    <%-- CORREÇÃO: Botões de Editar e Excluir só aparecem para o Admin --%>
                                    <% if (usuarioLogado != null && "admin".equals(usuarioLogado.getTipo())) { %>
                                        <button type="button" class="btn btn-sm btn-warning btn-editar" data-id="<%= f.getId() %>" data-titulo="<%= f.getTitulo() %>" data-genero="<%= f.getGenero() %>" data-nota="<%= f.getNota() %>" data-descricao="<%= f.getDescricao() %>" data-trailerlink="<%= f.getTrailerLink() != null ? f.getTrailerLink() : "" %>"><i class="bi bi-pencil-square"></i></button>
                                        <a href="FilmeServlet?action=excluir&id=<%= f.getId() %>&returnPage=listar" class="btn btn-sm btn-danger" onclick="return confirm('Tem certeza?');"><i class="bi bi-trash"></i></a>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <% } %>

        <%-- Tabela de Filmes dos Usuários --%>
        <% if (userFilmes != null && !userFilmes.isEmpty()) { %>
        <div class="filme-bloco user-section">
            <h3 class="section-title-user mb-4 glow-text">🎬 Sugestões dos Usuários</h3>
            <div class="table-responsive">
                <table class="table table-dark table-hover align-middle">
                    <thead>
                        <tr>
                            <th>Filme</th>
                            <th>Gênero</th>
                            <th>Nota</th>
                            <th>Sugerido por</th>
                            <th>Descrição</th> <%-- ADICIONADO: Coluna Descrição --%>
                            <th class="text-center">Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Filme f : userFilmes) { String videoId = getYouTubeId.apply(f.getTrailerLink()); %>
                        <tr>
                            <td>
                                <div class="filme-info">
                                    <% if (videoId != null) { %><a href="<%= f.getTrailerLink() %>" target="_blank"><img src="https://img.youtube.com/vi/<%= videoId %>/mqdefault.jpg" alt="Capa"></a><% } %>
                                    <span><%= f.getTitulo() %></span>
                                </div>
                            </td>
                            <td><%= f.getGenero() %></td>
                            <td><%= f.getNota() %></td>
                            <td><%= f.getNomeUsuario() %></td>
                            <td><%= f.getDescricao() %></td> <%-- ADICIONADO: Conteúdo da Descrição --%>
                            <td class="text-center">
                                <div class="d-flex justify-content-center gap-2">
                                    <%-- LÓGICA DE PERMISSÃO CORRIGIDA: só o dono do filme ou o admin podem mexer --%>
                                    <% if (usuarioLogado != null && (usuarioLogado.getTipo().equals("admin") || usuarioLogado.getId() == f.getUsuarioId())) { %>
                                        <button type="button" class="btn btn-sm btn-warning btn-editar" data-id="<%= f.getId() %>" data-titulo="<%= f.getTitulo() %>" data-genero="<%= f.getGenero() %>" data-nota="<%= f.getNota() %>" data-descricao="<%= f.getDescricao() %>" data-trailerlink="<%= f.getTrailerLink() != null ? f.getTrailerLink() : "" %>"><i class="bi bi-pencil-square"></i></button>
                                        <a href="FilmeServlet?action=excluir&id=<%= f.getId() %>&returnPage=listar" class="btn btn-sm btn-danger" onclick="return confirm('Tem certeza?');"><i class="bi bi-trash"></i></a>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <% } %>
    </main>

    <div class="modal fade" id="filmeModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered"><div class="modal-content bg-dark text-white">
            <div class="modal-header"><h5 class="modal-title">✏ Editar Filme</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
                <form action="FilmeServlet" method="post">
                    <input type="hidden" name="action" value="atualizar"><input type="hidden" id="formId" name="id"><input type="hidden" name="returnPage" value="listar">
                    <div class="mb-3"><label class="form-label">Título</label><input type="text" class="form-control" id="formTitulo" name="titulo" required></div>
                    <div class="mb-3"><label class="form-label">Gênero</label><input type="text" class="form-control" id="formGenero" name="genero" required></div>
                    <div class="mb-3"><label class="form-label">Nota</label><input type="number" class="form-control" id="formNota" name="nota" min="0" max="10" step="0.1" required></div>
                    <div class="mb-3"><label class="form-label">Descrição</label><textarea class="form-control" id="formDescricao" name="descricao" rows="3"></textarea></div>
                    <div class="mb-3"><label class="form-label">Link do Trailer</label><input type="url" class="form-control" id="formTrailer" name="trailerLink" placeholder="https://youtube.com/..."></div>
                    <div class="d-grid"><button type="submit" class="btn btn-outline-info btn-lg fw-bold">💾 Salvar Alterações</button></div>
                </form>
            </div>
        </div></div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const filmeModal = new bootstrap.Modal(document.getElementById('filmeModal'));
            const formId = document.getElementById('formId');
            const formTitulo = document.getElementById('formTitulo');
            const formGenero = document.getElementById('formGenero');
            const formNota = document.getElementById('formNota');
            const formDescricao = document.getElementById('formDescricao');
            const formTrailer = document.getElementById('formTrailer');

            document.querySelectorAll('.btn-editar').forEach(button => {
                button.addEventListener('click', function () {
                    formId.value = this.dataset.id;
                    formTitulo.value = this.dataset.titulo;
                    formGenero.value = this.dataset.genero;
                    formNota.value = this.dataset.nota;
                    formDescricao.value = this.dataset.descricao;
                    formTrailer.value = this.dataset.trailerlink;
                    filmeModal.show();
                });
            });

            <% if (filmeParaEditar != null) { %>
                formId.value = '<%= filmeParaEditar.getId() %>';
                formTitulo.value = <%= filmeParaEditar.getTitulo() %>.replace(/"/g, '"');
                formGenero.value = <%= filmeParaEditar.getGenero() %>.replace(/"/g, '"');
                formNota.value = <%= filmeParaEditar.getNota() %>;
                formDescricao.value = <%= filmeParaEditar.getDescricao() %>.replace(/"/g, '"');
                formTrailer.value = <%= filmeParaEditar.getTrailerLink() != null ? filmeParaEditar.getTrailerLink() : "" %>;
                filmeModal.show();
            <% } %>
        });
    </script>
</body>
</html>