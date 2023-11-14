/*******************************************************************************
Description: Creation script for the table CONTRACT_TYPE
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE MED_USER_DBA.CONTRACT_TYPE(
    contract_type_id NUMBER(10) NOT NULL,
    contract_type_name VARCHAR2(100) NOT NULL,
    description VARCHAR2(100) NOT NULL,
    contract_type_priority NUMBER(1) NOT NULL,
) TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.CONTRACT_TYPE IS 'Table that stores the contract types';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.CONTRACT_TYPE.contract_type_id IS 'Contract type identifier';
COMMENT ON COLUMN MED_USER_DBA.CONTRACT_TYPE.contract_type_name IS 'Contract type name';
COMMENT ON COLUMN MED_USER_DBA.CONTRACT_TYPE.description IS 'Contract type description';
COMMENT ON COLUMN MED_USER_DBA.CONTRACT_TYPE.contract_type_priority IS 'Contract type priority';
