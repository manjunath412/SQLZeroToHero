DROP TABLE IF EXISTS vehicle;
 
CREATE TABLE vehicle (
    vehicle_id int, 
    make varchar(255),
    model varchar(255),
    vehicle_type varchar(50),
    mpg float,
    price float);
 
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (1, 'Honda','Accord','car',32,28500);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (2, 'Honda','CRV','suv',30,32000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (3, 'Honda','HRV','suv',28,25000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (4, 'Honda','Civic','car',33,26000);    
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (5, 'Honda','Pilot','suv',22,37000);
 
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (6, 'Mazda','Mazda3','car',31,24000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (7, 'Mazda','CX30','suv',29,24225);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (8, 'Mazda','CX50','suv',27,29000);
 
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (9, 'Hyundai','Elantra','car',37,22000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (10, 'Hyundai','Sonata','car',32,26000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (11, 'Hyundai','Tucson','suv',29,26000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (12, 'Hyundai','Santa Fe','suv',26,30000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (13, 'Hyundai','Palisade','suv',22,37500);
 
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (14, 'Toyota','RAV4','suv',30,28100);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (15, 'Toyota','Camry','car',32,27000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (16, 'Toyota','Corolla','car',35,23000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (17, 'Toyota','Sequoia','suv',15,52000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (18, 'Toyota','4Runner','suv',17,39500);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (19, 'Toyota','Highlander','suv',24,37000);
 
 
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (20, 'Ford','Bronco','suv',18,31000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (21, 'Ford','Explorer','suv',24,36000);
 
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (20, 'GMC','Acadia','suv',27,36000);
INSERT INTO vehicle(vehicle_id, make, model, vehicle_type, mpg, price)
VALUES (21, 'GMC','Yukon','suv',16,57000);