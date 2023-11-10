CREATE OR REPLACE TYPE AGENDA_DETAIL_TYPE AS OBJECT (
    detail_id NUMBER,
    user_name VARCHAR2(100),
    doctor_name VARCHAR2(100),
    medical_appointment_id NUMBER,
    fee_value NUMBER,
    status VARCHAR2(100),
    appointment_time TIMESTAMP
);
