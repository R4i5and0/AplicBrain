/**
 * main.js - Scripts globais da aplicação.
 */

document.addEventListener("DOMContentLoaded", () => {
    
    // Inicia o efeito de estrelas se o container existir.
    initStarryBackground();

});


/**
 * Cria estrelas animadas dinamicamente no fundo da página.
 * Esta função é mais organizada e só roda se o elemento .stars-background existir.
 */
function initStarryBackground() {
    const starsContainer = document.querySelector('.stars');
    if (!starsContainer) {
        return; // Não faz nada se a div .stars não estiver na página.
    }
    
    // Evita adicionar estrelas múltiplas vezes se o script for carregado de novo.
    if (starsContainer.childElementCount > 0) {
        return;
    }
    
    

    const starCount = 150; // Quantidade de estrelas
    const colors = ['#ff99ff', '#cc66ff', '#9966ff', '#66ccff', '#ffffff'];

    for (let i = 0; i < starCount; i++) {
        const star = document.createElement('div');
        
        const size = Math.random() * 2 + 1; // 1 a 3px
        const color = colors[Math.floor(Math.random() * colors.length)];

        Object.assign(star.style, {
            position: 'absolute',
            width: `${size}px`,
            height: `${size}px`,
            top: `${Math.random() * 100}%`,
            left: `${Math.random() * 100}%`,
            borderRadius: '50%',
            background: color,
            opacity: Math.random() * 0.5 + 0.3, // 0.3 a 0.8
            boxShadow: `0 0 ${Math.random() * 6 + 2}px ${color}`,
            animation: `twinkle ${Math.random() * 5 + 3}s infinite ease-in-out`
        });

        starsContainer.appendChild(star);
    }
}

// A animação @keyframes agora deve ser colocada no CSS para melhor performance.
// Adicionando via JS pode ser menos eficiente. Vou mover para o main.css.
// Se você quiser mantê-la aqui por algum motivo, me avise.
