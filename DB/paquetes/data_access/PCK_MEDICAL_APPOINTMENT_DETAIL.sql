CREATE OR REPLACE PACKAGE PCK_MEDICAL_APPOINTMENT_DETAIL IS
    
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_DETAIL(
        Ip_user_id IN NUMBER,
        Ip_doctor_id IN NUMBER,
        Ip_medical_appointment_id IN NUMBER,
        Ip_appointment_fee_id IN NUMBER,
        Ip_medical_appointment_status_id IN NUMBER,
        Ip_appointment_time IN TIMESTAMP,
        Op_detail_id OUT NUMBER
    );

    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_DETAIL(
        Ip_detail_id IN NUMBER,
        Ip_user_id IN NUMBER,
        Ip_doctor_id IN NUMBER,
        Ip_medical_appointment_id IN NUMBER,
        Ip_appointment_fee_id IN NUMBER,
        Ip_medical_appointment_status_id IN NUMBER,
        Ip_appointment_time IN TIMESTAMP
    );

    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_DETAIL(
        Op_medical_appointment_detail OUT SYS_REFCURSOR
    );

    PROCEDURE PRoc_Get_MEDICAL_APPOINTMENT_DETAIL_BY_ID(
        Ip_detail_id IN NUMBER,
        Op_medical_appointment_detail OUT SYS_REFCURSOR
    );

END PCK_MEDICAL_APPOINTMENT_DETAIL;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_APPOINTMENT_DETAIL AS
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_DETAIL(
        Ip_user_id IN NUMBER,
        Ip_doctor_id IN NUMBER,
        Ip_medical_appointment_id IN NUMBER,
        Ip_appointment_fee_id IN NUMBER,
        Ip_medical_appointment_status_id IN NUMBER,
        Ip_appointment_time IN TIMESTAMP,
        Op_detail_id OUT NUMBER
    )IS
    v_medical_appointment_detail_id NUMBER;
    BEGIN
    v_medical_appointment_detail_id := SEQ_MEDICAL_APPOINTMENT_DETAIL.NEXTVAL;
        INSERT INTO MEDICAL_APPOINTMENT_DETAIL(
            detail_id,
            user_id,
            doctor_id,
            medical_appointment_id,
            appointment_fee_id,
            medical_appointment_status_id,
            appointment_time
        )VALUES(
            v_medical_appointment_detail_id,
            Ip_user_id,
            Ip_doctor_id,
            Ip_medical_appointment_id,
            Ip_appointment_fee_id,
            Ip_medical_appointment_status_id,
            Ip_appointment_time
        );
    Op_detail_id := v_medical_appointment_detail_id;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Detail already exists');    
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered -'||SQLCODE||' - Error - ' ||SQLERRM);
    END Proc_Insert_MEDICAL_APPOINTMENT_DETAIL;

    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_DETAIL(
        Ip_detail_id IN NUMBER,
        Ip_user_id IN NUMBER,
        Ip_doctor_id IN NUMBER,
        Ip_medical_appointment_id IN NUMBER,
        Ip_appointment_fee_id IN NUMBER,
        Ip_medical_appointment_status_id IN NUMBER,
        Ip_appointment_time IN TIMESTAMP
    )IS
    BEGIN
        UPDATE MEDICAL_APPOINTMENT_DETAIL
        SET
            user_id = Ip_user_id,
            doctor_id = Ip_doctor_id,
            medical_appointment_id = Ip_medical_appointment_id,
            appointment_fee_id = Ip_appointment_fee_id,
            medical_appointment_status_id = Ip_medical_appointment_status_id,
            appointment_time = Ip_appointment_time
        WHERE detail_id = Ip_detail_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered -'||SQLCODE||' - Error - ' ||SQLERRM);
    END Proc_Update_MEDICAL_APPOINTMENT_DETAIL;

    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_DETAIL(
        Op_medical_appointment_detail OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_medical_appointment_detail FOR
            SELECT
                detail_id,
                user_id,
                doctor_id,
                medical_appointment_id,
                appointment_fee_id,
                medical_appointment_status_id,
                appointment_time
            FROM MEDICAL_APPOINTMENT_DETAIL;
    
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered -'||SQLCODE||' - Error - ' ||SQLERRM);
    END Proc_Get_All_MEDICAL_APPOINTMENT_DETAIL;

    PROCEDURE PRoc_Get_MEDICAL_APPOINTMENT_DETAIL_BY_ID(
        Ip_detail_id IN NUMBER,
        Op_medical_appointment_detail OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_medical_appointment_detail FOR
            SELECT /*+ INDEX(md PK_MEDICAL_APPOINTMENT_DETAIL) */
                detail_id,
                user_id,
                doctor_id,
                medical_appointment_id,
                appointment_fee_id,
                medical_appointment_status_id,
                appointment_time
            FROM MEDICAL_APPOINTMENT_DETAIL md
            WHERE md.detail_id = Ip_detail_id; 
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END PRoc_Get_MEDICAL_APPOINTMENT_DETAIL_BY_ID;

END PCK_MEDICAL_APPOINTMENT_DETAIL;
