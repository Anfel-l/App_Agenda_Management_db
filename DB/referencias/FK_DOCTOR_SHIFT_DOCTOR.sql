/*******************************************************************************
Description: Creation Script for relationship between DOCTOR_SHIFT and DOCTOR
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.DOCTOR_SHIFT
ADD CONSTRAINT FK_DOCTOR_SHIFT_DOCTOR
FOREIGN KEY (doctor_id) 
REFERENCES MED_USER_DBA.DOCTOR (doctor_id);
