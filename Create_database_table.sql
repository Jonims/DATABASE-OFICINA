-- criação do banco de dados para o cenário de uma Oficina
create database oficina;
use oficina;

-- criando tabela cliente
create table cliente(
	idcliente int auto_increment primary key,
    nome varchar(45),
    CPF char(11) not null,
    endereco varchar(30),
    telefone varchar(13),
    constraint unique_cpf_cliente unique(CPF)
    
);

alter table cliente auto_increment=1;

-- criando tabela mecanico

create table equipeMecanico(
	idequipe_Mecanico int auto_increment primary key,
    nome varchar(255) not null,
    descricao_servico varchar (255) not null,
    codigo varchar(45) not null,
    endereco varchar(255),
    especialidade varchar(45),
    constraint unique_codigo_equipe_mecanico unique(codigo)
    
);


-- criando tabela Veículo
create table veiculo(
	idveiculo int auto_increment primary key,
    idveiculo_meca int,
    tipo_veiculo varchar(45),
    placa char(6),
    constraint fk_veiculo_equipe_mecanico foreign key (idveiculo_meca) references equipeMecanico(idequipe_Mecanico)

);

-- criando tabela oficina_gestor
create table oficina_gestor(
	idoficina_gestor int auto_increment primary key,
    idCliente_Gestor int,
    conserto enum("Sim","Não"),
    revisao enum("Sim","Não"),
    constraint fk_oficina_gestor_equipe_cliente foreign key (idCliente_Gestor) references cliente(idcliente)
    );
    
-- criadno tabela Ordem de servico
create table os(
	idos int auto_increment primary key,
    idOsMecanico int,
    idOsGestor int,
    nome varchar(45) not null,
    data_emissao date,
    valor float,
    osStatus enum("Em andamento", "Finalizado") default "Em andamento",
    previsaoData date,
    constraint fk_os_mecanico foreign key (idOsMecanico) references equipeMecanico(idequipe_Mecanico),
    constraint fk_os_gestor foreign key (idOsGestor) references oficina_gestor(idoficina_gestor)
    );
    

-- criando tabela mao de obra
create table mao_obra(
	idmao_obra int auto_increment primary key,
    idMOordemser int,
    idMOeqquipemec int,
    peca varchar(255) not null,
    valor_uni float,
    valor_total float,
	constraint fk_mao_obra_ordem_servico foreign key (idMOordemser) references os(idos),
    constraint fk_mao_obra_equipe_mecanico foreign key (idMOeqquipemec) references equipeMecanico(idequipe_Mecanico)
    );

    
-- criando tabela relação mao de obra / cliente
create table maoObra_cliente (
	idmaoObra_clienter int,
    idMC_maodeobra int,
    idMC_cliente int,
    primary key(idMC_maodeobra, idMC_cliente),
    constraint fk_maoObra_clientet_mao_de_obra foreign key (idMC_maodeobra) references mao_obra(idmao_obra),
    constraint fk_maoObra_cliente_cliente foreign key (idMC_cliente) references cliente(idcliente)
);
