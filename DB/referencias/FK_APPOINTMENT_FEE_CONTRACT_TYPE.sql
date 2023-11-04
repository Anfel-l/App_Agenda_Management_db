/*******************************************************************************
Description: Creation Script for relationship between APPOINTMENT_FEE and CONTRACT_TYPE tables
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.APPOINTMENT_FEE 
ADD CONSTRAINT FK_APPOINTMENT_FEE_CONTRACT_TYPE 
FOREIGN KEY (contract_type_id) 
REFERENCES MED_USER_DBA.CONTRACT_TYPE (contract_type_id);
