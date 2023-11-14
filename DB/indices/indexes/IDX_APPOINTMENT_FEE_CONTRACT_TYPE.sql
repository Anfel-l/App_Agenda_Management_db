/*******************************************************************************
Description: Creation script for the index idx_appointment_fee_contract_type_id on the table MED_USER_DBA.APPOINTMENT_FEE
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE INDEX idx_appointment_fee_contract_type_id ON MED_USER_DBA.APPOINTMENT_FEE(contract_type_id);
