/*******************************************************************************
Description: Creation script for user MED_USER_DBA
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER MED_USER_DBA
IDENTIFIED BY CONTRASENA1
DEFAULT TABLESPACE MED_TS_MANAGER
TEMPORARY TABLESPACE temp;

GRANT DBA TO MED_USER_DBA;