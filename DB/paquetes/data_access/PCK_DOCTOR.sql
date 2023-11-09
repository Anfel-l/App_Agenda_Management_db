CREATE OR REPLACE PACKAGE PCK_DOCTOR IS
    PROCEDURE Proc_Insert_DOCTOR(
        Ip_first_name IN VARCHAR2,
        Ip_second_name IN VARCHAR2,
        Ip_last_name IN VARCHAR2,
        Ip_medical_field_id IN NUMBER,
        Ip_medical_center_id IN NUMBER
    );

    PROCEDURE Proc_Update_DOCTOR(
        Ip_doctor_id IN NUMBER,
        Ip_first_name IN VARCHAR2,
        Ip_second_name IN VARCHAR2,
        Ip_last_name IN VARCHAR2,
        Ip_medical_field_id IN NUMBER,
        Ip_medical_center_id IN NUMBER
    );

    PROCEDURE Proc_Get_All_DOCTOR(
        Op_doctor OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_DOCTOR_BY_ID(
        Ip_doctor_id IN NUMBER,
        Op_doctor OUT SYS_REFCURSOR
    );

END PCK_DOCTOR;

CREATE OR REPLACE PACKAGE BODY PCK_DOCTOR AS
    PROCEDURE Proc_Insert_DOCTOR(
        Ip_first_name IN VARCHAR2,
        Ip_second_name IN VARCHAR2,
        Ip_last_name IN VARCHAR2,
        Ip_medical_field_id IN NUMBER,
        Ip_medical_center_id IN NUMBER
    ) IS
    v_doctor_id NUMBER;
    BEGIN
    v_doctor_id := SEQ_DOCTOR.NEXTVAL;
        INSERT INTO DOCTOR(
            doctor_id,
            first_name,
            second_name,
            last_name,
            medical_field_id,
            medical_center_id
        ) VALUES (
            v_doctor_id,
            Ip_first_name,
            Ip_second_name,
            Ip_last_name,
            Ip_medical_field_id,
            Ip_medical_center_id
        );
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'The doctor already exists.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - ' || SQLCODE || ' - ERROR - ' ||SQLERRM);
    END PROC_Insert_DOCTOR;

    PROCEDURE Proc_Update_DOCTOR(
        Ip_doctor_id IN NUMBER,
        Ip_first_name IN VARCHAR2,
        Ip_second_name IN VARCHAR2,
        Ip_last_name IN VARCHAR2,
        Ip_medical_field_id IN NUMBER,
        Ip_medical_center_id IN NUMBER
    ) IS
    BEGIN
        UPDATE DOCTOR
        SET
            first_name = Ip_first_name,
            second_name = Ip_second_name,
            last_name = Ip_last_name,
            medical_field_id = Ip_medical_field_id,
            medical_center_id = Ip_medical_center_id
        WHERE doctor_id = Ip_doctor_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - ' || SQLCODE || ' - ERROR - ' ||SQLERRM);
    END PROC_Update_DOCTOR;

    PROCEDURE Proc_Get_All_DOCTOR(
        Op_doctor OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_doctor FOR
            SELECT
                doctor_id,
                first_name,
                second_name,
                last_name,
                medical_field_id,
                medical_center_id
            FROM DOCTOR;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - ' || SQLCODE || ' - ERROR - ' ||SQLERRM);
    END Proc_Get_All_DOCTOR;

    PROCEDURE Proc_Get_DOCTOR_BY_ID(
        Ip_doctor_id IN NUMBER,
        Op_doctor OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_doctor FOR
            SELECT
                doctor_id,
                first_name,
                second_name,
                last_name,
                medical_field_id,
                medical_center_id
            FROM DOCTOR
            WHERE doctor_id = Ip_doctor_id; 
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - ' || SQLCODE || ' - ERROR - ' ||SQLERRM);
    END Proc_Get_DOCTOR_BY_ID;

    

END PCK_DOCTOR;
