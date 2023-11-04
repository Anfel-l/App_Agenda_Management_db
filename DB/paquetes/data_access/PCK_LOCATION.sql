CREATE OR REPLACE PACKAGE PCK_LOCATION IS
    PROCEDURE Proc_Insert_LOCATION(
        ip_location_name IN VARCHAR2
    );

    PROCEDURE Proc_Update_LOCATION(
        ip_location_id IN NUMBER,
        ip_location_name IN VARCHAR2
    );

    PROCEDURE Proc_Get_All_LOCATION(
        Op_location OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_LOCATION_BY_ID(
        ip_location_id IN NUMBER,
        Op_location OUT SYS_REFCURSOR
    );
END PCK_LOCATION;

CREATE OR REPLACE PACKAGE BODY PCK_LOCATION AS
    
    PROCEDURE Proc_Insert_LOCATION(
        ip_location_name IN VARCHAR2
    )IS
    v_location_id NUMBER;
    BEGIN
    v_location_id := SEQ_LOCATION.NEXTVAL;
    INSERT INTO LOCATION(
        location_id,
        location_name)
    VALUES(
        v_location_id,
        ip_location_name);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Location already exists');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);        
    END;

    PROCEDURE Proc_Update_LOCATION(
        ip_location_id IN NUMBER,
        ip_location_name IN VARCHAR2
    )IS
    BEGIN
        UPDATE LOCATION
        SET
            location_name = ip_location_name
        WHERE
            location_id = ip_location_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);        
    END;

    PROCEDURE Proc_Get_All_LOCATION(
        Op_location OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_location FOR
        SELECT
            location_id,
            location_name
        FROM
            LOCATION;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);        
    END;

    PROCEDURE Proc_Get_LOCATION_BY_ID(
        ip_location_id IN NUMBER,
        Op_location OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_location FOR
        SELECT
            location_id,
            location_name
        FROM
            LOCATION
        WHERE
            location_id = ip_location_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);        
    END;

END PCK_LOCATION;
