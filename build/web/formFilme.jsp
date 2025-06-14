<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.bean.Filme, com.bean.Usuario" %>
<%-- IMPORTAÇÃO QUE FALTAVA --%>
<%@ page import="java.util.function.Function" %>
<%@ page import="java.util.regex.Pattern, java.util.regex.Matcher" %>
<%
    // Helper para extrair o ID do vídeo do YouTube de qualquer formato de URL
    Function<String, String> getYouTubeId = (
            url) -> {
        if (url == null || url.trim().isEmpty()) {
            return null;
        }
        String pattern = "(?<=watch\\?v=|/videos/|embed\\/|youtu.be\\/|\\/v\\/|\\/e\\/|watch\\?v%3D|watch\\?feature=player_embedded&v=|%2Fvideos%2F|embed%2Fvideos\\/|http:\\/\\/googleusercontent\\.com\\/youtube\\.com\\/61\\/|\\/v\\/)[^#\\&\\?\\n]*";
        Pattern compiledPattern = Pattern.compile(pattern);
        Matcher matcher = compiledPattern.matcher(url);
        if (matcher.find()) {
            return matcher.group();
        }
        return null;
    };

    List<Filme> lista = (List<Filme>) request.getAttribute("listaFilmes");
    Filme filmeParaEditar = (Filme) request.getAttribute("filmeParaEditar");
