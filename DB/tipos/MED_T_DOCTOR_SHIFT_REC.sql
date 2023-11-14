/*******************************************************************************
Description: Creation script for the type T_DOCTOR_SHIFT_REC
which is used to store the information of a doctor shift

Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE OR REPLACE TYPE T_DOCTOR_SHIFT_REC AS OBJECT (
    doctor_id NUMBER,
    shift_date DATE,
    start_time TIMESTAMP,
    end_time TIMESTAMP
);