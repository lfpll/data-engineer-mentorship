if table city exists drop table city;
if table state exists  drop table state;

-- Criando tabela de cidade normalizando a tabela customers
create table public.city (
	id serial primary key,
	city_name unique text not null,
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
	state_name unique text not null,
	constraint fk_state
		FOREIGN KEY(id) 
	  	REFERENCES city(state_id)
);

-- Inserindo as informações dos estados
insert into public.state(state_name)
set state_name = states.state_name
from (select distinct state_name in city) states;

-- Adicionando as ids a tabela cidade
update city
set state_id = state.id 
from state as st 
where st.state_name = city.state_name;

-- Dropando a coluna com o nome da tabela citys
alter table city drop column state_name;

-- Adicionando a ligação entre city e state
alter table city add CONSTRAINT fk_state FOREIGN key (state_id) REFERENCES state(id); 
alter table customers add CONSTRAINT fk_city FOREIGN key (city_id) REFERENCES city(id); 