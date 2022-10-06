SELECT version();
-- PostgreSQL 14.5

--
-- Очень усердные ученики.
--

--
-- Создаю таблицу peas_1 
--
CREATE TABLE peas_1
(st_id INT NOT NULL, -- ID ученика.
 timest date NOT NULL, -- Время решения карточки.
 correct BOOLEAN NOT NULL, -- Правильно ли решена горошина.
 subject TEXT NOT NULL -- дисциплина в которой находится горошина.
);

--
-- Добавляю данные в таблицу peas_1(сгенерируем их на www.mackaroo.com )
-- Учеников 30, время март 2020, тру/фолс, предметов 10. ДАННЫХ 1000 строк
--
COPY peas_1 FROM	
'C:/Users_sql/peas_1.csv'
WITH (FORMAT csv, header);

--
-- Оптимальный запрос, который даст информацию о количестве очень усердных студентов за март 2020 года.
--

with table_tes as 
	(
	select *,
		case 
			when correct is true then 1
		else 0
		end as correct_num
	from peas_1
	where timest between '2020-03-10' and '2020-03-20'
	)
select st_id, count(correct) as count_task, sum(correct_num) as count_solution_task
from table_tes
group by st_id
order by count_task desc, count_solution_task desc
/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */

--
-- Создаю таблицу studs
--
CREATE TABLE studs
(st_id INT NOT NULL, -- ID ученика.
 subject TEXT NOT NULL --группа ученика.
)

--
-- Добавляю данные в таблицу peas_1(сгенерируем их на www.mackaroo.com )
-- Учеников 30, метка ученика 1ая или 2ая группа. ДАННЫХ 30 строк
--
COPY studs FROM	
'C:/Users_sql/studs.csv'
WITH (FORMAT csv, header);

--
-- Создаю таблицу cheks
--
CREATE TABLE cheсks
(st_id INT NOT NULL, -- ID ученика.
 sale_time date NOT NULL, -- Время покупки.
 subject TEXT NOT NULL, -- дисциплина.
 money INT NOT NULL -- цена.
)

--
-- Добавляю данные в таблицу peas_1(сгенерируем их на www.mackaroo.com )
-- Учеников 30, время март 2020, дисциплина, цена. ДАННЫХ 1000 строк
--
COPY cheсks FROM	
'C:/Users_sql/checks.csv'
WITH (FORMAT csv, header);



SELECT * FROM cheсks;
DROP TABLE studs;
