/*******************************************************************************
Description: Creation Script for the APPOINTMENT_FEE table
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE TABLE MED_USER_DBA.APPOINTMENT_FEE(
    appointment_fee_id NUMBER(10) NOT NULL,
    contract_type_id NUMBER(10) NOT NULL,
    fee_value NUMBER(10) NOT NULL

)TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.APPOINTMENT_FEE IS 'Table that stores the values of the fees for each type of medical appointment and contract type';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.APPOINTMENT_FEE.APPOINTMENT_FEE_ID IS 'Primary key of the table';
COMMENT ON COLUMN MED_USER_DBA.APPOINTMENT_FEE.CONTRACT_TYPE_ID IS 'Foreign key of the contract type table';
COMMENT ON COLUMN MED_USER_DBA.APPOINTMENT_FEE.FEE_VALUE IS 'Value of the fee for the medical appointment type and contract type';
