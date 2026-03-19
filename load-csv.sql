-- This SQL script loads data from CSV into a DuckDB database.

-- You should adapt it to your own CSV file(s) and can be as simple as:

-- CREATE TABLE my_table AS
--    SELECT * FROM read_csv('input/my_file.csv');

-- here, we additionally include a trick to add row numbers,
-- as well as views to partition the data, providing multiple
-- logical sources (see sources.xrm) to facilitate the mapping.

create sequence seq_id start 1;

create or replace view temp_view as SELECT nextval('seq_id') as seq_id, *
from read_csv('input/people.csv');

create or replace table people as (select * from temp_view);

drop view temp_view;
drop sequence seq_id;

create or replace view employee as
SELECT ssn, dept, manager FROM people WHERE dept IS NOT NULL;

create or replace view department as
SELECT DISTINCT dept, manager FROM people WHERE dept IS NOT NULL;