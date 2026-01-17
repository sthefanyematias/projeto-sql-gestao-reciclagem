create database db_ecogestao;
use db_ecogestao;

create table moradores (
    id_morador int primary key,
    nome_completo varchar(100),
    apartamento_bloco varchar(20),
    data_cadastro date
);

create table tipos_materiais (
    id_tipo int primary key,
    nome_material varchar(50), 
    pontuacao_por_kg int 
);

create table coletas (
    id_coleta int primary key,
    id_morador int,
    id_tipo int,
    peso_kg decimal(10,2),
    data_coleta date,
    foreign key (id_morador) references moradores(id_morador),
    foreign key (id_tipo) references tipos_materiais(id_tipo)
);

insert into moradores (id_morador, nome_completo, apartamento_bloco, data_cadastro) values
(1, 'ana silva', 'ap 101 - bloco a', '2023-01-15'),
(2, 'bruno souza', 'ap 202 - bloco b', '2023-02-10'),
(3, 'carla oliveira', 'ap 305 - bloco a', '2023-03-05');

insert into tipos_materiais (id_tipo, nome_material, pontuacao_por_kg) values
(1, 'plástico', 10),
(2, 'papel', 5),
(3, 'vidro', 15);

insert into coletas (id_coleta, id_morador, id_tipo, peso_kg, data_coleta) values
(1, 1, 1, 2.5, '2023-10-01'),
(2, 2, 3, 5.0, '2023-10-02'),
(3, 1, 2, 1.2, '2023-10-03'),
(4, 3, 1, 3.0, '2023-10-04');

select 
    m.nome_completo as morador,
    t.nome_material as material,
    c.peso_kg as peso,
    c.data_coleta as data
from coletas as c
inner join moradores as m on c.id_morador = m.id_morador
inner join tipos_materiais as t on c.id_tipo = t.id_tipo
order by c.data_coleta desc;

select 
    sum(peso_kg) as total_plastico_kg
from coletas
where id_tipo = 1;

select 
    m.nome_completo as morador,
    sum(c.peso_kg) as total_acumulado
from coletas as c
inner join moradores as m on c.id_morador = m.id_morador
group by m.nome_completo
order by total_acumulado desc;