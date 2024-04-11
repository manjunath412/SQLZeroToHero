drop table if exists aggregation_example;
 
CREATE TABLE aggregation_example (	
    a INT,
    b INT
);
 
-- Insert some sample data with NULL values
INSERT INTO aggregation_example (a) VALUE (10);
INSERT INTO aggregation_example (a) VALUE (null);
INSERT INTO aggregation_example (a) VALUE (15);
INSERT INTO aggregation_example (a) VALUE (20);
INSERT INTO aggregation_example (a) VALUE (null);
INSERT INTO aggregation_example (a) VALUE (25);