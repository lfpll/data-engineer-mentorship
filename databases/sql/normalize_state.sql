drop table city;
drop table state;

-- Criando tabela de cidade normalizando a tabela customers
create table public.city (
	id serial primary key,
	city_name text not null,
	state_name text not null,
	state_id  integer unique
);

-- Inserindo as infos do estado e cidade na tabela city
insert into public.city(city_name,state_name)
select customer_city,customer_state
from
( select distinct c.customer_city,c.customer_state 
from customers c
) as tb

-- Vendo os dados na tabela
select *
from city;

-- Adicionando a coluna das ids das cidades na tabela customers
alter table customers add column city_id integer;

-- Adicionando as ids a tabela
update customers
set city_id = city.id 
from city 
where customers.customer_city  = city.city_name


-- Removendo colunas que possuem informações em outra referencia
alter table customers drop column customer_city;
alter table customers drop column customer_state;
create table public.state (
	id serial primary key,
	state_name text not null,
	constraint fk_state
		FOREIGN KEY(id) 
	  	REFERENCES city(state_id)
)