/*******************************************************************************
Description: Creation script for the table DOCTOR
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE TABLE MED_USER_DBA.DOCTOR(
    doctor_id NUMBER(10) NOT NULL,
    first_name VARCHAR2(50) NOT NULL,
    second_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    medical_field_id NUMBER(10) NOT NULL,
    medical_center_id NUMBER(10) NOT NULL
)TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.DOCTOR IS 'Table that stores information from the doctor';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.DOCTOR.DOCTOR_ID IS 'Doctor identifier';
COMMENT ON COLUMN MED_USER_DBA.DOCTOR.FIRST_NAME IS 'Doctor first name';
COMMENT ON COLUMN MED_USER_DBA.DOCTOR.SECOND_NAME IS 'Doctor second name';
COMMENT ON COLUMN MED_USER_DBA.DOCTOR.LAST_NAME IS 'Doctor last name';
COMMENT ON COLUMN MED_USER_DBA.DOCTOR.MEDICAL_FIELD_ID IS 'Medical field identifier';
COMMENT ON COLUMN MED_USER_DBA.DOCTOR.MEDICAL_CENTER_ID IS 'Medical center identifier',

