--CREATE DATABASE biltiful

--USE biltiful

SET LANGUAGE 'Brazilian'

CREATE TABLE tb_cliente(
cpf_cliente			NVARCHAR(11) NOT NULL,
nome_cliente			NVARCHAR(50) NOT NULL,
data_nascimento		DATETIME not null,
sexo				CHAR not null,
ultima_compra		DATETIME DEFAULT getdate(),
data_cadastro		DATETIME DEFAULT getdate(),
situacao_cliente	CHAR(1) DEFAULT 'A'
CONSTRAINT PK_cpf_cliente PRIMARY KEY (cpf_cliente)
)
GO

CREATE TABLE tb_fornecedor(
cnpj_fornecedor		NVARCHAR(14) NOT NULL,
razao_social		NVARCHAR(50) NOT NULL,
data_abertura		DATETIME NOT NULL,
ultima_compra		DATETIME DEFAULT convert(varchar, getdate(), 3),
data_cadastro		DATETIME DEFAULT convert(varchar ,getdate(), 3),
situacao_fornecedor	CHAR(1) DEFAULT 'A'
CONSTRAINT PK_cnpj_fornecedor PRIMARY KEY (cnpj_fornecedor)
)
GO

CREATE TABLE tb_produto(
codigo_barra		NVARCHAR(13) NOT NULL,
nome_produto		NVARCHAR(50) NOT NULL,
valor_venda			NUMERIC(5,2) NOT NULL,
ultima_venda		DATETIME DEFAULT getdate(),
data_cadastro		DATETIME DEFAULT getdate(),
situacao_produto	CHAR(1) DEFAULT 'A'
CONSTRAINT PK_codigo_barra PRIMARY KEY (codigo_Barra)
)
GO


CREATE TABLE tb_materia_prima(
id_mat_prima		NUMERIC(4) IDENTITY(1,1) NOT NULL,
nome_mat_prima		NVARCHAR(50) NOT NULL,
ultima_compra		DATETIME DEFAULT getdate(),
data_cadastro		DATETIME DEFAULT getdate(),
situacao_mat_prima	CHAR(1) DEFAULT 'A'
CONSTRAINT PK_id_materia_primar PRIMARY KEY (id_mat_prima)
)
GO

CREATE TABLE tb_risco(
cpf_cliente NVARCHAR(11) NOT NULL,
CONSTRAINT FK_cpf_cliente_risco FOREIGN KEY (cpf_cliente) REFERENCES tb_cliente (cpf_cliente)
)
GO

CREATE TABLE tb_bloqueado(
cnpj_fornecedor NVARCHAR(14) NOT NULL
CONSTRAINT FK_cnpj_fornecedor_bloqueado FOREIGN KEY (cnpj_fornecedor) REFERENCES tb_fornecedor(cnpj_fornecedor)
)
GO

CREATE TABLE tb_venda(
id_venda			NUMERIC(5) IDENTITY(1,1) NOT NULL,
data_venda			DATETIME DEFAULT getdate(),
valor_total			NUMERIC(5,2) not null default 0,
cpf_cliente			NVARCHAR(11) NOT NULL
CONSTRAINT PK_id_venda PRIMARY KEY (id_venda)
CONSTRAINT FK_cpf_cliente_venda FOREIGN KEY (cpf_cliente) REFERENCES tb_cliente(cpf_cliente)
)
GO

CREATE TABLE tb_item_venda(
id_venda			NUMERIC(5, 0) NOT NULL,
codigo_barra		NVARCHAR(13) NOT NULL,
quantidade			NUMERIC(3) NOT NULL, 
valor_unitario		NUMERIC(5,2),
total_item			NUMERIC(6, 2)
CONSTRAINT FK_id_venda_item_venda FOREIGN KEY (id_venda) REFERENCES tb_venda (id_venda),
CONSTRAINT FK_codigo_barra_item_venda FOREIGN KEY (codigo_barra) REFERENCES tb_produto (codigo_barra)
)
GO

CREATE TABLE tb_compra(
id_compra			NUMERIC(5) IDENTITY(1,1) NOT NULL,
data_compra			DATETIME DEFAULT getdate(),
valor_total			NUMERIC(7,2) NOT NULL,
cnpj_fornecedor		NVARCHAR(14) NOT NULL
CONSTRAINT PK_id_compra PRIMARY KEY (id_compra), 
CONSTRAINT FK_cnpj_fornecedor_compra FOREIGN KEY (cnpj_fornecedor) REFERENCES tb_fornecedor (cnpj_fornecedor)
)
GO

CREATE TABLE tb_item_compra(
id_compra NUMERIC(5) NOT NULL,
id_mat_prima NUMERIC(4) NOT NULL,
quantidade NUMERIC(5, 2) NOT NULL,
valor_unitario NUMERIC(5, 2) NOT NULL,
total_item NUMERIC(6, 2) NOT NULL,
CONSTRAINT FK_id_compra_item_compra FOREIGN KEY (id_compra) REFERENCES tb_compra (id_compra),
CONSTRAINT FK_id_materia_prima_item_compra FOREIGN KEY (id_mat_prima) REFERENCES tb_materia_prima (id_mat_prima)
)
GO

CREATE TABLE  tb_producao(
id_producao			NUMERIC(5) IDENTITY(1,1) NOT NULL,
data_producao		DATETIME DEFAULT getdate(),
quantidade			NUMERIC(5,2) NOT NULL,
codigo_barra		NVARCHAR(13) NOT NULL,
CONSTRAINT PK_id_producao PRIMARY KEY (id_producao),
CONSTRAINT FK_codigo_barra_producao FOREIGN KEY (codigo_barra) REFERENCES tb_produto(codigo_barra)
)
GO

CREATE TABLE tb_item_producao(
id_producao NUMERIC(5) NOT NULL,
id_mat_prima NUMERIC(4) NOT NULL,
data_producao DATETIME DEFAULT getdate(),
quantidade_mat_prima NUMERIC(5, 2) NOT NULL,
CONSTRAINT FK_id_producao_item_producao FOREIGN KEY (id_producao) REFERENCES tb_producao  (id_producao),
CONSTRAINT FK_id_mat_prima_item_producao FOREIGN KEY (id_mat_prima) REFERENCES tb_materia_prima (id_mat_prima)
)
GO

--insert into tb_fornecedor (cnpj_fornecedor, razao_social, data_abertura)
--values
--		('16410965000192', '5by5', '30/06/2016');

--		select * from tb_fornecedor

--		delete from tb_fornecedor
--		where razao_social = '5by5'

--		select convert(varchar, data_abertura, 3)  from tb_fornecedor
--		select
--		 getdate()
