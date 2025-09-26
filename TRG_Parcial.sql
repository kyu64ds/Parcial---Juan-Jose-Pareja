-- ========================================
--              Triggers
-- Por: Juan José Pareja Ortíz / V-6:AM
-- ========================================

USE Parcial;
GO

CREATE TRIGGER tActualizarCapitalRegion
ON Ciudad
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS(SELECT * FROM Inserted WHERE CapitalRegion = 1)
    BEGIN
        IF EXISTS(
            SELECT 1
            FROM Inserted I
            JOIN Ciudad C ON I.IdRegion = C.IdRegion
            WHERE I.CapitalRegion = 1 AND C.CapitalRegion = 1 AND C.Id <> I.Id
            GROUP BY I.IdRegion
            HAVING COUNT(*) > 1
        )
        BEGIN
            RAISERROR('No se acepta más de una capital por región', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        UPDATE Ciudad
        SET CapitalRegion = 0
        FROM Ciudad C
        JOIN Inserted I ON C.IdRegion = I.IdRegion AND C.Id <> I.Id;
    END
END;
GO

CREATE TRIGGER tActualizarCapitalPais
ON Ciudad
FOR INSERT, UPDATE
AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    WITH UltimaCapital AS (
        SELECT C.Id, R.IdPais
        FROM Inserted I
        JOIN Ciudad C ON C.Id = I.Id
        JOIN Region R ON C.IdRegion = R.Id
        WHERE I.CapitalPais = 1
    )
    UPDATE C
    SET CapitalPais = CASE WHEN C.Id = U.Id THEN 1 ELSE 0 END
    FROM Ciudad C
    JOIN Region R ON C.IdRegion = R.Id
    JOIN UltimaCapital U ON U.IdPais = R.IdPais;
END;
GO

CREATE TRIGGER tActualizarGrupoPais
ON GrupoPais
FOR INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(
        SELECT 1
        FROM Inserted I
        JOIN Grupo GNuevo ON GNuevo.Id = I.IdGrupo
        JOIN GrupoPais GP ON GP.IdPais = I.IdPais
        JOIN Grupo GExistente ON GExistente.Id = GP.IdGrupo
        WHERE GNuevo.IdCampeonato = GExistente.IdCampeonato
          AND GNuevo.Id <> GExistente.Id
    )
    BEGIN
        RAISERROR('Un país no puede pertenecer a más de un grupo en el mismo campeonato.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO

CREATE TRIGGER tValidarEncuentroUnico
ON Encuentro
FOR INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(
        SELECT 1
        FROM Inserted I
        JOIN Encuentro E
          ON E.IdCampeonato = I.IdCampeonato
         AND E.IdFase = I.IdFase
         AND ((E.IdPais1 = I.IdPais1 AND E.IdPais2 = I.IdPais2) OR
              (E.IdPais1 = I.IdPais2 AND E.IdPais2 = I.IdPais1))
         AND E.Id <> I.Id
    )
    BEGIN
        RAISERROR('El mismo partido no puede repetirse en la misma fase y campeonato.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO
