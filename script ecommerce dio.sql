-- Criação do banco de dados para o cenario de E-commerce 
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table client(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
	constraint unique_cpf_client unique (CPF)
    );

-- criar tabela produto

-- size equivale = dimensão do produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    classification_kids bool default false,
    category enum('Eletrônico','Vestimenta','Alimentos','Móveis') not null,
    Avaliação float default 0,
    size varchar(10)
    );
    
-- para sercontinuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no diagrama de esquema relacional
-- criar constraints relacionadas ao pagamento

 create table payment(
	idClient int,
    id_payment int,
    cash float,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    primary key(idClient, id_payment) 
 );
 
-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_ordes_client foreign key (idOrderClient) references client(idClient)
);

-- criar tabela de estoque
create table productStorage(
	idProductStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact varchar(11) not null,
    constraint unique_suppleir unique (CNPJ)
);

-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
	SocialName varchar(255) not null,
    AbsName varchar(255),
    CNPJ char(15),
    CPF char(9),
    Location varchar(255),
    contact varchar(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
    );
    
  create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key(idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key(idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key(idPsProduct) references product(idProduct)
  );
    
-- show databases;
-- use information_schema;
-- show tables;

-- comando para mostrar todas as constraints do banco--
-- desc referential_constraints;

--  select * from referential_constraints where constraint_schema = 'ecommerce';