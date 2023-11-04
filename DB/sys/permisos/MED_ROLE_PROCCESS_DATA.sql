/*******************************************************************************
Description: Creation script for the role ROLE_USER_CONNECTION
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE ROLE ROLE_PROCESS_DATA;
GRANT SELECT, INSERT, DELETE, UPDATE ON TABLE TO ROLE_PROCESS_DATA;

