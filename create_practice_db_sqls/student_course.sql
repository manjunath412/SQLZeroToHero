drop table if exists student_course;
drop table if exists student;
drop table if exists course;
 
CREATE TABLE student (
  student_id int,
  name varchar(100),
  street varchar(100),
  city varchar(100),
  state varchar(100),
  postal_code varchar(25),
  enrolled_date date,
  PRIMARY KEY (student_id)
);
 
CREATE TABLE course (
  course_id int,
  course_name varchar(255),
  prereq_id int,
  PRIMARY KEY (course_id),
  FOREIGN KEY (prereq_id) REFERENCES course(course_id)
);
 
CREATE TABLE student_course (
  student_id int,
  course_id int,
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES student(student_id),
  FOREIGN KEY (course_id) REFERENCES course(course_id)
);
 
insert into student (student_id, name, street, city, state, postal_code, enrolled_date) 
values (1, 'Alice','123 Main Street','Los Angeles','CA', '90001', '2021-03-25');
insert into student (student_id, name, street, city, state, postal_code, enrolled_date) 
values (2, 'Bob', '456 Oak Avenue','Dallas','TX','75201', '2021-05-10');
insert into student (student_id, name, street, city, state, postal_code, enrolled_date)
values (3, 'Charlie','789 Pine Lane','Orlando','FL','32801','2022-06-15');
insert into student (student_id, name, street, city, state, postal_code, enrolled_date)
values (4, 'Carol','101 Maple Road','Springfield','IL','62701','2022-08-01');
insert into student (student_id, name, street, city, state, postal_code, enrolled_date)
values (5, 'Akil','567 Peach Tree Blvd','Dallas', 'TX','75201', '2023-04-22');
insert into student (student_id, name, street, city, state, postal_code, enrolled_date)
values (6, 'Sam','700 Redwood Drive','Los Angeles','CA', '32801', '2023-05-25');
 
insert into course(course_id, course_name, prereq_id) values (1, 'Dance 1', null);
insert into course(course_id, course_name, prereq_id) values (2, 'Dance 2', 1);
insert into course(course_id, course_name, prereq_id) values (3, 'Dance 3', 2);
insert into course(course_id, course_name, prereq_id) values (4, 'Photography Basics', null);
insert into course(course_id, course_name, prereq_id) values (5, 'Digital Art', null);
insert into course(course_id, course_name, prereq_id) values (6, 'Public Speaking', null);
insert into course(course_id, course_name, prereq_id) values (7, 'Marketing Strategy', null);
insert into course(course_id, course_name, prereq_id) values (8, 'Resume Writing for Success', null);
 
insert into student_course(student_id, course_id) values (1,3);
insert into student_course(student_id, course_id) values (1,4);
insert into student_course(student_id, course_id) values (1,5);
insert into student_course(student_id, course_id) values (1,8);
insert into student_course(student_id, course_id) values (2,6);
insert into student_course(student_id, course_id) values (2,7);
insert into student_course(student_id, course_id) values (2,8);
insert into student_course(student_id, course_id) values (3,1);
insert into student_course(student_id, course_id) values (3,4);
insert into student_course(student_id, course_id) values (3,3);
insert into student_course(student_id, course_id) values (3,8);
insert into student_course(student_id, course_id) values (5,4);
insert into student_course(student_id, course_id) values (5,8);