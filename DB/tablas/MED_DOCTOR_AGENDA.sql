/*******************************************************************************
Description: Creation Script of the table DOCTOR_AGENDA
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE TABLE MED_USER_DBA.DOCTOR_AGENDA(
    doctor_agenda_id NUMBER(10) NOT NULL,
    doctor_id NUMBER(10) NOT NULL,
    detail_id NUMBER(10) NOT NULL

)TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.DOCTOR_AGENDA IS 'Table that stores all the agenda of the doctors';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.DOCTOR_AGENDA.doctor_agenda_id IS 'Primary key of the table';
COMMENT ON COLUMN MED_USER_DBA.DOCTOR_AGENDA.doctor_id IS 'Foreign key of the doctor';
COMMENT ON COLUMN MED_USER_DBA.DOCTOR_AGENDA.detail_id IS 'Foreign key of the detail';