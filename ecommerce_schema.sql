-- criação do banco de dados para E-commerce
-- drop database ecommerce;
-- show databases;
create database ecommerce;
use ecommerce;
show tables;

-- criar tabela cliente
create table cliente(
	idCliente int auto_increment primary key, 
	nome varchar(10), 
	nome_meio char(3),
    sobrenome varchar(20),
    CPF char(11) not null,
    Endereço varchar(255),
    constraint unique_CPF_client unique(CPF)
);

-- criar tabela produto
create table produto(
	idProduto int auto_increment primary key, 
	nome varchar(10) not null, 
    classificação_criança bool default false,
    categoria enum('eletrônico', 'roupa', 'brinquedos', 'alimentos', 'móveis') not null,
    avaliação float default 0,
    dimensões varchar(10)
);

-- criar tabela pagaento
-- Terminar de implementar a tabela e criar a conexão com tabelas necessárias
-- Refletir a modificação no diagrama relacional
-- criar constraints relacionadas ao pagamento
create table pagamento(
	idPagamento int auto_increment primary key,
    idPagCliente int,
    valor float,
    tipoPagamento enum('boleto', 'crédito', 'débito', 'dinheiro') not null,
    parcelarCompra enum('3X', '6X', '12x') default '3X',
    constraint fk_pagamento_client foreign key(idPagCliente) references cliente(idCliente)
);

-- criar tabela pedido
create table pedido(
	idPedido int auto_increment primary key,
    idPedidoCliente int,
    descriçãoPedido varchar(255),
    statusPedido enum('aguardando', 'processando', 'enviado', 'entregue') default 'processando',
    frete float default 10,
    pagamentoBoleto boolean default false,    
    constraint fk_pedido_cliente foreign key(idPedidoCliente) references cliente(idCliente)
    on update cascade
);

-- criar tabela estoque
create table estoque(
	idEstoque int auto_increment primary key,
    localEstoque varchar(45),
    quantidade int default 0
);

-- criar tabela fornecedor
create table fornecedor(
	idFornecedor int auto_increment primary key,
    razaoSocialFornecedor varchar(255) not null,
    CNPJ char(15) not null unique,
    contato char(11) not null,
    constraint unique_fornecedor unique(CNPJ)
);


-- criar tabela vendedor
create table vendedor(
	idVendedor int auto_increment primary key,
    localidade varchar(45),
    razaoSocialVendedor varchar(255) not null unique,
    nomeFantasia varchar(255),
    CNPJ char(15) unique,
    CPF char(11) unique,
    contato char(11) not null,
    constraint unique_cnpj_vendedor unique (CNPJ),
    constraint unique_cpf_vendedor unique (CPF)
);

-- criar tabela Produto_vendedor
create table produtoVendedor(
	idPvendedor int,
    idPproduto int,
    quantidadeProduto int default 1,
    primary key(idPvendedor, idPproduto),
    constraint fk_produto_vendedor foreign key(idPvendedor) references vendedor(idVendedor),
    constraint fk_produto_produto foreign key(idPproduto) references produto(idProduto)
    );
  
-- criar tabela Produto_pedido
create table produtoPedido(
	idPEproduto int,
    idPEpedido int,
    quantidadePedido int default 1,
    statusPedido enum('disponível', 'sem estoque') default 'disponível',
    primary key(idPEproduto, idPEpedido),
    constraint fk_pedido_produto foreign key(idPEproduto) references produto(idProduto),
	constraint fk_produto_pedido foreign key(idPEpedido) references pedido(idPedido)
);    

-- criar tabela Produto_em_estoque
create table produtoEmEstoque(
	idEstoque int,
    idPestoque int,
    localidade varchar(255) not null,
    primary key (idEstoque, idPestoque),
    constraint fk_produto_estoque foreign key(idEstoque) references estoque(idEstoque),
    constraint fk_estoque_produto foreign key(idPestoque) references produto(idProduto)
);

-- criar tabela Produto_fornecedor
create table produtoFornecedor(
	idPfornecedor int,
    idFproduto int,
    quantidade int not null,
    constraint fk_produto_fornecedor foreign key(idPfornecedor) references fornecedor(idFornecedor),
    constraint fk_fornecedor_produto foreign key(idFproduto) references produto(idProduto)
);

-- criar tabela Pagamento_pedido
create table pagamentoPedido(
	idPagPagamento int,
    idPagPedido int,
    constraint fk_pagamento_pagamento foreign key(idPagPagamento) references pagamento(idPagamento),
    constraint fk_pagamento_pedido foreign key(idPagPedido) references pedido(idPedido)    
);


-- use information_schema;
-- select * from referential_constraints where constraint_schema = 'ecommerce';





