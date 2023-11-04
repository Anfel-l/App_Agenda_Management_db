/*******************************************************************************
Description: Creation script for the table MEDICAL_APPOINTMENT
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE TABLE MED_USER_DBA.MEDICAL_APPOINTMENT(
    medical_appointment_id NUMBER(10) NOT NULL,
    medical_appointment_type_id NUMBER(10) NOT NULL,
    symptom_id NUMBER(10) NOT NULL,
    medical_priority DECIMAL(10) NOT NULL,
    medical_field_id NUMBER(10) NOT NULL
)TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.MEDICAL_APPOINTMENT IS 'Table that stores medical appointments';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT.medical_appointment_id IS 'Primary key of the table';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT.medical_appointment_type_id IS 'Foreign key of the table';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT.symptom IS 'Symptom of the patient';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT.medical_priority IS 'Priority of the medical appointment';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT.medical_field_id IS 'Medical field of the appointment'

