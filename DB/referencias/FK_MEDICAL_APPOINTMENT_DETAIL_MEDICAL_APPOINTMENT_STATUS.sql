/*******************************************************************************
Description: Creation Script for relationship between MEDICAL_APPOINTMENT_DETAIL and MEDICAL_APPOINTMENT_STATUS
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL
ADD CONSTRAINT FK_MEDICAL_APPOINTMENT_DETAIL_MEDICAL_APPOINTMENT_STATUS
FOREIGN KEY (medical_appointment_status_id) 
REFERENCES MED_USER_DBA.MEDICAL_APPOINTMENT_STATUS (medical_appointment_status_id);