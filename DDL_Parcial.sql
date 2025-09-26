-- ========================================
--              DDL
-- Por: Juan José Pareja Ortíz / V-6:AM
-- ========================================

CREATE DATABASE Parcial;
GO

USE Parcial;
GO


CREATE TABLE Continente(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE TipoRegion(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Tipo NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Pais(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL UNIQUE,
    IdContinente INT NOT NULL,
    IdTipoRegion INT NOT NULL,
    Moneda NVARCHAR(50) NOT NULL,
    CONSTRAINT fk_Pais_Continente FOREIGN KEY (IdContinente) REFERENCES Continente(Id),
    CONSTRAINT fk_Pais_TipoRegion FOREIGN KEY (IdTipoRegion) REFERENCES TipoRegion(Id)
);

CREATE TABLE Region(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Area DECIMAL(18,2) NULL,
    Poblacion INT NULL,
    IdPais INT NOT NULL,
    CONSTRAINT fk_Region_Pais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
);

CREATE TABLE Ciudad(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    IdRegion INT NOT NULL,
    CapitalRegion BIT DEFAULT 0,
    CapitalPais BIT DEFAULT 0,
    AreaMetropolitana NVARCHAR(100) NULL,
    Area DECIMAL(18,2) NULL,
    Poblacion INT NULL,
    CONSTRAINT fk_Ciudad_Region FOREIGN KEY (IdRegion) REFERENCES Region(Id)
);


CREATE TABLE PaisFutbol(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Pais NVARCHAR(100) NOT NULL UNIQUE,
    Entidad NVARCHAR(100) NULL,
    Bandera NVARCHAR(100) NULL,
    LogoEntidad NVARCHAR(100) NULL
);

CREATE TABLE Campeonato(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    IdPais INT NOT NULL,
    Anio INT NOT NULL,
    CONSTRAINT fk_Campeonato_Pais FOREIGN KEY (IdPais) REFERENCES PaisFutbol(Id)
);

CREATE TABLE Grupo(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    IdCampeonato INT NOT NULL,
    CONSTRAINT fk_Grupo_Campeonato FOREIGN KEY (IdCampeonato) REFERENCES Campeonato(Id)
);

CREATE TABLE GrupoPais(
    IdGrupo INT NOT NULL,
    IdPais INT NOT NULL,
    PRIMARY KEY(IdGrupo, IdPais),
    CONSTRAINT fk_GrupoPais_Grupo FOREIGN KEY (IdGrupo) REFERENCES Grupo(Id),
    CONSTRAINT fk_GrupoPais_Pais FOREIGN KEY (IdPais) REFERENCES PaisFutbol(Id)
);

CREATE TABLE Fase(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Fase NVARCHAR(50) NOT NULL
);

CREATE TABLE CiudadFutbol(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    IdPais INT NOT NULL,
    CONSTRAINT fk_Ciudad_PaisFutbol FOREIGN KEY (IdPais) REFERENCES PaisFutbol(Id)
);

CREATE TABLE Estadio(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Capacidad INT NULL,
    IdCiudad INT NOT NULL,
    CONSTRAINT fk_Estadio_Ciudad FOREIGN KEY (IdCiudad) REFERENCES CiudadFutbol(Id)
);

CREATE TABLE Encuentro(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdPais1 INT NOT NULL,
    IdPais2 INT NOT NULL,
    IdFase INT NOT NULL,
    IdEstadio INT NOT NULL,
    IdCampeonato INT NOT NULL,
    Fecha DATE NOT NULL,
    Goles1 INT DEFAULT 0,
    Goles2 INT DEFAULT 0,
    CONSTRAINT fk_Encuentro_Pais1 FOREIGN KEY (IdPais1) REFERENCES PaisFutbol(Id),
    CONSTRAINT fk_Encuentro_Pais2 FOREIGN KEY (IdPais2) REFERENCES PaisFutbol(Id),
    CONSTRAINT fk_Encuentro_Fase FOREIGN KEY (IdFase) REFERENCES Fase(Id),
    CONSTRAINT fk_Encuentro_Estadio FOREIGN KEY (IdEstadio) REFERENCES Estadio(Id),
    CONSTRAINT fk_Encuentro_Campeonato FOREIGN KEY (IdCampeonato) REFERENCES Campeonato(Id)
);
