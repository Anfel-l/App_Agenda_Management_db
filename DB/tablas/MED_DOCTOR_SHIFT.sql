/*******************************************************************************
Description: Creation script for table DOCTOR_SHIFT
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE MED_USER_DBA.DOCTOR_SHIFT(
    doctor_shift_id NUMBER(10) NOT NULL,
    doctor_id NUMBER(10) NOT NULL,
    shift_date DATE NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL

)TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.DOCTOR_SHIFT IS 'Table that stores doctor shifts information';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.DOCTOR_SHIFT.DOCTOR_SHIFT_ID IS 'Doctor shift identifier';
COMMENT ON COLUMN MED_USER_DBA.DOCTOR_SHIFT.DOCTOR_ID IS 'Doctor identifier';
COMMENT ON COLUMN MED_USER_DBA.DOCTOR_SHIFT.START_TIME IS 'Doctor shift start time';
COMMENT ON COLUMN MED_USER_DBA.DOCTOR_SHIFT.END_TIME IS 'Doctor shift end time';