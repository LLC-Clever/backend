CREATE TYPE PERSON_TYPE AS ENUM ('student', 'teacher');

CREATE TYPE QUESTION_TYPE AS ENUM ('one_answer', 'some_answers', 'input_answer');


CREATE TABLE "Group"
(
    id SERIAL PRIMARY KEY,
    group_name TEXT
);

CREATE TABLE "User"
(
    id SERIAL PRIMARY KEY,
    login TEXT,
    password TEXT,
    first_name TEXT,
    last_name TEXT,
    patronymic TEXT,
    group_id INTEGER,
    role PERSON_TYPE,

    FOREIGN KEY (group_id) REFERENCES "Group" (id)
);

CREATE TABLE "Test"
(
    id SERIAL PRIMARY KEY,
    subject TEXT,
    test_name TEXT,
    start_time TIMESTAMP WITHOUT TIME ZONE,
    end_time TIMESTAMP WITHOUT TIME ZONE,
    question_count INTEGER,
    teacher_id INTEGER,
    /* общая оценка */
    total_grade INTEGER,
    /* оценка на 5 */
    grade_five INTEGER,
    /* оценка на 4 */
    grade_four INTEGER,
    /* оценка на 3 */
    grade_three INTEGER,

    FOREIGN KEY (teacher_id) REFERENCES "User" (id)
);

CREATE TABLE "Question"
(
    id SERIAL PRIMARY KEY,
    test_id INTEGER,
    text TEXT,
    image TEXT,
    type QUESTION_TYPE,
    point TEXT,

    FOREIGN KEY (test_id) REFERENCES "Test" (id)
);

CREATE TABLE "Answer"
(
    id SERIAL PRIMARY KEY,
    question_id INT,
    answer_text TEXT,
    is_correct BOOLEAN,
    answer_image TEXT,

    FOREIGN KEY (question_id) REFERENCES "Question" (id)
);

CREATE TABLE "Test_Part"
(
    id SERIAL PRIMARY KEY,
    test_id INTEGER,
    student_id INTEGER,
    total_score INTEGER,
    grade SMALLINT,
    is_passed BOOLEAN,

    FOREIGN KEY (test_id) REFERENCES "Test" (id),
    FOREIGN KEY (student_id) REFERENCES "User" (id)
);

CREATE TABLE "User_Answer"
(
    id SERIAL PRIMARY KEY,
    answer_id INTEGER,
    student_id INTEGER,

    FOREIGN KEY (answer_id) REFERENCES "Answer" (id),
    FOREIGN KEY (student_id) REFERENCES "User" (id)
);
