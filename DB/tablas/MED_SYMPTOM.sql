/*******************************************************************************
Description: Creation script for the table SYMPTOM
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE MED_USER_DBA.SYMPTOM(
    symptom_id NUMBER(10) NOT NULL,
    symptom_name VARCHAR2(100) NOT NULL,
    symptom_priority NUMBER(1) NOT NULL,
) TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.SYMPTOM IS 'Table that stores the symptoms of the patients';
/** COLUMNS*/
COMMENT ON COLUMN MED_USER_DBA.SYMPTOM.symptom_id IS 'Primary key of the table';
COMMENT ON COLUMN MED_USER_DBA.SYMPTOM.symptom_name IS 'Name of the symptom';
COMMENT ON COLUMN MED_USER_DBA.SYMPTOM.symptom_priority IS 'Priority of the symptom';

