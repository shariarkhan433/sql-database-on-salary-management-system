--lab1, select & decribe operation
describe employee;
describe payment_history;
describe salary;
describe payment_item;
describe bonus;
describe allowance;

select * from employee;
select * from payment_history;
select * from salary;
select * from payment_item;
select * from bonus;
select * from allowance;

--lab2

alter table allowance
add (vat_refund VARCHAR(15);
 govt_scheme VARCHAR(15));
 
alter table allowance
drop column vat_refund;
ALTER TABLE allowance
drop column govt_scheme;

ALTER TABLE employee
RENAME column branch to place;
ALTER TABLE employee
RENAME COLUMN place to branch;

--update and value 
UPDATE salary
set emp_fname= 'shariar'
WHERE  emp_id= 860543;

-- lab3
SELECT id_no,payment_date FROM payment_history;

SELECT DISTINCT(id_no) FROM payment_history;

--divide amount by 5 where salary amount is >=74000

--using BETWEEN & AND
SELECT emp_fname from salary
WHERE amount BETWEEN 70000 AND 74000;

--using IN 
SELECT emp_fname from salary
WHERE amount IN(70000,74000);

--order by
select emp_fname,emp_lname
from salary
ORDER BY amount;

--find employee where name starts and ends with name
SELECT emp_name,emp_id
FROM employee
where emp_name LIKE 'N%'
and WHERE emp_name LIKE '%N';

--who has zi in middle of first name
SELECT emp_fname, emp_lname
FROM salary
WHERE emp_fname LIKE '%_ZI_%';

--lab4
SELECT COUNT(*),COUNT(basic) FROM payment_item;

SELECT SUM(basic) from payment_item;

--to see how many got education_allowance below 500
SELECT education_allowance, COUNT(id)
FROM allowance
GROUP BY education_allowance
HAVING education_allowance<500;
--using WHERE
SELECT education_allowance, COUNT(id)
FROM allowance
WHERE education_allowance<500
GROUP BY education_allowance;

--lab5,
--to find the salaries above 70k
 select emp_id,emp_name
    from salary
    where emp_name in(
    select emp_name
    from salary
    where amount > 70000);
  
--to find which employee is from barisal

 select emp_name
   from employee
   where branch='Barisal';
  
--using cursor, we are determining who have monthly increment over 500 and Hossain as thier last name

 SELECT e.emp_id, e.emp_name
 FROM employee e
 WHERE e.emp_id in (
 SELECT s.emp_id 
  FROM payment_item p, salary s 
   WHERE p.monthly_increment>500
   AND s.emp_lname = 'Hossain');

--lab6
--finding employee who got overtime bonus over 6000 using JOIN
SELECT e.emp_name,e.emp_id, overtime_bonus b
FROM employee e join bonus b
ON (e.emp_id=b.id)AND(b.overtime_bonus>6000);

--natural join
SELECT e.emp_id,e.emp_name, b.overtime_bonus
FROM employee e natural join bonus b
WHERE b.overtime_bonus>6000;

--natural join 3 tables 
SELECT e.emp_name, s.amount, p.log_history
from employee e natural join salary s natural join payment_history p;

--outer join
--left
SELECT e.emp_name, s.amount
from employee e left outer join salary s
ON e.emp_id=s.emp_id;
--right
SELECT e.emp_name, s.amount
from employee e right outer join salary s
ON e.emp_id=s.emp_id;
--FULL
SELECT e.emp_name, s.amount
from employee e FULL outer join salary s
ON e.emp_id=s.emp_id;

--lab7 
--finding max salary using pl-sql 
set serveroutput ON
DECLARE
max_salary salary.amount%TYPE;

BEGIN
SELECT MAX(amount) into max_salary
FROM salary;

DBMS_OUTPUT.PUT_LINE('THE MAX AMOUNT IS '|| max_salary );
end;
/

--finding salary from thier name
set severoutput ON
DECLARE
emp_salary salary.amount%TYPE;
name salary.fname%TYPE :='Nazmul';

BEGIN
SELECT amount INTO emp_salary
FROM salary
where fname=name;

DBMS_OUTPUT.PUT_LINE(NAME||'s SALARY IS '|| emp_salary);
END;
/

--print message according to housing rent allowance
set serveroutput ON
DECLARE
rent allowance.housing_rent_allowance%TYPE;
name employee.emp_name%TYPE;
BEGIN
name='Forhad';
SELECT housing_rent_allowance INTO rent
from allowance, employee
WHERE employee.emp_id=allowance.id AND emp_name=name;

IF rent>15000 THEN
   DBMS_OUTPUT.PUT_LINE('HIS RENT IS OVER 15K');
ELSIF rent=15000 THEN
     DBMS_OUTPUT.PUT_LINE('HIS RENT IS 15K');
ELSIF rent<15000 THEN
  DBMS_OUTPUT.PUT_LINE('HIS RENT IS LESS THAN 15K');
end IF;
end;
/

--lab8
--add TRANSACTION_INFO using PROCEDURE and multiple arguent 
CREATE OR REPLACE PROCEDURE TRANSACTION_INFO(
    id_num payment_history.id_no%TYPE,
	transaction_num payment_history.transaction_id%TYPE,
	t_date payment_history.payment_date%TYPE,
	log_info payment_history.log_history%TYPE) IS

BEGIN
INSERT INTO payment_history(id_no,transaction_id,payment_date,log_history)
VALUES(id_num,transaction_num,t_date,log_info);
END TRANSACTION_INFO;
/
SHOW ERRORS
SELECT * FROM payment_history;
BEGIN 
  TRANSACTION_INFO(806541,'ADQ244DV53','17-june-2022','10:45PM');
end;
/

--lab9

 
	
  
