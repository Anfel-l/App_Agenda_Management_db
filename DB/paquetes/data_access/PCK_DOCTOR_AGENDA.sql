CREATE OR REPLACE PACKAGE PCK_DOCTOR_AGENDA IS
    PROCEDURE Proc_Insert_DOCTOR_AGENDA (
        Ip_doctor_id IN NUMBER,
        Ip_detail_id IN NUMBER
    );

    PROCEDURE Proc_Update_DOCTOR_AGENDA (
        Ip_doctor_agenda_id IN NUMBER,
        Ip_doctor_id IN NUMBER,
        Ip_detail_id IN NUMBER
    );

    PROCEDURE Proc_Get_All_DOCTOR_AGENDA (
        Op_doctor_agenda OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_DOCTOR_AGENDA_BY_DOCTOR_ID(
        Ip_doctor_id IN NUMBER,
        Op_doctor_agenda OUT SYS_REFCURSOR
    );
END PCK_DOCTOR_AGENDA;

CREATE OR REPLACE PACKAGE BODY PCK_DOCTOR_AGENDA AS
    PROCEDURE Proc_Insert_DOCTOR_AGENDA (
        Ip_doctor_id IN NUMBER,
        Ip_detail_id IN NUMBER
    ) IS
    v_doctor_agenda_id NUMBER;
    BEGIN
    v_doctor_agenda_id := SEQ_DOCTOR_AGENDA.NEXTVAL;
    INSERT INTO DOCTOR_AGENDA (
        doctor_agenda_id,
        doctor_id,
        detail_id
    ) VALUES (
        v_doctor_agenda_id,
        Ip_doctor_id,
        Ip_detail_id
    );
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'The doctor agenda already exists.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '|| SQLCODE || '- Error -' || SQLERRM);
    END Proc_Insert_DOCTOR_AGENDA;

    PROCEDURE Proc_Update_DOCTOR_AGENDA (
        Ip_doctor_agenda_id IN NUMBER,
        Ip_doctor_id IN NUMBER,
        Ip_detail_id IN NUMBER
    ) IS
    BEGIN
    UPDATE DOCTOR_AGENDA
    SET
        doctor_id = Ip_doctor_id,
        detail_id = Ip_detail_id
    WHERE
        doctor_agenda_id = Ip_doctor_agenda_id;
    
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '|| SQLCODE || '- Error -' || SQLERRM);
    END Proc_Update_DOCTOR_AGENDA;

    PROCEDURE Proc_Get_All_DOCTOR_AGENDA (
        Op_doctor_agenda OUT SYS_REFCURSOR
    ) IS
    BEGIN

    OPEN Op_doctor_agenda FOR
    SELECT
        doctor_agenda_id,
        doctor_id,
        detail_id
    FROM DOCTOR_AGENDA;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '|| SQLCODE || '- Error -' || SQLERRM);
    END Proc_Get_All_DOCTOR_AGENDA;

    PROCEDURE Proc_Get_DOCTOR_AGENDA_BY_DOCTOR_ID(
        Ip_doctor_id IN NUMBER,
        Op_doctor_agenda OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_doctor_agenda FOR
        SELECT
            doctor_id,
            detail_id
        FROM DOCTOR_AGENDA
        WHERE doctor_id = Ip_doctor_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '|| SQLCODE || '- Error -' || SQLERRM);
    END Proc_Get_DOCTOR_AGENDA_BY_DOCTOR_ID;
END PCK_DOCTOR_AGENDA;

