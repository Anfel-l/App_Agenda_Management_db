/*******************************************************************************
Description: Creation Script for relationship between MEDICAL_CENTER_DOCTOR and DOCTOR
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.MEDICAL_CENTER_DOCTOR
ADD CONSTRAINT FK_MEDICAL_CENTER_DOCTOR_DOCTOR
FOREIGN KEY (doctor_id) 
REFERENCES MED_USER_DBA.DOCTOR (doctor_id);