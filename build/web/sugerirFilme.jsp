<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.bean.Filme, com.bean.Usuario, java.util.function.Function, java.util.regex.Pattern, java.util.regex.Matcher" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Function<String, String> getYouTubeId = (url) -> {
        if (url == null || url.trim().isEmpty()) return null;
        String pattern = "(?<=watch\\?v=|/videos/|embed\\/|youtu.be\\/|\\/v\\/|\\/e\\/|watch\\?v%3D|watch\\?feature=player_embedded&v=|%2Fvideos%2F|embed%2Fvideos%2F|youtu.be%2F|\\/v%2F)[^#\\&\\?\\n]*";
        Matcher matcher = Pattern.compile(pattern).matcher(url);
        return matcher.find() ? matcher.group() : null;
    };
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Filme> lista = (List<Filme>) request.getAttribute("listaFilmes");
    pageContext.setAttribute("filmeParaEditar", request.getAttribute("filmeParaEditar"));
%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sugerir Filme</title>
        <link rel="shortcut icon" href="assets/img/icone.jpg"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/style.css">
        <style>
            .card-img-container{
                position:relative;
                cursor:pointer;
                overflow:hidden
            }
            .card-img-container img{
                transition:transform .3s ease;
                width:100%;
                aspect-ratio:16/9;
                object-fit:cover
            }
            .card-img-container:hover img{
                transform:scale(1.05)
            }
            .card-img-container .play-icon{
                position:absolute;
                top:50%;
                left:50%;
                transform:translate(-50%,-50%);
                font-size:4rem;
                color:rgba(255,0,0,.9);
                opacity:.8;
                transition:all .2s ease-in-out;
                text-shadow:0 0 15px rgba(0,0,0,.7);
                pointer-events:none
            }
            .card-img-container:hover .play-icon{
                opacity:1;
                transform:translate(-50%,-50%) scale(1.1)
            }
            .modal-content{
                background-color:rgba(20,4,28,.85)!important;
                backdrop-filter:blur(8px);
                border:1px solid #c74fac!important;
                border-radius:1rem;
                box-shadow:0 0 35px rgba(199,79,172,.3)
            }
            .modal-header{
                border-bottom:1px solid rgba(199,79,172,.3)!important
            }
            .modal-header .modal-title{
                color:#ee92b2;
                text-shadow:0 0 10px #ee92b2
            }
            .modal-body .form-label{
                color:#ee92b2
            }
            .modal-body .form-control{
                background-color:rgba(12,4,20,.7);
                border:1px solid rgba(199,79,172,.5);
                color:#fff
            }
            .modal-body .form-control:focus{
                background-color:rgba(12,4,20,.9);
                border-color:#ee92b2;
                box-shadow:0 0 10px rgba(238,146,178,.5);
                color:#fff
            }
        </style>
    </head>
    <body class="bg-dark text-white index-body">
        <div class="stars"></div>
        <nav class="navbar navbar-expand-lg navbar-dark"><div class="container-fluid">
                <a class="navbar-brand glow-text" href="home.jsp">🎬 Universo de <%= usuario.getNome() %></a>
                <div class="d-flex gap-2">
                    <a href="FilmeServlet?action=listar" class="btn btn-outline-info ms-2"><i class="bi bi-collection-play"></i> Ver Lista Completa</a>
                    <a href="home.jsp" class="btn btn-outline-info ms-2"><i class="bi bi-box-arrow-in-left"></i> Voltar</a>
                </div>
            </div></nav>

        <div class="container mt-5">
            <h2 class="text-center display-5 mb-4 typing glow-text">🎥 Filmes sugeridos</h2>
            <div class="row">
                <% if (lista != null && !lista.isEmpty()) { for (Filme f : lista) { 
                    String videoId = getYouTubeId.apply(f.getTrailerLink());
                %>
                <div class="col-12 col-md-6 col-lg-4 mb-4">
                    <div class="card filme-card-dreamcore text-white shadow-lg h-100">
                        <% if (videoId != null) { %><a href="<%= f.getTrailerLink() %>" target="_blank" class="card-img-container"><img src="https://img.youtube.com/vi/<%= videoId %>/mqdefault.jpg" class="card-img-top" alt="Capa do filme"><i class="bi bi-youtube play-icon"></i></a><% } %>
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-bold"><%= f.getTitulo() %></h5>
                            <p class="card-text mb-1"><small>Gênero: <%= f.getGenero() %></small></p>
                            <p class="card-text mb-1"><small>Nota: <%= f.getNota() %></small></p>
                            <p class="card-text mb-1"><small>Descrição: <%= f.getDescricao() %></small></p>
                            <p class="card-text"><small>Sugerido por: <%= f.getNomeUsuario() != null ? f.getNomeUsuario() : "Usuário" %></small></p>
                            <div class="mt-auto pt-3 d-grid gap-2 d-sm-flex justify-content-sm-between">
                                <% if (usuario.getId() == f.getUsuarioId() || "admin".equals(usuario.getTipo())) { %>
                                <a href="FilmeServlet?action=editar&id=<%= f.getId() %>&returnPage=sugerir" class="btn btn-outline-light btn-sm"><i class="bi bi-pencil-square"></i> Editar</a>
                                <a href="FilmeServlet?action=excluir&id=<%= f.getId() %>&returnPage=sugerir" class="btn btn-outline-danger btn-sm" onclick="return confirm('Tem certeza?')"><i class="bi bi-trash3"></i> Remover</a>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                <% }} else { %><p class="text-center typing glow-text">Nenhum filme sugerido ainda!</p><% } %>
            </div>
            <hr class="text-white my-5">
            <div class="text-center mb-4"><button type="button" class="btn btn-outline-info btn-lg fw-bold" data-bs-toggle="modal" data-bs-target="#sugestaoFilmeModal">🌌 Sugira um novo filme</button></div>
        </div>

        <!-- Modal para SUGERIR -->
        <div class="modal fade" id="sugestaoFilmeModal" tabindex="-1"><div class="modal-dialog modal-dialog-centered"><div class="modal-content">
                    <div class="modal-header"><h5 class="modal-title glow-text">🌌 Sugira um novo filme</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
                    <div class="modal-body">
                        <form action="FilmeServlet" method="post">
                            <input type="hidden" name="action" value="sugerir"><input type="hidden" name="returnPage" value="sugerir">
                            <div class="mb-3"><label class="form-label">Título</label><input type="text" class="form-control" name="titulo" required></div>
                            <div class="mb-3"><label class="form-label">Gênero</label><input type="text" class="form-control" name="genero" required></div>
                            <div class="mb-3"><label class="form-label">Nota</label><input type="number" class="form-control" name="nota" min="0" max="10" step="0.1" required></div>
                            <div class="mb-3">
                                <label for="sugerirDescricao" class="form-label">Descrição</label>
                                <textarea class="form-control" id="sugerirDescricao" name="descricao" rows="3" maxlength="500"></textarea>
                                <small class="form-text text-white-50 float-end"><span id="sugerirCharCount">0</span> / 500</small>
                            </div>
                            <div class="mb-3"><label class="form-label">Link do Trailer</label><input type="url" class="form-control" name="trailerLink"></div>
                            <div class="d-grid pt-3"><button type="submit" class="btn btn-outline-info btn-lg fw-bold">📤 Enviar sugestão</button></div>
                        </form>
                    </div>
                </div></div></div>

        <!-- Modal para EDITAR -->
        <div class="modal fade" id="editFilmeModal" tabindex="-1"><div class="modal-dialog modal-dialog-centered"><div class="modal-content">
                    <div class="modal-header"><h5 class="modal-title glow-text">✏️ Editar Sugestão</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
                    <div class="modal-body">
                        <form action="FilmeServlet" method="post">
                            <input type="hidden" name="action" value="atualizar"><input type="hidden" name="returnPage" value="sugerir">
                            <input type="hidden" name="id" value="<c:out value='${filmeParaEditar.id}'/>">
                            <div class="mb-3"><label class="form-label">Título</label><input type="text" class="form-control" name="titulo" value="<c:out value='${filmeParaEditar.titulo}'/>" required></div>
                            <div class="mb-3"><label class="form-label">Gênero</label><input type="text" class="form-control" name="genero" value="<c:out value='${filmeParaEditar.genero}'/>" required></div>
                            <div class="mb-3"><label class="form-label">Nota</label><input type="number" class="form-control" name="nota" value="<c:out value='${filmeParaEditar.nota}'/>" min="0" max="10" step="0.1" required></div>
                            <div class="mb-3">
                                <label for="editFormDescricao" class="form-label">Descrição</label>
                                <textarea class="form-control" id="editFormDescricao" name="descricao" rows="3" maxlength="500"><c:out value='${filmeParaEditar.descricao}'/></textarea>
                                <small class="form-text text-white-50 float-end"><span id="editCharCount">0</span> / 500</small>
                            </div>
                            <div class="mb-3"><label class="form-label">Link do Trailer</label><input type="url" class="form-control" name="trailerLink" value="<c:out value='${filmeParaEditar.trailerLink}'/>"></div>
                            <div class="d-grid pt-3"><button type="submit" class="btn btn-outline-info btn-lg fw-bold">💾 Salvar Alterações</button></div>
                        </form>
                    </div>
                </div></div></div>

        <footer class="text-center text-light py-3 mt-auto"><hr class="bg-light"><p class="mb-1">🧬 <em>Sabia que uma lembrança cinematográfica pode ativar mais áreas do cérebro do que qualquer outro estímulo?</em></p><small>© 2025 Meu Cérebro, Meu Universo — desenvolvido com criatividade e ciência por RAISSA ANUNCIAÇÃO & HECTOR BERNHARDT.</small></footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                        document.addEventListener('DOMContentLoaded', function () {
                                            // Função para configurar o contador de caracteres
                                            function setupCounter(textareaId, counterId) {
                                                const textarea = document.getElementById(textareaId);
                                                const counter = document.getElementById(counterId);
                                                if (!textarea || !counter)
                                                    return;

                                                const update = () => {
                                                    counter.textContent = textarea.value.length;
                                                };
                                                textarea.addEventListener('input', update);
                                                update(); // Contagem inicial
                                            }

                                            // Configura os contadores para ambos os modais
                                            setupCounter('sugerirDescricao', 'sugerirCharCount');
                                            setupCounter('editFormDescricao', 'editCharCount');

                                            // Mostra o modal de edição se necessário
            <c:if test="${not empty filmeParaEditar}">
                                            const editModal = new bootstrap.Modal(document.getElementById('editFilmeModal'));
                                            // Atualiza o contador quando o modal é mostrado
                                            document.getElementById('editFilmeModal').addEventListener('shown.bs.modal', function () {
                                                setupCounter('editFormDescricao', 'editCharCount');
                                            });
                                            editModal.show();
            </c:if>
                                        });
        </script>
    </body>
</html>
