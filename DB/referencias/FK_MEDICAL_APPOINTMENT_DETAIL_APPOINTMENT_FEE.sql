/*******************************************************************************
Description: Creation Script for relationship between MEDICAL_APPOINTMENT_DETAIl and APPOINTMENT_FEE
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL
ADD CONSTRAINT FK_MEDICAL_APPOINTMENT_DETAIL_APPOINTMENT_FEE
FOREIGN KEY (appointment_fee_id) 
REFERENCES MED_USER_DBA.APPOINTMENT_FEE (appointment_fee_id);