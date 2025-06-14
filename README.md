DROP DATABASE IF EXISTS brain;
CREATE DATABASE brain;
USE brain;


CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  senha VARCHAR(255) NOT NULL
);



CREATE TABLE filmes (
  id_filme INT AUTO_INCREMENT PRIMARY KEY,
  nome_filme VARCHAR(255) NOT NULL,
  genero VARCHAR(100) NOT NULL,
  nota DOUBLE,
  descricao TEXT,
  usuario_id INT,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario)
);
ALTER TABLE filmes ADD trailer_link VARCHAR(255);


CREATE TABLE musicas (
  id_musica INT AUTO_INCREMENT PRIMARY KEY,
  nome_musica VARCHAR(255) NOT NULL,
  descricao TEXT,
  usuario_id INT,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario)
);

ALTER TABLE usuarios ADD tipo ENUM('admin', 'comum') DEFAULT 'comum';
UPDATE usuarios SET tipo = 'admin' WHERE email = 'admin@admin.com';


INSERT INTO usuarios (nome, email, senha)
VALUES ('Administrador', 'admin@admin.com', 'admin123');

DESCRIBE filmes;

SELECT * FROM usuarios;
