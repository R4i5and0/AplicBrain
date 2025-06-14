<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Cadastro | Meu Cérebro, Meu Universo</title> <%-- Título mais completo --%>
        
        <%-- Bootstrap CSS --%>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        
        <%-- Bootstrap Icons CSS (ADICIONADO/CONFIRMADO - Essencial para o ícone do olho) --%>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        
        <%-- Seu CSS Personalizado --%>
        <link rel="stylesheet" href="assets/css/style.css">
        
        <%-- Ícone do Site --%>
        <link rel="shortcut icon" href="assets/img/icone.jpg"/>
        
        <%-- SEU CÓDIGO SCRIPT.JS ESTÁ DEFER, OK --%>
        <%-- <script src="assets/js/script.js" defer></script> --%> 

        <style>
            /* Estilo para o container da senha, para posicionar o ícone */
            .password-container {
                position: relative;
            }
            /* Posiciona o ícone do olho dentro do campo */
            #togglePassword {
                position: absolute;
                top: 50%; /* Alinha verticalmente no meio */
                right: 12px; /* Espaço da direita */
                transform: translateY(-50%); /* Ajusta para centralização perfeita */
                cursor: pointer; /* Indica que é clicável */
                color: #6f42c1; /* Cor do ícone, combine com sua paleta */
                z-index: 2; /* Garante que o ícone fique acima do input */
            }
        </style>
    </head>
    <body class="index-body">

        <div class="stars"></div> <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold text-glow glow-text" href="index.jsp">🧠 Mente ativa, universo infinito.</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="btn btn-success fw-bold" href="index.jsp">Início</a></li>
                        <li class="nav-item"><a class="btn btn-success fw-bold" href="login.jsp">Entrar</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container d-flex justify-content-center align-items-center" style="min-height: 85vh;">
            <div class="col-md-6 p-4 rounded" style="background-color: rgba(0, 0, 0, 0.8); border: 1px solid #6f42c1;">
                <h2 class="text-center glow-text">Cadastro</h2>
                <p class="text-center text-light fst-italic mb-4">Ao se cadastrar, você começa a registrar seu próprio universo de lembranças e inspirações.</p>

                <% String erro = request.getParameter("erro");
                    if (erro != null) {%>
                <div class="alert alert-danger text-center" role="alert">
                    <%= erro%>
                </div>
                <% }%>

                <form action="CadastroServlet" method="post">
                    <div class="mb-3">
                        <label for="nome" class="form-label text-light">Nome completo</label>
                        <input type="text" name="nome" class="form-control" required placeholder="Seu nome">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label text-light">E-mail</label>
                        <input type="email" name="email" class="form-control" required placeholder="voce@universo.com">
                    </div>
                    <div class="mb-3">
                        <label for="senha" class="form-label text-light">Senha</label>
                        <div class="password-container">
                            <input type="password" class="form-control" id="senha" name="senha">

                            <i class="bi bi-eye-slash" id="togglePassword"></i>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Cadastrar</button>
                </form>

                <p class="mt-3 text-center text-light">
                    Já tem uma conta? <a href="login.jsp" class="text-info">Entrar</a>
                </p>
            </div>
        </div>
        
        <footer class="text-center text-light py-3 mt-auto">
            <hr class="bg-light">
            <p class="mb-1">🧬 <em>Sabia que uma lembrança cinematográfica pode ativar mais áreas do cérebro do que qualquer outro estímulo?</em></p>
            <small>© 2025 Mente ativa, Universo Infinito — desenvolvido com criatividade e ciência por RAISSA ANUNCIAÇÃO & HECTOR BERNHARDT.</small>
        </footer>

        <%-- SCRIPTS JAVASCRIPT (colocados no final do body para melhor performance) --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        
        <%-- SCRIPT DO OLHINHO DA SENHA - DIRETO NO JSP --%>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const senhaInput = document.getElementById('senha');
                const togglePasswordIcon = document.getElementById('togglePassword');

                // Verifica se ambos os elementos existem antes de adicionar o evento
                if (senhaInput && togglePasswordIcon) {
                    togglePasswordIcon.addEventListener('click', function() {
                        // Alterna o tipo do input: de 'password' para 'text' e vice-versa
                        const type = senhaInput.getAttribute('type') === 'password' ? 'text' : 'password';
                        senhaInput.setAttribute('type', type);

                        // Alterna as classes do ícone para mudar a aparência do olho
                        this.classList.toggle('bi-eye'); // Adiciona/remove o ícone de olho aberto
                        this.classList.toggle('bi-eye-slash'); // Adiciona/remove o ícone de olho cortado (fechado)
                    });
                }
            });
        </script>
        <%-- Se você tem outros scripts em assets/js/script.js e ainda quer usá-los, mantenha a linha abaixo.
             Se não, pode remover para não carregar um arquivo vazio ou desnecessário. --%>
        <%-- <script src="assets/js/script.js" defer></script> --%>
    </body>
</html>