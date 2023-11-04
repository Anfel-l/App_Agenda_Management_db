/*******************************************************************************
Description: Creation script for user MED_USER_FINAL_2
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER MED_USER_FINAL_2 IDENTIFIED BY CONTRASENA_2
DEFAULT TABLESPACE TS_MED
TEMPORARY TABLESPACE temp;

GRANT ROLE_USER_CONNECTION TO MED_USER_FINAL_2;