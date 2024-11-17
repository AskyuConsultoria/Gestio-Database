use askyu;

insert into peca (id, nome, descricao, usuario_id) values 
(100, "Paletó",  "Um paletó com base nas medidas padrões", 1),
(200, "Calça", "Uma calça com base nas medidas padrões", 1),
(300, "Colete", "Um colete com base nas medidas padrões", 1);

insert into nome_medida (nome, peca_id, usuario_id) values 
("A. Cinta", 100, 1),
("A. Quadris", 100, 1),
("Comprimento", 100, 1),
("Torax", 100, 1),
("Cinta", 100, 1),
("Quadris", 100, 1),
("Ombro", 100, 1),
("C. Manga", 100, 1),
("Costas", 100, 1);

insert into nome_medida (nome, peca_id, usuario_id) values 
("L. Coz", 300, 1),
("A. Joelho", 300, 1),
("Comp. Lateral", 300, 1),
("Altura", 300, 1),
("C.E.P", 300, 1),
("Cinta", 300, 1),
("Quadris", 300, 1),
("Boca", 300, 1);

insert into nome_medida (nome, peca_id, usuario_id) values 
("A.Cinta", 200, 1),
("Comprimento", 200, 1),
("Torax", 200, 1),
("Cinta", 200, 1),
("Quadris", 200, 1),
("Degolo", 200, 1),
("C.Dianteiro", 200, 1);


