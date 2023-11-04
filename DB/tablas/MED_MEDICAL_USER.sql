/*******************************************************************************
Description: Creation script for the table MEDICAL_USER
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE MED_USER_DBA.MEDICAL_USER(
    user_id NUMBER(10),
    first_name VARCHAR2(20) NOT NULL,
    second_name VARCHAR2(20) NOT NULL,
    last_name VARCHAR2(20) NOT NULL,
    document_type_id NUMBER(10) NOT NULL,
    document VARCHAR2(20) NOT NULL,
    password VARCHAR2(20) NOT NULL,
    contract_type_id NUMBER(10) NOT NULL,
    location_id NUMBER(10) NOT NULL,
    email VARCHAR2(20) NOT NULL,
) TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.MEDICAL_USER IS 'User information table';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_USER.user_id IS 'User identifier';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_USER.first_name IS 'User first name';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_USER.second_name IS 'User second name';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_USER.last_name IS 'User last name';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_USER.document_type_id IS 'User document type identifier';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_USER.document IS 'User document';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_USER.password IS 'User password';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_USER.contract_type_id IS 'User contract type identifier';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_USER.location_id IS 'User location identifier';
COMMENT ON COLUMN MED_USER_DBA.MEDICAL_USER.email IS 'User email';
