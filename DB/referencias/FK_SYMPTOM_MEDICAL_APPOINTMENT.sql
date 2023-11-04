/*******************************************************************************
Description: Creation Script for relationship between MEDICAL_APPOINTMENT and SYMPTOM
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.MEDICAL_APPOINTMENT 
ADD CONSTRAINT FK_SYMPTOM_MEDICAL_APPOINTMENT 
FOREIGN KEY (symptom_id) 
REFERENCES MED_USER_DBA.SYMPTOM (symptom_id);