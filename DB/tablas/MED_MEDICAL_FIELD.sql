/*******************************************************************************
Description: Creation script for the table MEDICAL_FIELD
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE TABLE MED_USER_DBA.MEDICAL_FIELD(
    medical_field_id NUMBER(10) NOT NULL,
    medical_field_name VARCHAR2(100) NOT NULL,
    description VARCHAR2(100) NOT NULL
    
)TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.MEDICAL_FIELD IS 'Table that stores information from medical specialties';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_FIELD.medical_field_id IS 'Identifier of the medical specialty';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_FIELD.medical_field_name IS 'Name of the medical specialty';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_FIELD.description IS 'Description of the medical specialty';