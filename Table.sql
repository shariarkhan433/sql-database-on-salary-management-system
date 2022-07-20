DROP TABLE payment_history;
DROP TABLE salary;
DROP TABLE payment_item;
DROP TABLE bonus;
DROP TABLE allowance;
DROP TABLE employee;
SET SQLBLANKLINES ON

CREATE TABLE employee(
 emp_id number(10) NOT NULL,
 emp_name VARCHAR(20),
 branch VARCHAR(20),
 emp_mobile NUMBER(11),
 emp_mail VARCHAR(20),
 PRIMARY KEY(emp_id)
 );
 
 CREATE TABLE salary(
  emp_id NUMBER(10) NOT NULL,
  emp_fname VARCHAR(10),
  emp_lname VARCHAR(10),
  amount NUMBER(10),
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
  );
 
 CREATE TABLE payment_history(
  id_no number(10) NOT NULL,
  transaction_id VARCHAR(20) NOT NULL, 
  payment_date DATE,
  log_history VARCHAR(20),
  PRIMARY KEY ( transaction_id ),
  FOREIGN KEY (id_no) REFERENCES employee(emp_id)
  );
  
  CREATE TABLE payment_item(
  id NUMBER(10) NOT NULL,
  basic NUMBER(10),
  highly_skilled_pay NUMBER(10),
  good_conduct_pay NUMBER(10),
  monthly_increment number(10),
  FOREIGN KEY (id) REFERENCES employee(emp_id)
  );
  
 CREATE TABLE bonus(
 id NUMBER(10) NOT NULL,
 overtime_bonus VARCHAR(15),
 festivel_bonus VARCHAR(15),
 provident_fund VARCHAR(15),
 FOREIGN KEY (id) REFERENCES employee(emp_id)
 );
 
 CREATE TABLE allowance(
 id number(10) NOT NULL,
 medical_allowance VARCHAR(15),
 education_allowance VARCHAR(15),
 housing_rent_allowance VARCHAR(15),
 FOREIGN KEY (id) REFERENCES employee(emp_id)
 );
 
 
 
