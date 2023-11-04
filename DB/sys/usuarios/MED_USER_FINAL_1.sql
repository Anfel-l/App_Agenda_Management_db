/*******************************************************************************
Description: Creation script for user MED_USER_FINAL_1
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER MED_USER_FINAL_1 IDENTIFIED BY CONTRASENA_1
DEFAULT TABLESPACE TS_MED
TEMPORARY TABLESPACE temp;

GRANT ROLE_PROCESS_DATA TO MED_USER_FINAL_1;


