/*******************************************************************************
Description: Creation Script for relationship between MEDICAL_USER and DOCUMENT_TYPE
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE MED_USER_DBA.MEDICAL_USER
ADD CONSTRAINT FK_MEDICAL_USER_DOCUMENT_TYPE
FOREIGN KEY (document_type_id) 
REFERENCES MED_USER_DBA.DOCUMENT_TYPE (document_type_id);