/*******************************************************************************
Description: Creation Script for relationship between MEDICAL_CENTER_DOCTOR and MEDICAL_CENTER
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.MEDICAL_CENTER_DOCTOR
ADD CONSTRAINT FK_MEDICAL_CENTER_DOCTOR_MEDICAL_CENTER
FOREIGN KEY (medical_center_id) 
REFERENCES MED_USER_DBA.MEDICAL_CENTER (medical_center_id);