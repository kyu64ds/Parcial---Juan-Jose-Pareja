-- ========================================
--              DML
-- Por: Juan José Pareja Ortíz / V-6:AM
-- ========================================

USE Parcial;
GO

INSERT INTO Continente (Nombre) VALUES ('América'), ('Europa');
INSERT INTO TipoRegion (Tipo) VALUES ('Departamento'), ('Estado'), ('Provincia');

INSERT INTO Pais (Nombre, IdContinente, IdTipoRegion, Moneda)
VALUES ('Colombia', 1, 1, 'Peso Colombiano'),
       ('España', 2, 2, 'Euro');

INSERT INTO Region (Nombre, Area, Poblacion, IdPais)
VALUES ('Antioquia', 63500, 6000000, 1),
       ('Cundinamarca', 24000, 3000000, 1),
       ('Andalucía', 87599, 8400000, 2);

INSERT INTO Ciudad (Nombre, IdRegion, CapitalRegion, CapitalPais, Area, Poblacion)
VALUES ('Medellín', 1, 1, 0, 382, 2500000),
       ('Bogotá', 2, 1, 1, 1775, 8000000),
       ('Sevilla', 3, 1, 0, 140, 690000),
       ('Madrid', 3, 0, 1, 604, 3300000);



INSERT INTO PaisFutbol (Pais, Entidad, Bandera, LogoEntidad)
VALUES ('Colombia', 'FCF', '🇨🇴', 'logo_col.png'),
       ('Brasil', 'CBF', '🇧🇷', 'logo_bra.png'),
       ('Alemania', 'DFB', '🇩🇪', 'logo_ger.png'),
       ('España', 'RFEF', '🇪🇸', 'logo_esp.png');

INSERT INTO Campeonato (Nombre, IdPais, Anio)
VALUES ('Copa América', 1, 2024),
       ('Eurocopa', 4, 2024);

INSERT INTO Grupo (Nombre, IdCampeonato)
VALUES ('Grupo A', 1),
       ('Grupo B', 1),
       ('Grupo C', 2);

INSERT INTO GrupoPais (IdGrupo, IdPais)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (3, 4);

INSERT INTO Fase (Fase) VALUES ('Grupos'), ('Semifinal'), ('Final');

INSERT INTO CiudadFutbol (Nombre, IdPais)
VALUES ('Barranquilla', 1),
       ('Rio de Janeiro', 2),
       ('Berlín', 3),
       ('Madrid', 4);

INSERT INTO Estadio (Nombre, Capacidad, IdCiudad)
VALUES ('Metropolitano', 46000, 1),
       ('Maracaná', 78000, 2),
       ('Olympiastadion', 74000, 3),
       ('Santiago Bernabéu', 81000, 4);

INSERT INTO Encuentro (IdPais1, IdPais2, IdFase, IdEstadio, IdCampeonato, Fecha, Goles1, Goles2)
VALUES (1, 2, 1, 1, 1, '2024-06-10', 2, 1),
       (3, 4, 1, 3, 2, '2024-06-15', 1, 1);
