drop table if exists billing;
 
CREATE TABLE billing (
  bill_date date DEFAULT NULL,
  account varchar(50) DEFAULT NULL,
  amount float DEFAULT NULL
);
 
INSERT INTO billing (bill_date,account,amount) VALUES
	 ('2023-01-01','Prod',3500.0),
	 ('2023-01-01','Test',300.0),
	 ('2023-01-01','Dev',700.0),
	 ('2023-02-01','Prod',3000.0),
	 ('2023-02-01','Test',500.0),
	 ('2023-02-01','Dev',800.0),
	 ('2023-03-01','Prod',2750.0),
	 ('2023-03-01','Test',1000.0),
	 ('2023-03-01','Dev',1200.0),
	 ('2023-04-01','Prod',2000.0);
INSERT INTO billing (bill_date,account,amount) VALUES
	 ('2023-04-01','Test',1200.0),
	 ('2023-04-01','Dev',1500.0),
	 ('2023-05-01','Prod',2000.0),
	 ('2023-05-01','Test',2000.0),
	 ('2023-05-01','Dev',1800.0),
	 ('2023-06-01','Prod',2250.0),
	 ('2023-06-01','Test',1200.0),
	 ('2023-06-01','Dev',1250.0),
	 ('2023-07-01','Prod',2350.0),
	 ('2023-07-01','Test',1000.0);
INSERT INTO billing (bill_date,account,amount) VALUES
	 ('2023-07-01','Dev',1700.0);