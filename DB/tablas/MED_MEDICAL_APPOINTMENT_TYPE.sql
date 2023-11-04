/*******************************************************************************
Description: Creation script for the table MEDICAL_APPOINTMENT_TYPE
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE MED_USER_DBA.MEDICAL_APPOINTMENT_TYPE(
    medical_appointment_type_id NUMBER(10) NOT NULL,
    medical_appointment_type_name VARCHAR2(100) NOT NULL,
    description VARCHAR2(100) NOT NULL
) TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.MEDICAL_APPOINTMENT_TYPE IS 
'Table that stores the types of medical appointments being:
    1.  Urgency
    2.  Control
    3.  Medical Exam';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_TYPE.medical_appointment_type_id IS 'Unique identifier for the type of medical appointment';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_TYPE.medical_appointment_type_name IS 'Name of the type of medical appointment';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_TYPE.description IS 'Description of the type of medical appointment';

