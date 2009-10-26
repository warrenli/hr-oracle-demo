REM CREATE USER hr_rails IDENTIFIED BY hr_rails;
REM CONNECT hr_rails/hr_rails

spool setup_hr_rails.log
--
-- drop user objects
DROP SEQUENCE departments_seq;
DROP SEQUENCE employees_seq;
DROP SEQUENCE locations_seq;

DROP TABLE regions     CASCADE CONSTRAINTS;
DROP TABLE departments CASCADE CONSTRAINTS;
DROP TABLE locations   CASCADE CONSTRAINTS;
DROP TABLE jobs        CASCADE CONSTRAINTS;
DROP TABLE employees   CASCADE CONSTRAINTS;
DROP TABLE countries   CASCADE CONSTRAINTS;  

--
-- create tables, sequences and constraint
--
@@hr_cre


-- 
-- populate tables
--
@@hr_popul


--
-- create indexes
--
@@hr_idx

spoo off


