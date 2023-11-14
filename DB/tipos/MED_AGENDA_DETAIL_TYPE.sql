/*******************************************************************************
Description: Creation script for the type AGENDA_DETAIL_TYPE
which is used to return the information of the medical appointments
that are in the agenda of the doctor.

Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE OR REPLACE TYPE AGENDA_DETAIL_TYPE AS OBJECT (
    detail_id NUMBER,
    user_name VARCHAR2(100),
    doctor_name VARCHAR2(100),
    medical_appointment_id NUMBER,
    fee_value NUMBER,
    status VARCHAR2(100),
    appointment_time TIMESTAMP,
    symptom_name VARCHAR2(100)
);
