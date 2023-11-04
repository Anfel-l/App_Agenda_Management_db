/*******************************************************************************
Description: Creation script for the table MEDICAL_CENTER
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE TABLE MED_USER_DBA.MEDICAL_CENTER(
    medical_center_id NUMBER(10) NOT NULL,
    medical_center_name VARCHAR2(100) NOT NULL,
    location_id NUMBER(10) NOT NULL
)TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.MEDICAL_CENTER IS 'Medical center table';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_CENTER.medical_center_id IS 'Medical center id';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_CENTER.medical_center_name IS 'Medical center name';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_CENTER.location_id IS 'Medical center location id';