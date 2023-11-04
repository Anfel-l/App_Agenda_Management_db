/*******************************************************************************
Description: Creation Script for relationship between DOCTOR_AGENDA and MEDICAL_APPOINTMENT_DETAIL
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.DOCTOR_AGENDA 
ADD CONSTRAINT FK_DOCTOR_AGENDA_MEDICAL_APPOINTMENT_DETAIL 
FOREIGN KEY (detail_id) 
REFERENCES MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL (detail_id);
