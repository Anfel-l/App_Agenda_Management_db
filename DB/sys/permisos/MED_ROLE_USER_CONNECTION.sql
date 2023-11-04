/*******************************************************************************
Description: Creation script for the role ROLE_USER_CONNECTION
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE ROLE ROLE_USER_CONNECTION;

GRANT CREATE SESSION TO ROLE_USER_CONNECTTION;
GRANT EXECUTE ANY PROCEDURE TO ROLE_USER_CONNECTION;