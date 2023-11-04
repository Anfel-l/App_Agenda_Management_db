/*******************************************************************************
Description: Creation Script for relationship between MEDICAL_CENTER and LOCATION
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.MEDICAL_CENTER
ADD CONSTRAINT FK_MEDICAL_CENTER_LOCATION
FOREIGN KEY (location_id) 
REFERENCES MED_USER_DBA.LOCATION (location_id);