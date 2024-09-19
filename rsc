-- Criar o banco de dados
CREATE DATABASE imobiliaria;

-- Usar o banco de dados
USE imobiliaria;

-- Criar tabela de propriedades
CREATE TABLE propriedades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    endereco VARCHAR(255) NOT NULL,
    tipo ENUM('Apartamento', 'Casa', 'Terreno', 'Comercial') NOT NULL,
    area DECIMAL(10, 2) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    status ENUM('Disponível', 'Vendido', 'Alugado') DEFAULT 'Disponível',
    descricao TEXT
);

-- Criar tabela de clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100)
);

-- Criar tabela de agentes
CREATE TABLE agentes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100),
    comissao DECIMAL(5, 2) DEFAULT 0.00
);

-- Criar tabela de vendas
CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    propriedade_id INT,
    cliente_id INT,
    agente_id INT,
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (propriedade_id) REFERENCES propriedades(id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (agente_id) REFERENCES agentes(id)
);

-- Inserir dados de exemplo em propriedades
INSERT INTO propriedades (endereco, tipo, area, preco, status, descricao)
VALUES
('Rua das Flores, 123', 'Casa', 120.50, 250000.00, 'Disponível', 'Linda casa com jardim.'),
('Avenida Brasil, 456', 'Apartamento', 75.00, 150000.00, 'Disponível', 'Apartamento com vista para o mar.'),
('Rua da Paz, 789', 'Terreno', 300.00, 80000.00, 'Disponível', 'Terreno em ótima localização.'),
('Rua do Comércio, 101', 'Comercial', 200.00, 500000.00, 'Disponível', 'Prédio comercial com várias salas.');

-- Inserir dados de exemplo em clientes
INSERT INTO clientes (nome, telefone, email)
VALUES
('João Silva', '11987654321', 'joao@email.com'),
('Maria Oliveira', '11876543210', 'maria@email.com');

-- Inserir dados de exemplo em agentes
INSERT INTO agentes (nome, telefone, email, comissao)
VALUES
('Carlos Almeida', '11765432109', 'carlos@email.com', 5.00),
('Ana Santos', '11654321098', 'ana@email.com', 4.00);

-- Inserir dados de exemplo em vendas
INSERT INTO vendas (propriedade_id, cliente_id, agente_id, valor)
VALUES
(1, 1, 1, 250000.00),
(2, 2, 2, 150000.00);

-- Consultas básicas

-- 1. Listar todas as propriedades
SELECT * FROM propriedades;

-- 2. Listar todos os clientes
SELECT * FROM clientes;

-- 3. Listar todas as vendas com detalhes
SELECT v.id AS venda_id, p.endereco, c.nome AS cliente, a.nome AS agente, v.data_venda, v.valor
FROM vendas v
JOIN propriedades p ON v.propriedade_id = p.id
JOIN clientes c ON v.cliente_id = c.id
JOIN agentes a ON v.agente_id = a.id;

-- 4. Listar propriedades disponíveis
SELECT * FROM propriedades WHERE status = 'Disponível';
