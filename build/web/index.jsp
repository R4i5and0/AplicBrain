<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br" class="h-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mente Ativa, Universo Infinito</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="shortcut icon" href="assets/img/icone.jpg"/>
    
    <style>
        /* Garante que o body e html ocupem toda a altura */
        html, body {
            height: 100%;
        }
        /* Usa flexbox para o layout principal e o sticky footer */
        body {
            display: flex;
            flex-direction: column;
        }
        /* Faz o conteúdo principal crescer e empurrar o footer para baixo */
        main {
            flex-grow: 1;
        }
    </style>
</head>
<body class="index-body">
    <div class="stars"></div>

    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold glow-text" href="index.jsp">
                    <i class="bi bi-brain"></i>🧠 Mente Ativa, Universo Infinito.
                </a>
                
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav gap-2">
                        <li class="nav-item">
                            <a class="btn btn-outline-info" href="login.jsp">Entrar</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-info" href="cadastro.jsp">Cadastrar</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <main class="container text-center text-light d-flex flex-column justify-content-center align-items-center">
        <h1 class="text-center text-light mb-3 glow-text typing glow-text">O silêncio do espaço encontra o ruído dos pensamentos.</h1>

        <p class="lead mt-4 index-text" style="max-width: 1000px;">
            Mergulhe nas histórias que te marcam, e compartilhe suas impressões.
            Canções se transformam em pulsações cerebrais no hipocampo.
            Filmes iluminam o córtex visual como cometas de emoção.
            Aqui, você explora, sugere e viaja entre sinapses criativas.
            A arte vive no lobo temporal; a memória, no hipocampo;
            e a imaginação... essa navega livre pelo nossos cosmos pessoal.

        </p>

        <div class="d-grid gap-3 d-sm-flex justify-content-sm-center mt-4">
            <a href="login.jsp" class="btn btn-info btn-lg px-4 gap-3 fw-bold">
                <i class="bi bi-door-open-fill"></i> Comece a Exploração
            </a>
        </div>
    </main>
    
    <footer class="text-center text-light py-3">
        <hr class="w-75 mx-auto" style="border-top-color: rgba(255,255,255,0.2);">
        <p class="mb-1">🧬 <em>Sabia que uma lembrança cinematográfica pode ativar mais áreas do cérebro do que qualquer outro estímulo?</em></p>
        <small>© 2025 Mente ativa, Universo Infinito — desenvolvido com criatividade e ciência por RAISSA ANUNCIAÇÃO & HECTOR BERNHARDT.</small>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/script.js" defer></script>
</body>
</html>
