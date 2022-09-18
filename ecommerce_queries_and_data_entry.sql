use ecommerce;
show tables;

-- idCLiente, nome, nome_meio, sobrenome, CPF, Endereço
insert into cliente(nome, nome_meio, sobrenome, CPF, Endereço)
	values('Breno','R', 'Lucena', '12345678900', 'Rua Thadorodrim, 1, Beleriand'),
		  ('Jango','O', 'hipinotizador', '12345678901', 'Rua Seila, 5 - East Blue'),
		  ('Nick','', 'Write', '12345678902', '123 xola street - Miami'),
		  ('João','Q', 'Martins', '12345678903', 'Rua transilvania, 2 - Pensilvania'),
		  ('Shun','', 'Kim', '12345678904', 'Rua da massa, 6 - Casa Forte'),
		  ('Mogli','D', 'de Pedra', '12345678905', 'Rua da selva, 145 - Manguetown');
desc cliente;
select * from cliente;

-- idProduto, nome, classificação_criança, categoria('eletrônico','roupa','brinquedos','alimentos','móveis'), dimensões
insert into produto(nome, classificação_criança, categoria, avaliação, dimensões) 
	values('Headset', false, 'eletrônico', '4', null),
		  ('Barbie', true, 'brinquedos', '3', null),
		  ('Camisa', true, 'roupa', '5', null),
		  ('Microfone', false, 'eletrônico', '4', null),
		  ('Poltrona', false, 'móveis', '5', '120x120x80'),
          ('Pizza', false, 'alimentos', '5', 'média');
desc produto;
select * from produto;

-- idPedidoCliente, descriçãoPedido, statusPedido('aguardando','processando','enviado','entregue'), frete, pagamentoBoleto
insert into pedido(idPedidoCliente, descriçãoPedido, statusPedido, frete, pagamentoBoleto) 
	values(1, 'compra via aplicativo', 'entregue', null,false),
		  (2, 'compra via aplicativo', 'aguardando', 50,false),
          (3, 'compra via website', 'enviado', null, true),
          (4, 'compra via website', 'processando', null, true),
          (1, 'compra via aplicativo', 'entregue', default, false);
desc pedido;
select * from pedido;

-- idPEproduto, idPEpedido, quantidadePedido, statusPedido('disponível','sem estoque')
insert into produtoPedido(idPEproduto, idPEpedido, quantidadePedido, statusPedido)
	values(7, 1, 2, 'disponível'),
		  (9, 4, 1, 'sem estoque'),
          (12, 5, 1, null);
desc produtoPedido;
select * from produtoPedido;

-- localEstoque, quantidade
insert into estoque(localEstoque, quantidade)
	values('Recife', 1000),
		  ('Rio de Janeiro', 500),
          ('Recife', default),
          ('São Paulo', 10),
          ('Arda', 60),
          ('Recife', 15),
          ('Recife', 2);
desc estoque;
select * from estoque;

-- idEstoque, idPestoque, localidade
insert into produtoEmEstoque(idEstoque, idPestoque, localidade)
	values(1, 7, 'PE'),
		  (2, 12, 'PE');
desc produtoEmEstoque;
select * from produtoEmEstoque;

-- razaoSocialFornecedor, CNPJ, contato
insert into fornecedor(razaoSocialFornecedor, CNPJ, contato)
	values('Lucena Iron Works', 123456789123456, '22222222222'),
		  ('Eletrônicos Silva', 123456789123789, '33333333333'),
          ('Teslars Motors', 123456789123201, '55555555555');
select * from fornecedor;

-- idPfornecedor, idFproduto, quantidade
insert into produtoFornecedor(idPfornecedor, idFproduto, quantidade)
	values(2, 7, 500),
		  (3, 9, 2),
          (1, 12, 15),
          (2, 10, 30),
		  (3, 11, 2);
select * from produtoFornecedor;

-- razaoSocialVendedor, nomeFantasia, CNPJ, CPF, localidade, contato
insert into vendedor(razaoSocialVendedor, nomeFantasia, CNPJ, CPF, localidade, contato)
	values('Tech eletronics', null, 123456789147852, null, 'Rio de Janeiro', 77777777777),
		  ('Botique Durgas', null, null, 12345678958, 'Recife', 88888888888),
          ('Kids World', null, 789456123789456, null, 'São Paulo', 99999999999);
select * from vendedor;

-- idPvendedor, idPproduto, quantidadeProduto
insert into produtoVendedor(idPvendedor, idPproduto, quantidadeProduto)
	values(1, 7, 30),
		  (3, 8, 10),
          (2, 9, 100);
select * from produtoVendedor;

-- idPagCliente, valor, tipoPagamento('boleto', 'crédito', 'débito', 'dinheiro'), parcelarCompra('3X', '6X', '12x'),

insert into pagamento(idPagCliente, valor, tipoPagamento, parcelarCompra)
	values(1, 1000.00, 'dinheiro', null),
		  (2, 3000.00, 'crédito', default),
          (4, 5000.00, 'crédito', '12x');
select * from pagamento;

-- idPagPagamento, idPagPedido
insert into pagamentoPedido(idPagPagamento, idPagPedido)
	values(1, 1),
		  (2, 2),
          (3, 4);
select * from pagamentoPedido;


-- Queries dos dados persistidos
select count(*) from cliente;
select * from cliente as c, pedido as p where c.idCliente = idPedidoCliente;

select concat(nome, ' ', sobrenome) as Cliente, idPedido as Pedido, statusPedido as Situação from cliente as c, pedido as p where c.idCliente = idPedidoCliente;

-- Recuperar pedido realizado por cada cliente
select * from cliente as c, pedido as p 
	where c.idCliente = idPedidoCliente
    group by idPedido;

-- Recuperar o pedido com produto associado
select * from cliente 
	inner join pedido on idCliente = idPedidoCliente
	inner join produtoPedido on idPEpedido = idPedido
    order by nome;
    
select * from cliente inner join pedido on idCliente = idPedidoCliente
	inner join produtoPedido on idPEpedido = idPedido
    group by idCliente;
    
-- Recuperar quantos pedidos foram realizados por cada cliente
select idCliente, nome, count(*) as Numero_de_pedidos from cliente inner join pedido on idCliente = idPedidoCliente
	inner join produtoPedido on idPEpedido = idPedido
    group by idCliente;