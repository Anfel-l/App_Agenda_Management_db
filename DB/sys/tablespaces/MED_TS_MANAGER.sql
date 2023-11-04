/*******************************************************************************
Description: Creation script for the tablespace MED_TS_MANAGER
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE TABLESPACE "MED_TS_MANAGER"
DATAFILE '/Datafile/MED_TS_MANAGER.dbf' 
SIZE 100M AUTOEXTEND ON
NEXT 100M MAXSIZE UNLIMITED;
