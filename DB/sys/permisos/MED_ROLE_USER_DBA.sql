/*******************************************************************************
Description: Creation script for the role ROLE_USER_DBA
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE ROLE ROLE_USER_DBA;
-- PERMISSIONS
GRANT CREATE TRIGGER, CREATE TABLE, CREATE INDEX, CREATE PROCEDURE, CREATE USER TO ROLE_USER_DBA;
GRANT ALTER SESSION TO ROLE_USER_DBA;