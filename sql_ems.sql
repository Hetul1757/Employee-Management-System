#Create Database 
CREATE DATABASE sqlshack_practice;

#Use Database
USE sqlshack_practice;

#Create City Table
CREATE TABLE city (
	id INT NOT NULL AUTO_INCREMENT,
    city_name CHARACTER(128) NOT NULL,
    lat DECIMAL(9.6) NOT NULL,
    lon DECIMAL(9,6) NOT NULL,
    country_id INT NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

#Create Country Table
CREATE TABLE country (
	id int NOT NULL AUTO_INCREMENT,
    country_name CHARACTER(128) NOT NULL,
    country_name_eng CHARACTER(128) NOT NULL,
    country_code  CHARACTER(8) NOT NULL,
    CONSTRAINT country_ak_1 UNIQUE(country_code),
    CONSTRAINT country_ak_2 UNIQUE(country_name),
    CONSTRAINT country_ak_3 UNIQUE(country_name_eng),
    CONSTRAINT country_pk_1 PRIMARY KEY(id)
); 

#Add Foreign key contraint to connect country table and city table 
ALTER TABLE city ADD CONSTRAINT city_country
	FOREIGN KEY (country_id) 
    REFERENCES country(id);

#Insert data in country table
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Deutschland', 'Germany', 'DEU');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Srbija', 'Serbia', 'SRB');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Hrvatska', 'Croatia', 'HRV');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('United Stated of America', 'United Stated of America', 'USA');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Polska', 'Poland', 'POL');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('India', 'India', 'IND');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Spain', 'Spain', 'ESP');
INSERT INTO country (country_name, country_name_eng, country_code) VALUES ('Russia', 'Russia', 'RUS');

#Insert data in city table
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('Berlin', 52.520008, 13.404954, 1);
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('Belgrade', 44.787197, 20.457273, 2);
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('Zagreb', 45.815399, 15.966568, 3);
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('New York', 40.73061, -73.935242, 4);
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('Los Angeles', 34.052235, -118.243683, 4);
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('Warsaw', 52.237049, 21.017532, 5);
INSERT INTO city (city_name, lat, lon, country_id) VALUES ('India', 20.5937, 78.9629, 6);

ALTER TABLE city 
change lat lat DECIMAL(9,6) NOT NULL;

#Display results
SELECT * FROM city,country;

#SELECT all information of country usa and cities of usa
SELECT city.id AS city_id, city.city_name AS city_name, city.lat as city_latitude, city.lon as city_longitude , country.id AS country_id, country.country_name, country.country_code
FROM city INNER JOIN country ON city.country_id = country.id 
WHERE country.country_name = 'United Stated of America';

#SELECT all information of country with id 1,2,3 and cities 
SELECT city.id AS city_id, city.city_name AS city_name, city.lat as city_latitude, city.lon as city_longitude , country.id AS country_id, country.country_name, country.country_code
FROM city INNER JOIN country ON city.country_id = country.id 
WHERE country.id IN (1,2,3);

#SELECT all information of cities with country_id 1,2,3 and all country information(RIGHT JOIN)
SELECT *
FROM country LEFT JOIN city ON city.country_id = country.id;

#Create table call_info
CREATE TABLE call_info (
    id int NOT NULL AUTO_INCREMENT,
    employee_id int  NOT NULL,
    customer_id int  NOT NULL,
    start_time datetime  NOT NULL,
    end_time datetime  NULL,
    call_outcome_id int  NULL,
    CONSTRAINT call_ak_1 UNIQUE (employee_id, start_time),
    CONSTRAINT call_pk PRIMARY KEY  (id)
);
    
#Create table call_outcome
CREATE TABLE call_outcome (
    id int  NOT NULL AUTO_INCREMENT,
    outcome_text char(128)  NOT NULL,
    CONSTRAINT call_outcome_ak_1 UNIQUE (outcome_text),
    CONSTRAINT call_outcome_pk PRIMARY KEY  (id)
);

#Create table customer
CREATE TABLE customer (
    id int  NOT NULL AUTO_INCREMENT,
    customer_name varchar(255)  NOT NULL,
    city_id int  NOT NULL,
    customer_address varchar(255)  NOT NULL,
    next_call_date date  NULL,
    ts_inserted datetime  NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY  (id)
);
    
#Create table Employee
CREATE TABLE employee (
    id int  NOT NULL AUTO_INCREMENT,
    first_name varchar(255)  NOT NULL,
    last_name varchar(255)  NOT NULL,
    CONSTRAINT employee_pk PRIMARY KEY  (id)
);

#foreign keys
ALTER TABLE call_info ADD CONSTRAINT call_info_call_outcome
    FOREIGN KEY (call_outcome_id)
    REFERENCES call_outcome (id);
    
ALTER TABLE call_info ADD CONSTRAINT call_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id);
 
ALTER TABLE call_info ADD CONSTRAINT call_employee
    FOREIGN KEY (employee_id)
    REFERENCES employee (id);
 
ALTER TABLE customer ADD CONSTRAINT customer_city
    FOREIGN KEY (city_id)
    REFERENCES city (id);

INSERT INTO call_outcome (outcome_text) VALUES ('call started');
INSERT INTO call_outcome (outcome_text) VALUES ('finished - successfully');
INSERT INTO call_outcome (outcome_text) VALUES ('finished - unsuccessfully');
    
INSERT INTO employee (first_name, last_name) VALUES ('Thomas (Neo)', 'Anderson');
INSERT INTO employee (first_name, last_name) VALUES ('Agent', 'Smith');
    
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Jewelry Store', 4, 'Long Street 120', '2020/1/21', '2020/1/9 14:1:20');
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Bakery', 1, 'Kurfürstendamm 25', '2020/2/21', '2020/1/9 17:52:15');
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Café', 1, 'Tauentzienstraße 44', '2020/1/21', '2020/1/10 8:2:49');
INSERT INTO customer (customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES ('Restaurant', 3, 'Ulica lipa 15', '2020/1/21', '2020/1/10 9:20:21');
    
INSERT INTO call_info (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 4, '2020/1/11 9:0:15', '2020/1/11 9:12:22', 2);
INSERT INTO call_info (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 2, '2020/1/11 9:14:50', '2020/1/11 9:20:1', 2);
INSERT INTO call_info (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2, 3, '2020/1/11 9:2:20', '2020/1/11 9:18:5', 3);
INSERT INTO call_info (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 1, '2020/1/11 9:24:15', '2020/1/11 9:25:5', 3);
INSERT INTO call_info (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 3, '2020/1/11 9:26:23', '2020/1/11 9:33:45', 2);
INSERT INTO call_info (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 2, '2020/1/11 9:40:31', '2020/1/11 9:42:32', 2);
INSERT INTO call_info (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2, 4, '2020/1/11 9:41:17', '2020/1/11 9:45:21', 2);
INSERT INTO call_info (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (1, 1, '2020/1/11 9:42:32', '2020/1/11 9:46:53', 3);
INSERT INTO call_info (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2, 1, '2020/1/11 9:46:0', '2020/1/11 9:48:2', 2);
INSERT INTO call_info (employee_id, customer_id, start_time, end_time, call_outcome_id) VALUES (2, 2, '2020/1/11 9:50:12', '2020/1/11 9:55:35', 2);

#Customer Geogrphical information
SELECT  customer.customer_name, country.country_name, city.city_name
FROM 
customer LEFT JOIN city ON customer.city_id = city.id
INNER JOIN country ON city.country_id = country.id;

#Country information
SELECT country.country_name, customer.customer_name, city.city_name
FROM
country LEFT JOIN city ON city.country_id = country.id
LEFT JOIN customer ON customer.city_id = city.id;

#Running some aggregate  functions - 1
SELECT COUNT(*) 
FROM
customer; 

#Running some aggregate  functions - 2
SELECT country.country_name, city.city_name, COUNT(*) AS freuency_count, city.lat, city. lon, AVG(city.lat) AS avarage_latitude, AVG(city.lon) AS avarage_longitude
FROM 
country LEFT JOIN city ON country.id = city.country_id
GROUP BY country.id;

#Complex query to get avarage call duration country wise
SELECT 
	country.country_name, 
    city.city_name,
    COUNT(CASE WHEN call_info.id IS NOT NULL THEN 1 ELSE 0 END) AS call_count,
    AVG(IFNULL(TIMESTAMPDIFF(SECOND,call_info.start_time,call_info.end_time),0)) AS avarage_time
FROM
	country LEFT JOIN 
    city ON country.id = city.country_id LEFT JOIN
    customer ON customer.city_id = city.id LEFT JOIN
    call_info ON call_info.customer_id = customer.id
GROUP BY
	country.id
HAVING avarage_time > 0
ORDER BY avarage_time DESC;

#Information Schema
SELECT *
FROM INFORMATION_SCHEMA.TABLES;

#Customer with eact 3 calls
SELECT customer.* 
FROM customer
	WHERE id in (
    select call_info.customer_id
    FROM call_info
    GROUP BY customer_id
    HAVING COUNT(*)=3);

SELECT customer.*
FROM
country LEFT JOIN city ON country.id = city.country_id
LEFT JOIN customer ON customer.city_id = city.id
WHERE country.country_code = 'USA'  

    












    
    