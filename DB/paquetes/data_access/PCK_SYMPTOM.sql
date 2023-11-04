CREATE OR REPLACE PACKAGE PCK_SYMPTOM IS

    PROCEDURE Proc_Insert_SYMPTOM(
        p_symptom_name IN VARCHAR2,
        p_symptom_priority IN NUMBER
    );

    PROCEDURE Proc_Update_SYMPTOM(
        p_symptom_id IN NUMBER,
        p_symptom_name IN VARCHAR2,
        p_symptom_priority IN NUMBER
    );

    PROCEDURE Proc_Get_All_SYMPTOM(
        p_symptom OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_SYMPTOM_BY_ID(
        p_symptom_id IN NUMBER,
        p_symptom OUT SYS_REFCURSOR
    );

END PCK_SYMPTOM;

CREATE OR REPLACE PACKAGE BODY PCK_SYMPTOM IS

    PROCEDURE Proc_Insert_SYMPTOM(
        p_symptom_name IN VARCHAR2,
        p_symptom_priority IN NUMBER
    ) IS
    v_symptom_id NUMBER;
    BEGIN
        v_symptom_id := SEQ_SYMPTOM.NEXTVAL;
        INSERT INTO SYMPTOM (symptom_id, symptom_name, symptom_priority)
        VALUES (v_symptom_id, p_symptom_name, p_symptom_priority);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Symptom already exists');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Insert_SYMPTOM;


    PROCEDURE Proc_Update_SYMPTOM(
        p_symptom_id IN NUMBER,
        p_symptom_name IN VARCHAR2,
        p_symptom_priority IN NUMBER
    ) IS
    BEGIN
        UPDATE SYMPTOM
        SET symptom_name = p_symptom_name,
            symptom_priority = p_symptom_priority
        WHERE symptom_id = p_symptom_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Update_SYMPTOM;


    PROCEDURE Proc_Get_All_SYMPTOM(
        p_symptom OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN p_symptom FOR
        SELECT 
            symptom_id, 
            symptom_name, 
            symptom_priority
        FROM SYMPTOM;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20004, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Get_All_SYMPTOM;


    PROCEDURE Proc_Get_SYMPTOM_BY_ID(
        p_symptom_id IN NUMBER,
        p_symptom OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN p_symptom FOR
        SELECT 
            symptom_id, 
            symptom_name, 
            symptom_priority
        FROM SYMPTOM
        WHERE symptom_id = p_symptom_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Get_SYMPTOM_BY_ID;
    
END PCK_SYMPTOM;
