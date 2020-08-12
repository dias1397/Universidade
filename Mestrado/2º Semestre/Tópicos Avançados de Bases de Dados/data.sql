INSERT INTO livros VALUES (9780134685991, 'Effective Java', 3, 'Inglês', '18-12-2017', '06-03-2019');
INSERT INTO livros VALUES (9789726081890, '1984', 5, 'Português', '08-06-1949', '06-03-2019');
INSERT INTO livros VALUES (9789726081975, 'A quinta dos animais', 7, 'Português', '17-08-1945', '06-03-2019');
INSERT INTO livros VALUES (9780007448036, 'A game of thrones', 9, 'Inglês', '06-08-1996', '06-03-2019');
INSERT INTO livros VALUES (9780553579901, 'A clash of kings', 9, 'Inglês', '16-11-1998', '06-03-2019');

INSERT INTO autores VALUES ('Joshua', 'Bloch', 'M', '28-08-1961');
INSERT INTO autores VALUES ('George', 'Orwell', 'M', '25-06-1903');
INSERT INTO autores VALUES ('George R. R.', 'Martin', 'M', '20-09-1948');

INSERT INTO editoras VALUES ('Addison-Wesley Professional', '13-05-1942', 'Estados Unidos da América');
INSERT INTO editoras VALUES ('HarperCollins Publishers', '24-02-1989', 'Estados Unidos da América');
INSERT INTO editoras VALUES ('Antígona', '01-06-1979', 'Portugal');

INSERT INTO nacionalidades VALUES ('Joshua', 'Bloch', 'Americana');
INSERT INTO nacionalidades VALUES ('George', 'Orwell', 'Britânica');
INSERT INTO nacionalidades VALUES ('George R. R.', 'Martin', 'Americana');

INSERT INTO livros_autores VALUES (9789726081890, 'George', 'Orwell');
INSERT INTO livros_autores VALUES (9789726081975, 'George', 'Orwell');
INSERT INTO livros_autores VALUES (9780007448036, 'George R. R.', 'Martin');
INSERT INTO livros_autores VALUES (9780553579901, 'George R. R.', 'Martin');
INSERT INTO livros_autores VALUES (9780134685991, 'Joshua', 'Bloch');

INSERT INTO livros_editoras VALUES (9780134685991, 'Addison-Wesley Professional');
INSERT INTO livros_editoras VALUES (9780007448036, 'HarperCollins Publishers');
INSERT INTO livros_editoras VALUES (9780553579901, 'HarperCollins Publishers');
INSERT INTO livros_editoras VALUES (9789726081890, 'Antígona');
INSERT INTO livros_editoras VALUES (9789726081975, 'Antígona');