/*******************************************************************************
Description: Creation script for the table MEDICAL_APPOINTMENT_STATUS
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE TABLE MED_USER_DBA.MEDICAL_APPOINTMENT_STATUS(
    medical_appointment_status_id NUMBER(10) NOT NULL,
    status VARCHAR2(10) NOT NULL
)TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.MEDICAL_APPOINTMENT_STATUS IS 'Table that stores the status of the medical appointment';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_STATUS.medical_appointment_status_id IS 'Primary key of the table';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_STATUS.status IS 'Status of the medical appointment';
