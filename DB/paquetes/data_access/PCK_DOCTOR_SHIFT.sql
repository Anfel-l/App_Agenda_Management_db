CREATE OR REPLACE PACKAGE PCK_DOCTOR_SHIFT IS
    PROCEDURE Proc_Insert_DOCTOR_SHIFT(
        Ip_doctor_id IN NUMBER,
        Ip_shift_date IN DATE,
        Ip_start_time IN TIMESTAMP,
        Ip_end_time IN TIMESTAMP
    );

    PROCEDURE Proc_Update_DOCTOR_SHIFT(
        Ip_doctor_shift_id IN NUMBER,
        Ip_doctor_id IN NUMBER,
        Ip_shift_date IN DATE,
        Ip_start_time IN TIMESTAMP,
        Ip_end_time IN TIMESTAMP
    );

    PROCEDURE Proc_Get_All_DOCTOR_SHIFT(
        Op_doctor_shift OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_DOCTOR_SHIFT_BY_ID(
        Ip_doctor_shift_id IN NUMBER,
        Op_doctor_shift OUT SYS_REFCURSOR
    );
END PCK_DOCTOR_SHIFT;

CREATE OR REPLACE PACKAGE BODY PCK_DOCTOR_SHIFT AS
    PROCEDURE Proc_Insert_DOCTOR_SHIFT(
        Ip_doctor_id IN NUMBER,
        Ip_shift_date IN DATE,
        Ip_start_time IN TIMESTAMP,
        Ip_end_time IN TIMESTAMP
    ) IS
    v_doctor_shift_id NUMBER;
    BEGIN
    v_doctor_shift_id := SEQ_DOCTOR_SHIFT.NEXTVAL;
    INSERT INTO DOCTOR_SHIFT(
        doctor_shift_id,
        doctor_id,
        shift_date,
        start_time,
        end_time
    ) VALUES (
        v_doctor_shift_id,
        Ip_doctor_id,
        Ip_shift_date,
        Ip_start_time,
        Ip_end_time
    );
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Duplicate value');
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Insert_DOCTOR_SHIFT;

    PROCEDURE Proc_Update_DOCTOR_SHIFT(
        Ip_doctor_shift_id IN NUMBER,
        Ip_doctor_id IN NUMBER,
        Ip_shift_date IN DATE,
        Ip_start_time IN TIMESTAMP,
        Ip_end_time IN TIMESTAMP
    ) IS
    BEGIN
        UPDATE DOCTOR_SHIFT
        SET
            doctor_id = Ip_doctor_id,
            shift_date = Ip_shift_date,
            start_time = Ip_start_time,
            end_time = Ip_end_time
        WHERE doctor_shift_id = Ip_doctor_shift_id; 
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Update_DOCTOR_SHIFT;

    PROCEDURE Proc_Get_All_DOCTOR_SHIFT(
        Op_doctor_shift OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_doctor_shift FOR
        SELECT
            doctor_shift_id,
            doctor_id,
            shift_date,
            start_time,
            end_time
        FROM DOCTOR_SHIFT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '|| SQLCODE || '- ERROR - ' || SQLERRM);
    END Proc_Get_All_DOCTOR_SHIFT;

    PROCEDURE Proc_Get_DOCTOR_SHIFT_BY_ID(
        Ip_doctor_shift_id IN NUMBER,
        Op_doctor_shift OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_doctor_shift FOR
        SELECT /*+ INDEX(ds PK_DOCTOR_SHIFT) */
            doctor_shift_id,
            doctor_id,
            shift_date,
            start_time,
            end_time
        FROM DOCTOR_SHIFT ds
        WHERE ds.doctor_shift_id = Ip_doctor_shift_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '|| SQLCODE || '- ERROR - ' || SQLERRM);
    END Proc_Get_DOCTOR_SHIFT_BY_ID;

END PCK_DOCTOR_SHIFT;
