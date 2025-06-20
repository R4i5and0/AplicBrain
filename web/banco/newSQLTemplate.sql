
DROP DATABASE IF EXISTS brain;

-- Cria o novo banco de dados.
CREATE DATABASE brain;

-- Seleciona o banco de dados que vamos usar.
USE brain;


-- Tabela de Usuários: Armazena informações de login.
CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  -- A senha será armazenada como um hash (SHA-256).
  senha VARCHAR(255) NOT NULL,
  -- O tipo de usuário (admin tem superpoderes).
  tipo ENUM('admin', 'comum') NOT NULL DEFAULT 'comum'  
);


-- Tabela de Filmes: Armazena os filmes sugeridos pelo admin e usuários.
CREATE TABLE filmes (
  id_filme INT AUTO_INCREMENT PRIMARY KEY,
  nome_filme VARCHAR(255) NOT NULL,
  genero VARCHAR(100) NOT NULL,
  nota DOUBLE,
  descricao TEXT,
  -- Coluna para o link do trailer do YouTube.
  trailer_link VARCHAR(255),
  -- Chave estrangeira que conecta o filme ao usuário que o cadastrou.
  usuario_id INT,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
  -- ON DELETE SET NULL: Se um usuário for deletado, os filmes dele não são apagados,
  -- apenas perdem a referência, o que evita erros.
);


-- Tabela de Músicas (Estrutura pronta para o futuro).
CREATE TABLE musicas (
  id_musica INT AUTO_INCREMENT PRIMARY KEY,
  nome_musica VARCHAR(255) NOT NULL,
  descricao TEXT,
  usuario_id INT,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);


INSERT INTO usuarios (nome, email, senha, tipo)
VALUES ('Administrador', 'admin@admin.com', 'JAvlGPq9JyTdtvBO6x2llnRI1+gxwIyPqCKAn3THIKk=' , 'admin');


select * from usuarios;
select * from filmes;


SELECT f.*, u.nome AS nome_usuario
FROM filmes f
LEFT JOIN usuarios u ON f.usuario_id = u.id_usuario;


SELECT f.*, u.nome AS nome_usuario
FROM filmes f
LEFT JOIN usuarios u ON f.usuario_id = u.id_usuario
ORDER BY f.id_filme DESC;





