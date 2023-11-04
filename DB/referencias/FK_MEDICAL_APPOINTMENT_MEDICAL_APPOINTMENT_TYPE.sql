/*******************************************************************************
Description: Creation Script for relationship between MEDICAL_APPOINTMENT and MEDICAL_APPOINTMENT_TYPE
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.MEDICAL_APPOINTMENT
ADD CONSTRAINT FK_MEDICAL_APPOINTMENT_DETAIL_MEDICAL_APPOINTMENT_TYPE
FOREIGN KEY (medical_appointment_type_id) 
REFERENCES MED_USER_DBA.MEDICAL_APPOINTMENT_TYPE (medical_appointment_type_id);