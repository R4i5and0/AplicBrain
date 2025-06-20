<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login | Meu Cérebro, Meu Universo</title>

        <%-- Bootstrap CSS (mantido 5.3.0 como no seu código) --%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <%-- Bootstrap Icons CSS (ADICIONADO - Essencial para o ícone do olho) --%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <%-- Seu CSS Personalizado --%>
        <link rel="stylesheet" href="assets/css/style.css">

        <%-- Ícone do Site --%>
        <link rel="shortcut icon" href="assets/img/icone.jpg"/>

        <%-- SEU SCRIPT.JS (mantido, mas não é estritamente necessário para o olhinho se o JS estiver aqui) --%>
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
            /* *** AQUI ESTÁ A CORREÇÃO PARA O TÍTULO BRANCO COM GLOW *** */
            .card .glow-text {
                color: #fff !important; /* Força a cor do texto a ser BRANCA */
                /* As propriedades de text-shadow (o glow) virão do seu style.css para .glow-text */
            }
        </style>
    </head>
</head>
<body class="index-body">
    <div class="stars"></div>

    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold glow-text" href="index.jsp">🧠 Mente ativa, universo infinito.</a>
            <div class="collapse navbar-collapse justify-content-end">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="btn btn-outline-light" href="index.jsp"><i class="bi bi-emoji-sunglasses"></i> Início</a></li> <%-- Mudei para outline para combinar com o "Cadastrar" --%>
                    <li class="nav-item"><a class="btn btn-info bi bi-door-closed" href="cadastro.jsp"> Cadastrar</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container d-flex justify-content-center align-items-center" style="min-height: 85vh;"> <%-- min-height para ser mais responsivo --%>
        <div class="card p-4 p-md-5" style="width: 100%; max-width: 450px; background-color: rgba(0, 0, 0, 0.8); border: 1px solid #6f42c1;">

            <%-- Frase e Título da Página de Login (conforme nossas conversas) --%>
            <h2 class="text-center mb-3 glow-text">Login</h2> <%-- Título melhorado --%>
            <p class="text-center text-light fst-italic mb-4">Faça login e sinta-se à vontade para compartilhar suas experiências e explorar novos mundos.</p> <%-- Parágrafo melhorado --%>

            <%-- Mensagem de erro se houver --%>
            <% String erro = request.getParameter("erro");
                if (erro != null) {
                    String msg = "";
                    if ("1".equals(erro)) {
                        msg = "E-mail ou senha inválidos.";
                    } else if ("2".equals(erro)) {
                        msg = "Ocorreu um erro inesperado."; // Erro interno ao tentar realizar login.
                    }
            %>
            <div class="alert alert-danger text-center"><%= msg%></div>
            <% }%>

            <form action="LoginServlet" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label text-light">E-mail:</label>
                    <input type="email" class="form-control" id="email" name="email" required placeholder="seu@email.com">
                </div>

                <div class="mb-3"> <%-- Usei mb-3 para consistência --%>
                    <label for="senha" class="form-label text-light">Senha:</label>
                    <div class="password-container">
                        <input type="password" class="form-control" id="senha" name="senha" required placeholder="">
                        <%-- Ícone do Olho --%>
                        <i class="bi bi-eye-slash" id="togglePassword"></i>
                    </div>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-outline-info btn-lg fw-bold">Acessar</button> <%-- Mantido seu estilo de botão --%>
                </div>
            </form>
            <p class="mt-4 text-center text-light">
                Ainda não tem uma conta? <a href="cadastro.jsp" class="text-info fw-bold">Cadastre-se</a> <%-- fw-bold para destacar --%>
            </p>
        </div>
    </div>

    <footer class="text-center text-light py-3 mt-auto">
        <hr class="bg-light w-75 mx-auto">
        <p class="mb-1">🧬 <em>Sabia que uma lembrança cinematográfica pode ativar mais áreas do cérebro do que qualquer outro estímulo?</em></p>
        <small>© 2025 Mente ativa, Universo Infinito — desenvolvido com criatividade e ciência por RAISSA ANUNCIAÇÃO & HECTOR BERNHARDT.</small>
    </footer>

    <%-- SCRIPTS JAVASCRIPT (colocados no final do body para melhor performance) --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> <%-- Atualizado para 5.3.3 --%>

    <%-- SCRIPT DO OLHINHO DA SENHA - DIRETO NO JSP --%>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const senhaInput = document.getElementById('senha');
            const togglePasswordIcon = document.getElementById('togglePassword');

            if (senhaInput && togglePasswordIcon) {
                togglePasswordIcon.addEventListener('click', function () {
                    const type = senhaInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    senhaInput.setAttribute('type', type);

                    this.classList.toggle('bi-eye');
                    this.classList.toggle('bi-eye-slash');
                });
            }
        });
    </script>
    <%-- Se você tem outros scripts em assets/js/script.js e ainda quer usá-los, mantenha a linha abaixo. --%>
    <%-- <script src="assets/js/script.js" defer></script> --%>
     </body>
</html>