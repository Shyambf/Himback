-- Удаляем схему public со всеми ее объектами
DROP SCHEMA public CASCADE;

-- Создаем новую схему public
CREATE SCHEMA public;

-- Создаем таблицу Teacher
CREATE TABLE IF NOT EXISTS teacher (
    id SERIAL PRIMARY KEY,
    surname VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    patronymic VARCHAR(50),
    is_class_teacher BOOLEAN
);

-- Создаем таблицу Subject
CREATE TABLE IF NOT EXISTS subject (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    grade INTEGER,
    date_of_grade BOOLEAN
);

-- Создаем таблицу Teacher_Subject для связи учителей с предметами
CREATE TABLE IF NOT EXISTS teacher_subject (
    id SERIAL PRIMARY KEY,
    teacher_id INTEGER NOT NULL,
    subject_id INTEGER NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teacher(id),
    FOREIGN KEY (subject_id) REFERENCES subject(id)
);

-- Создаем таблицу Class
CREATE TABLE IF NOT EXISTS class (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50)
);

-- Создаем таблицу Teacher_class для связи учителей с классами
CREATE TABLE IF NOT EXISTS teacher_class (
    id SERIAL PRIMARY KEY,
    teacher_id INTEGER NOT NULL,
    class_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teacher(id),
    FOREIGN Key (class_id) REFERENCES class(id)
);

-- Создаем таблицу Student
CREATE TABLE IF NOT EXISTS student (
    id SERIAL PRIMARY KEY,
    surname VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    patronymic VARCHAR(50),
    class_id VARCHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone_number VARCHAR(50),
    grade INTEGER,
    date_of_grade DATE,
    FOREIGN KEY (class_id) REFERENCES class(id)
);

-- Создаем таблицу Student_subject для связи студентов с предметами
CREATE TABLE IF NOT EXISTS student_subject (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    subject_id INTEGER NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (subject_id) REFERENCES subject(id)
);
