
-- Teacher
INSERT INTO teacher (surname, name, patronymic, is_class_teacher) VALUES
    ('Smith', 'John', 'Doe', TRUE),
    ('Johnson', 'Alice', 'Smith', FALSE),
    ('Williams', 'Robert', 'Johnson', TRUE),
    ('Jones', 'Mary', 'Williams', FALSE),
    ('Brown', 'James', 'Jones', TRUE),
    ('Davis', 'Linda', 'Brown', FALSE),
    ('Miller', 'William', 'Davis', TRUE);

-- Subject
INSERT INTO subject (name, grade, date_of_grade) VALUES
    ('Math', 10, TRUE),
    ('History', 9, FALSE),
    ('Science', 11, TRUE),
    ('English', 8, FALSE),
    ('Geography', 10, TRUE),
    ('Art', 9, FALSE),
    ('Music', 11, TRUE);

-- Teacher_Subject
INSERT INTO teacher_subject (teacher_id, subject_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7);

-- Class
INSERT INTO class (id, name) VALUES
    ('A1', 'Class A1'),
    ('B1', 'Class B1'),
    ('C1', 'Class C1'),
    ('D1', 'Class D1'),
    ('E1', 'Class E1'),
    ('F1', 'Class F1'),
    ('G1', 'Class G1');

-- Teacher_class
INSERT INTO teacher_class (teacher_id, class_id) VALUES
    (1, 'A1'),
    (2, 'B1'),
    (3, 'C1'),
    (4, 'D1'),
    (5, 'E1'),
    (6, 'F1'),
    (7, 'G1');

-- Student
INSERT INTO student (surname, name, patronymic, class_id, birth_date, address, phone_number, grade, date_of_grade) VALUES
    ('Wilson', 'Michael', 'Brown', 'A1', '2005-05-10', '123 Main St', '555-1234', 9, '2023-06-15'),
    ('Martinez', 'Barbara', 'Davis', 'B1', '2006-02-20', '456 Elm St', '555-5678', 10, '2023-06-16'),
    ('Anderson', 'David', 'Miller', 'C1', '2005-08-15', '789 Oak St', '555-9012', 11, '2023-06-17'),
    ('Taylor', 'Patricia', 'Wilson', 'D1', '2006-01-25', '101 Pine St', '555-3456', 8, '2023-06-18'),
    ('Thomas', 'Charles', 'Martinez', 'E1', '2005-12-05', '202 Maple St', '555-7890', 9, '2023-06-19'),
    ('Hernandez', 'Sarah', 'Anderson', 'F1', '2006-03-30', '303 Cedar St', '555-2345', 10, '2023-06-20'),
    ('Moore', 'Christopher', 'Taylor', 'G1', '2005-07-20', '404 Walnut St', '555-6789', 11, '2023-06-21');

-- Student_subject
INSERT INTO student_subject (student_id, subject_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7);
