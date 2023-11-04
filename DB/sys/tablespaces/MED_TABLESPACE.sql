/*******************************************************************************
Description: Creation script for the tablespace MED_TS_MANAGER
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE TABLESPACE "TS_MED"
DATAFILE '/Datafile/TS_MED.dbf' 
SIZE 100M AUTOEXTEND ON
NEXT 100M MAXSIZE UNLIMITED;



