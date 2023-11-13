CREATE OR REPLACE PACKAGE PCK_MEDICAL_CENTER IS
    PROCEDURE Proc_Insert_MEDICAL_CENTER(
        Ip_medical_center_name IN VARCHAR2,
        Ip_location_id IN NUMBER
    );

    PROCEDURE Proc_Update_MEDICAL_CENTER(
        Ip_medical_center_id IN NUMBER,
        Ip_medical_center_name IN VARCHAR2,
        Ip_location_id IN NUMBER
    );

    PROCEDURE Proc_Get_All_MEDICAL_CENTER(
        Op_medical_center OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_MEDICAL_CENTER_BY_ID(
        Ip_medical_center_id IN NUMBER,
        Op_medical_center OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_MEDICAL_CENTER_BY_LOCATION(
        Ip_location_id IN NUMBER,
        Op_medical_center OUT SYS_REFCURSOR
    );

END PCK_MEDICAL_CENTER;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_CENTER AS

    PROCEDURE Proc_Insert_MEDICAL_CENTER(
        Ip_medical_center_name IN VARCHAR2,
        Ip_location_id IN NUMBER
    )IS
    v_medical_center_id NUMBER;
    BEGIN
        v_medical_center_id := SEQ_MEDICAL_CENTER.NEXTVAL;
        INSERT INTO MEDICAL_CENTER(medical_center_id, medical_center_name, location_id)
        VALUES(v_medical_center_id, Ip_medical_center_name, Ip_location_id);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Symptom already exists');
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;  
    END Proc_Insert_MEDICAL_CENTER;


    PROCEDURE Proc_Update_MEDICAL_CENTER(
        Ip_medical_center_id IN NUMBER,
        Ip_medical_center_name IN VARCHAR2,
        Ip_location_id IN NUMBER
    )IS
    BEGIN
        UPDATE MEDICAL_CENTER
        SET medical_center_name = Ip_medical_center_name,
            location_id = Ip_location_id
        WHERE medical_center_id = Ip_medical_center_id;
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Update_MEDICAL_CENTER;

    PROCEDURE Proc_Get_All_MEDICAL_CENTER(
        Op_medical_center OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_medical_center FOR
        SELECT medical_center_id, medical_center_name, location_id
        FROM MEDICAL_CENTER;
    EXCEPTION
         WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Get_All_MEDICAL_CENTER;

    PROCEDURE Proc_Get_MEDICAL_CENTER_BY_ID(
        Ip_medical_center_id IN NUMBER,
        Op_medical_center OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_medical_center FOR
        SELECT /*+ INDEX( mc PK_MEDICAL_CENTER) */
        medical_center_id, medical_center_name, location_id
        FROM MEDICAL_CENTER mc
        WHERE mc.medical_center_id = Ip_medical_center_id;
    EXCEPTION
         WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Get_MEDICAL_CENTER_BY_ID;

    PROCEDURE Proc_Get_MEDICAL_CENTER_BY_LOCATION(
        Ip_location_id IN NUMBER,
        Op_medical_center OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_medical_center FOR
        SELECT /*+ INDEX( mc idx_medical_center_location*/
        medical_center_id, medical_center_name, location_id
        FROM MEDICAL_CENTER mc
        WHERE mc.location_id = Ip_location_id;
    EXCEPTION
         WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Get_MEDICAL_CENTER_BY_LOCATION;
END PCK_MEDICAL_CENTER;
