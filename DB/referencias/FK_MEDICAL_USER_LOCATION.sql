/*******************************************************************************
Description: Creation Script for relationship between MEDICAL_USER and LOCATION
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.MEDICAL_USER
ADD CONSTRAINT FK_MEDICAL_USER_LOCATION
FOREIGN KEY (location_id) 
REFERENCES MED_USER_DBA.LOCATION (location_id);