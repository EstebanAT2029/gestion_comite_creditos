<?php

$usuarios = [
    ["Hoyos Correa","Cristian","42284598","choyos@agrobanco.com.pe","999999999","choyos",3],
    ["Silva Collao","Cristian Mauricio","43675820","csilva@agrobanco.com.pe","999999999","csilva",3],
    ["Ramos Taipe","David","20051852","dramost@agrobanco.com.pe","999999999","dramost",6],
    ["Corrales Aguilar","Eduardo Martin","41151665","ecorrales@agrobanco.com.pe","999999999","ecorrales",4],
    ["Ramos Diaz","Edgar Fredy","80025984","eramosd@agrobanco.com.pe","999999999","eramosd",1],
    ["Velasco Ramos","Eduardo","42325058","evelasco@agrobanco.com.pe","999999999","evelasco",2],
    ["Velasco Ramos","Eduardo","42325058","evelasco@agrobanco.com.pe","999999999","evelasco2",1],
    ["Yunca Rojas","Eddy","44041744","eyunca@agrobanco.com.pe","999999999","eyunca",2],
    ["Bermúdez García","Hugo Edgardo","32990068","hbermudez@agrobanco.com.pe","999999999","hbermudez",3],
    ["Ricos Tang","Ivan Efrain","5644674","iricos@agrobanco.com.pe","999999999","iricos",4],
    ["Cabanillas Medina","José Manuel","41313921","jcabanillas@agrobanco.com.pe","999999999","jcabanillas",3],
    ["Vargas Medina","Jans Peter","41712703","jpvargas@agrobanco.com.pe","999999999","jpvargas",6],
    ["Honorio Jara","Loder","12345678","lhonorio@agrobanco.com.pe","999999999","lhonorio",3],
    ["Montalvo Moreno","Luis Martin","16736367","lmontlavo@agrobanco.com.pe","999999999","lmontlavo",3],
    ["Sulluchuco Flores","Luis Gustavo","48011835","lsulluchuco@agrobanco.com.pe","999999999","lsulluchuco",5],
    ["Poma Cotrado","Marilu","40476564","mpoma@agrobanco.com.pe","999999999","mpoma",1],
    ["Calla Yanqui","Nelson","46110443","ncalla@agrobanco.com.pe","999999999","ncalla",2],
    ["De la Cruz Laureano","Nilo","44276566","ndelacruz@agrobanco.com.pe","999999999","ndelacruz",6],
    ["Vasquez Mercado","Pamela Falibeth","43634562","pvasquez@agrobanco.com.pe","999999999","pvasquez",5],
    ["Vasquez Mercado","Pamela Falibeth","43634562","pvasquez@agrobanco.com.pe","999999999","pvasquez2",6],
    ["Atoche Concha","Enzzo","45351526","ratoche@agrobanco.com.pe","999999999","ratoche",3],
    ["Leon Samanamud","Ricardo","15737279","rleon@agrobanco.com.pe","999999999","rleon",6],
];

foreach ($usuarios as $u) {

    $hash = password_hash($u[2], PASSWORD_BCRYPT);

    echo "INSERT INTO usuarios 
    (apellidos, nombres, dni, correo, telefono, usuario, password, estado, fecha_registro, rol, id_zona)
    VALUES (
        '{$u[0]}',
        '{$u[1]}',
        '{$u[2]}',
        '{$u[3]}',
        '{$u[4]}',
        '{$u[5]}',
        '{$hash}',
        1,
        NOW(),
        'usuario',
        {$u[6]}
    );\n\n";
}


INSERT INTO agencia (nombre_agencia, clasificacion_agencia, id_zona) VALUES
('Ayacucho', NULL, 5),
('Cajamarca', NULL, 3),
('Chachapoyas', NULL, 4),
('Chiclayo', NULL, 3),
('Chimbote', NULL, 3),
('Chincha', NULL, 1),
('Cusco', NULL, 2),
('Huacho', NULL, 6),
('Huancayo', NULL, 5),
('Huánuco', NULL, 6),
('Huaraz', NULL, 3),
('Ica', NULL, 1),
('Iquitos', NULL, 6),
('Jaen', NULL, 4),
('Juanjui', NULL, 4),
('La Merced', NULL, 6),
('Padre Abad', NULL, 6),
('Pampas', NULL, 6),
('Pucallpa', NULL, 6),
('San Francisco', NULL, 5),
('Satipo', NULL, 6),
('Sullana', NULL, 3),
('Tarapoto', NULL, 4),
('Tingo María', NULL, 6),
('Trujillo', NULL, 3),
('Tumbes', NULL, 3);


