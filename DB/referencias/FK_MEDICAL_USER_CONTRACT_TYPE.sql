/*******************************************************************************
Description: Creation Script for relationship between MEDICAL_USER and CONTRACT_TYPE
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.MEDICAL_USER
ADD CONSTRAINT FK_MEDICAL_USER_CONTRACT_TYPE
FOREIGN KEY (contract_type_id) 
REFERENCES MED_USER_DBA.CONTRACT_TYPE (contract_type_id);