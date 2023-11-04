CREATE OR REPLACE PACKAGE PCK_MEDICAL_APPOINTMENT_TYPE IS
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_TYPE(
        Ip_medical_appointment_type_name IN VARCHAR2,
        Ip_description IN VARCHAR2
    );

    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_TYPE(
        Ip_medical_appointment_type_id IN NUMBER,
        Ip_medical_appointment_type_name IN VARCHAR2,
        Ip_description IN VARCHAR2
    );

    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_TYPE(
        Op_medical_appointment_type OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_TYPE_BY_ID(
        Ip_medical_appointment_type_id IN NUMBER,
        Op_medical_appointment_type OUT SYS_REFCURSOR
    );
END PCK_MEDICAL_APPOINTMENT_TYPE;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_APPOINTMENT_TYPE AS
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_TYPE(
        Ip_medical_appointment_type_name IN VARCHAR2,
        Ip_description IN VARCHAR2
    )IS
    v_medical_appointmnet_type_id NUMBER;
    BEGIN
        v_medical_appointmnet_type_id := SEQ_MEDICAL_APPOINTMENT_TYPE.NEXTVAL;
        INSERT INTO MEDICAL_APPOINTMENT_TYPE(
            medical_appointment_type_id,
            medical_appointment_type_name,
            description)
        VALUES(
            v_medical_appointmnet_type_id,
            Ip_medical_appointment_type_name,
            Ip_description);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Medical appointment type already exists');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '||SQLCODE||' -ERROR- '|| SQLERRM);
    END Proc_Insert_MEDICAL_APPOINTMENT_TYPE;

    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_TYPE(
        Ip_medical_appointment_type_id IN NUMBER,
        Ip_medical_appointment_type_name IN VARCHAR2,
        Ip_description IN VARCHAR2
    )IS
    BEGIN
        UPDATE MEDICAL_APPOINTMENT_TYPE
        SET
            medical_appointment_type_name = Ip_medical_appointment_type_name,
            description = Ip_description
        WHERE medical_appointment_type_id = Ip_medical_appointment_type_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '||SQLCODE||' -ERROR- '|| SQLERRM);
    END Proc_Update_MEDICAL_APPOINTMENT_TYPE;

    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_TYPE(
        Op_medical_appointment_type OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_medical_appointment_type FOR
            SELECT
                medical_appointment_type_id,
                medical_appointment_type_name,
                description
            FROM MEDICAL_APPOINTMENT_TYPE;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '||SQLCODE||' -ERROR- '|| SQLERRM);
    END Proc_Get_All_MEDICAL_APPOINTMENT_TYPE;

    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_TYPE_BY_ID(
        Ip_medical_appointment_type_id IN NUMBER,
        Op_medical_appointment_type OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_medical_appointment_type FOR
            SELECT
                medical_appointment_type_id,
                medical_appointment_type_name,
                description
            FROM MEDICAL_APPOINTMENT_TYPE
            WHERE medical_appointment_type_id = Ip_medical_appointment_type_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '||SQLCODE||' -ERROR- '|| SQLERRM);
    END Proc_Get_MEDICAL_APPOINTMENT_TYPE_BY_ID;
END PCK_MEDICAL_APPOINTMENT_TYPE;
