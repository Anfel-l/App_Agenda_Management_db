/*******************************************************************************
Description: Creation Script for relationship between DOCTOR and MEDICAL_FIELD
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.DOCTOR 
ADD CONSTRAINT FK_DOCTOR_MEDICAL_FIELD
FOREIGN KEY (medical_field_id) 
REFERENCES MED_USER_DBA.MEDICAL_FIELD (medical_field_id);