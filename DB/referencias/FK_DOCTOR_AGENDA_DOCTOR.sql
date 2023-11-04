/*******************************************************************************
Description: Creation Script for relationship between DOCTOR_AGENDA and DOCTOR
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.DOCTOR_AGENDA 
ADD CONSTRAINT FK_DOCTOR_AGENDA_DOCTOR 
FOREIGN KEY (doctor_id) 
REFERENCES MED_USER_DBA.DOCTOR (doctor_id);
