create sequence seq_id start 1;

create or replace view temp_view as SELECT nextval('seq_id') as seq_id, *
from read_csv('input/people.csv');

create or replace table people as (select * from temp_view);

drop view temp_view;
drop sequence seq_id;

create or replace view employee as
SELECT ssn, dept, manager FROM people WHERE dept IS NOT NULL;