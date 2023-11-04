/*******************************************************************************
Description: Creation Script for relationship between MEDICAL_APPOINTMENT_DETAIL and MEDICAL_APPOINTMENT
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL
ADD CONSTRAINT FK_MEDICAL_APPOINTMENT_DETAIL_MEDICAL_APPOINTMENT
FOREIGN KEY (medical_appointment_id) 
REFERENCES MED_USER_DBA.MEDICAL_APPOINTMENT (medical_appointment_id);