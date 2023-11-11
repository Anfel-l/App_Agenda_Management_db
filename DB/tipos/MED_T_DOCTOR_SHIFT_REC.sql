CREATE OR REPLACE TYPE T_DOCTOR_SHIFT_REC AS OBJECT (
    doctor_id NUMBER,
    shift_date DATE,
    start_time TIMESTAMP,
    end_time TIMESTAMP
);