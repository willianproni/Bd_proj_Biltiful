CREATE PROCEDURE adicionar_cliente
	@cpf_cliente		NVARCHAR(11),
	@nome_cliente		NVARCHAR(50),
	@data_nascimento	DATETIME,
	@sexo char
AS
	INSERT INTO tb_cliente (cpf_cliente, nome_cliente, data_nascimento, sexo)
	values (@cpf_cliente, @nome_cliente, @data_nascimento, @sexo)

--	exec adicionar_cliente '44954343810', 'Willian Proni', '30/06/2002', 'M'

CREATE PROCEDURE exibir_cliente
AS
	select cpf_cliente as CPF, nome_cliente as Nome, convert(varchar, data_nascimento, 103) as DataNascimento, sexo as Sexo, convert(varchar, ultima_compra, 103)as UltimaCompra, situacao_cliente as Situação, data_cadastro as Cadastro 
	from tb_cliente

--	exec exibir_cliente

CREATE PROCEDURE adicionar_cliente_inadimplente
	@cpf_cliente	NVARCHAR(11)
AS
	INSERT INTO  tb_risco (cpf_cliente)
	values (@cpf_cliente)

CREATE PROCEDURE adicionar_fornecedor_bloqueado
	@cnpj_fornecedor NVARCHAR(14)
AS
	INSERT INTO tb_bloqueado (cnpj_fornecedor)
	values (@cnpj_fornecedor)

CREATE PROCEDURE busca_cliente_cpf
	@cpf_cliente NVARCHAR(11)
AS
	select cpf_cliente, nome_cliente
	from tb_cliente
	where cpf_cliente = @cpf_cliente
	return

	exec busca_cliente_cpf '44954343810'


CREATE PROCEDURE adicionar_fornecedor
	@cnpj_fornecedor	NVARCHAR(14),
	@razao_social		NVARCHAR(50),
	@data_abertura		DATETIME
AS
	INSERT INTO tb_fornecedor (cnpj_fornecedor, razao_social, data_abertura)
	values (@cnpj_fornecedor, @razao_social, @data_abertura)

--	exec adicionar_fornecedor '06696401075', 'Willian Sa', '02/06/2016'

CREATE PROCEDURE exibir_fornecedor
AS
	select cnpj_fornecedor AS CNPJ, razao_social AS RazãoSocial, convert(varchar,data_abertura, 103) as DataAbertura, convert(varchar,ultima_compra , 103) as UltimaCompra, situacao_fornecedor as Situação, convert(varchar, data_cadastro , 103) as DataCadastro
	from tb_fornecedor

-- exec exibir_fornecedor

CREATE PROCEDURE adicionar_produto
	@codiga_barra	NVARCHAR(13),
	@nome_produto	NVARCHAR(50),
	@valor_venda	NUMERIC(5,2)
AS
	INSERT INTO tb_produto (codigo_barra, nome_produto, valor_venda)
	values (@codiga_barra, @nome_produto, @valor_venda)

CREATE PROCEDURE exibir_produto
AS
	select codigo_barra as CodigoBarra, nome_produto as Produto, valor_venda as Valor, convert(varchar, ultima_venda , 103) as UltimaVenda, situacao_produto as Situação, convert(varchar, data_cadastro, 103) as DataCadatro
	from tb_produto

CREATE PROCEDURE adicionar_materia_prima
	@nome_mat_prima NVARCHAR(50)
AS
	INSERT INTO tb_materia_prima (nome_mat_prima)
	values (@nome_mat_prima)

CREATE PROCEDURE exibir_materia_prima
AS
	select id_mat_prima AS ID, nome_mat_prima AS MateriaPrima, convert(varchar,ultima_compra, 103) AS UltimaCompra, situacao_mat_prima AS Situação, convert(varchar,data_cadastro , 103) AS DataCadastro  
	from tb_materia_prima

CREATE PROCEDURE adicionar_item_venda
		@valor_total NUMERIC(5,2),


create PROCEDURE adiconar_venda
	@cpf_cliente NVARCHAR(11),
	@valor_total NUMERIC(5,2)
AS
	insert into tb_venda (cpf_cliente, valor_total)
	values (@cpf_cliente, @valor_total)

create PROCEDURE adicionar_item_venda
		@codigo_barra nvarchar(13),
		@quantidade numeric(3)
AS
begin
	DECLARE @id_venda numeric(5),
			@valor_venda NUMERIC(5,2),
			@total_item NUMERIC(6, 2)

	select @valor_venda = valor_venda from tb_produto
	select @id_venda = MAX(id_venda) from tb_venda
	set @total_item = @quantidade * @valor_venda

		INSERT INTO tb_item_venda (id_venda, codigo_barra, quantidade, valor_unitario, total_item)
		VALUES (@id_venda, @codigo_barra, @quantidade, @valor_venda, @total_item)
end

CREATE PROCEDURE exibir_venda
AS
	select id_venda, cpf_cliente, convert(varchar, data_venda, 103), valor_total 
	from tb_venda



	


