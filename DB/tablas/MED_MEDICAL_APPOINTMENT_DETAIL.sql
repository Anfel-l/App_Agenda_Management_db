/*******************************************************************************
Description: Creation script for the table MEDICAL_APPOINTMENT_DETAIL
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL(
    detail_id NUMBER(10) NOT NULL,
    user_id NUMBER(10) NOT NULL,
    doctor_id NUMBER(10) NOT NULL,
    medical_appointment_id NUMBER(10) NOT NULL,
    appointment_fee_id NUMBER(10) NOT NULL,
    medical_appointment_status_id NUMBER(10) NOT NULL,
    appointment_time TIMESTAMP NOT NULL

)TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL IS 'Table that stores the detail of the medical appointment';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL.detail_id IS 'Unique identifier of the medical appointment detail';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL.user_id IS 'Unique identifier of the user';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL.doctor_id IS 'Unique identifier of the medical center doctor';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL.medical_appointment_id IS 'Unique identifier of the medical appointment';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL.appointment_fee_id IS 'Unique identifier of the appointment fee';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL.medical_appointment_status_id IS 'Unique identifier of the medical appointment status';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL.appointment_time IS 'Date and time of the appointment';


ALTER TABLE MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL
ADD CONSTRAINT FK_DOCTOR_MEDICAL_APPOINTMENT_DETAIL
FOREIGN KEY (doctor_id)
REFERENCES MED_USER_DBA.DOCTOR (doctor_id);