%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Gerenciar Filmes</title>
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="shortcut icon" href="assets/img/icone.jpg"/>
        <style>
            .card-img-container {
                position: relative;
                cursor: pointer;
                overflow: hidden;
            }
            .card-img-container img {
                transition: transform .3s ease;
                width: 100%;
                aspect-ratio: 16/9;
                object-fit: cover;
            }
            .card-img-container:hover img {
                transform: scale(1.05);
            }
            .card-img-container .play-icon {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-size: 4rem;
                color: rgba(255, 0, 0, .9);
                opacity: .8;
                transition: all .2s ease-in-out;
                text-shadow: 0 0 15px rgba(0,0,0,.7);
                pointer-events: none;
            }
            .card-img-container:hover .play-icon {
                opacity: 1;
                transform: translate(-50%, -50%) scale(1.1);
            }

            /* Estilo do Modal */
            .modal-content {
                background-color: rgba(20, 4, 28, 0.85) !important;
                backdrop-filter: blur(8px);
                border: 1px solid #c74fac;
                border-radius: 1rem;
                box-shadow: 0 0 35px rgba(199, 79, 172, 0.3);
            }
            .modal-header {
                border-bottom: 1px solid rgba(199, 79, 172, 0.3) !important;
            }
            .modal-header .modal-title {
                color: #ee92b2;
                text-shadow: 0 0 10px #ee92b2;
            }
            .modal-body .form-label {
                color: #ee92b2;
            }
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
    <body class="bg-dark text-white index-body">
        <div class="stars"></div>
        <nav class="navbar navbar-expand-lg navbar-dark">

            <a class="navbar-brand fw-bold text-glow glow-text" href="index.jsp"> 🧠 Mente ativa, universo infinito.</a>

            <div class="ms-auto d-flex gap-1">
                <a href="home.jsp" class="btn btn-outline-info ms-2"><i class="bi bi-house-door"></i> Home</a>

                <a href="FilmeServlet?action=listar" class="btn btn-outline-info ms-2">Ver Lista Completa</a>


            </div>

        </nav>

        <div class="container mt-5">
            <h2 class="text-center display-5 mb-4 glow-text typing glow-text">🌟 Gerenciador de Filmes</h2>
            <div class="row">
                <% if (lista != null && !lista.isEmpty()) {
                    for (Filme f : lista) {
                        String videoId = getYouTubeId.apply(f.getTrailerLink());
                %>
                <div class="col-md-4 mb-4">
                    <div class="card filme-card-dreamcore text-white shadow-lg h-100">
                        <% if (videoId != null) {%>
                        <a href="<%= f.getTrailerLink()%>" target="_blank" class="card-img-container">
                            <img src="https://img.youtube.com/vi/<%= videoId%>/mqdefault.jpg" class="card-img-top" alt="Capa do filme <%= f.getTitulo()%>">
                            <i class="bi bi-youtube play-icon"></i>
                        </a>
                        <% }%>

                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-bold"><%= f.getTitulo()%></h5>
                            <p class="card-text mb-1"><small><strong>Gênero:</strong> <%= f.getGenero()%></small></p>
                            <p class="card-text mb-1"><small><strong>Nota:</strong> <%= f.getNota()%></small></p>

                            <%-- AQUI É ONDE A DESCRIÇÃO VAI APARECER! --%>
                            <% if (f.getDescricao() != null && !f.getDescricao().trim().isEmpty()) { %>
                            <p class="card-text card-description-scroll mt-2 mb-2"><small><strong>Descrição:</strong> <%= f.getDescricao()%></small></p>
                                        <% } %>

                            <p class="card-text"><small><strong>Sugerido por:</strong> <%= f.getNomeUsuario() != null ? f.getNomeUsuario() : "N/A"%></small></p>
                            <div class="mt-auto d-flex justify-content-between pt-3">
                                <a href="FilmeServlet?action=editar&id=<%= f.getId()%>&returnPage=novo" class="btn btn-outline-light btn-sm"><i class="bi bi-pencil-square"></i> Editar</a>
                                <a href="FilmeServlet?action=excluir&id=<%= f.getId()%>&returnPage=novo" class="btn btn-outline-danger btn-sm" onclick="return confirm('Tem certeza?')"><i class="bi bi-trash3"></i> Remover</a>
                            </div>
                        </div>
                    </div>
                </div>
                <% }
        } else { %><p class="text-center">Nenhum filme cadastrado ainda.</p><% } %>
            </div>
            <hr class="text-white my-5">
            <div class="text-center mb-4"><button type="button" class="btn btn-outline-info btn-lg fw-bold" data-bs-toggle="modal"
                                                  data-bs-target="#filmeModal" id="btnNovoFilme">🌌 Adicionar novo filme
                </button></div>
        </div>

        <div class="modal fade" id="filmeModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title" id="filmeModalLabel"></h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="formFilme" action="FilmeServlet" method="post">
                            <input type="hidden" id="formAction" name="action">
                            <input type="hidden" id="formId" name="id">
                            <input type="hidden" name="returnPage" value="novo">
                            <div class="mb-3"><label class="form-label">Título</label><input 
                                    type="text" class="form-control"

                                    id="formTitulo" name="titulo"

                                    required></div>
                            <div class="mb-3"><label class="form-label">Gênero</label><input 
                                    type="text" class="form-control"

                                    id="formGenero" name="genero"

                                    required></div>
                            <div class="mb-3"><label class="form-label">Nota</label><input 
                                    type="number" class="form-control"

                                    id="formNota" name="nota" min="0"

                                    max="10" step="0.1" required></div>
                                <%-- ADICIONANDO O CAMPO DESCRIÇÃO --%>
                            <div class="mb-3">
                                <label class="form-label">Descrição</label>
                                <textarea class="form-control" id="formDescricao" name="descricao" rows="3"></textarea>
                            </div>
                            <%-- FIM DO CAMPO DESCRIÇÃO --%>
                            <div class="mb-3"><label class="form-label">Link do Trailer(Opcional)</label><input 
                                    type="url"

                                    class="form-control"

                                    id="formTrailer"

                                    name="trailerLink"></div>
                            <div class="d-grid"><button type="submit" class="btn btn-outline-info btn-lg fw-bold"
                                                        id="formSubmitButton"></button></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <footer class="text-center text-light py-3 mt-auto "><hr class="bg-light">
            <p class="mb-1">🧬 <em>Sabia que uma lembrança cinematográfica pode ativar mais áreas do cérebro do que qualquer outro
                    estímulo?</em></p><small>© 2025 Meu Cérebro, Meu Universo — desenvolvido com criatividade e ciência por RAISSA
                ANUNCIAÇÃO & HECTOR BERNHARDT.</small></footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                    document.addEventListener('DOMContentLoaded', function () {
                                        const filmeModal = new bootstrap.Modal(document.getElementById('filmeModal'));
                                        const modalTitle = document.getElementById('filmeModalLabel');
                                        const form = document.getElementById('formFilme');
                                        const formAction = document.getElementById('formAction');
                                        const formId = document.getElementById('formId');
                                        const formTitulo = document.getElementById('formTitulo');
                                        const formGenero = document.getElementById('formGenero');
                                        const formNota = document.getElementById('formNota');
                                        const formDescricao = document.getElementById('formDescricao'); // NOVA LINHA
                                        const formTrailer = document.getElementById('formTrailer');
                                        const formSubmitButton = document.getElementById('formSubmitButton');

                                        document.getElementById('btnNovoFilme').addEventListener('click', function () {
                                            modalTitle.textContent = '🎬 Novo Filme';
                                            formSubmitButton.textContent = '📥 Cadastrar Filme';
                                            formAction.value = 'inserir';
                                            form.reset();
                                            formId.value = '';
                                            filmeModal.show();
                                        });

            <% if (filmeParaEditar != null) { %>
                                        modalTitle.textContent = '✏ Editar Filme';
                                        formSubmitButton.textContent = '💾 Salvar Alterações';
                                        formAction.value = 'atualizar';
                                        formId.value = '<%= filmeParaEditar.getId() %>';
                                        formTitulo.value = "<%= filmeParaEditar.getTitulo().replace("\"", "\\\"") %>";
                                        formGenero.value = "<%= filmeParaEditar.getGenero().replace("\"", "\\\"") %>";
                                        formNota.value = "<%= filmeParaEditar.getNota() %>";
                                        formDescricao.value = "<%= filmeParaEditar.getDescricao() != null ? filmeParaEditar.getDescricao().replace("\"", "\\\"") : "" %>";
                                        formTrailer.value = "<%= filmeParaEditar.getTrailerLink() != null ? filmeParaEditar.getTrailerLink().replace("\"", "\\\"") : "" %>";
                                        filmeModal.show();
            <% } %>
                                    });
        </script>
    </body>
</html>