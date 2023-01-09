--
-- Создаю таблицы и добавляю данные 
--

create table clients
(client_id serial not null,
name text not null,
primary key (client_id)
);

insert into clients(name)
values  ('Иванов'),
		('Петров'),
		('Сидоров');

select * from clients;

create table contracts
(contract_id serial not null,
client_id integer not null,
contract_num text not null,
primary key (contract_id),
foreign key (client_id) 
 	references clients (client_id)
 	 on delete cascade 
);

insert into contracts (client_id, contract_num)
values  (1, '1589/78'),
		(1, '2016/987'),
		(1, '3005/154'),
		(2, '45/78962'),
		(2, '589/54'),
		(3, '678/45');

select * from contracts;

create table operation
(op_id serial not null,
contract_id integer not null,
date date not null,
summa integer not null,
primary key (op_id),
foreign key (contract_id) 
 	references contracts (contract_id)
 	 on delete cascade 
);

insert into operation (contract_id, date, summa)
values  (1, '2022-06-01', 800),
		(1, '2022-07-01', 50),
		(2, '2022-03-23', 300),
		(4, '2022-08-15', 900),
		(4, '2022-02-01', 1000),
		(5, '2022-03-09', 200),
		(6, '2022-08-15', 700);

select * from operation;

select cl.name, max(o.date) 
from operation as o left join 
contracts as c on o.contract_id=c.contract_id
right join clients as cl on c.client_id=cl.client_id
group by cl.name;

explain select cl.name, max(o.date) 
from operation as o left join 
contracts as c on o.contract_id=c.contract_id
right join clients as cl on c.client_id=cl.client_id
group by cl.name;

select cl.name, sum(o.summa) 
from operation as o left join 
contracts as c on o.contract_id=c.contract_id
right join clients as cl on c.client_id=cl.client_id
group by cl.name;

explain analyze select cl.name, max(o.date) 
from operation as o left join 
contracts as c on o.contract_id=c.contract_id
right join clients as cl on c.client_id=cl.client_id
group by cl.name;

-- для ускорения данных запросов так же можно создать index