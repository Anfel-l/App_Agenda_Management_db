/*******************************************************************************
Description: Creation script for the package PCK_SYMPTOM
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE OR REPLACE PACKAGE PCK_SYMPTOM IS

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Insert_SYMPTOM
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_SYMPTOM(
        Ip_symptom_name IN VARCHAR2,
        Ip_symptom_priority IN NUMBER
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Update_SYMPTOM
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_SYMPTOM(
        Ip_symptom_id IN NUMBER,
        Ip_symptom_name IN VARCHAR2,
        Ip_symptom_priority IN NUMBER
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_All_SYMPTOM
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_SYMPTOM(
        Op_symptom OUT SYS_REFCURSOR
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_SYMPTOM_BY_ID
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_SYMPTOM_BY_ID(
        Ip_symptom_id IN NUMBER,
        Op_symptom OUT SYS_REFCURSOR
    );

END PCK_SYMPTOM;

CREATE OR REPLACE PACKAGE BODY PCK_SYMPTOM IS

    PROCEDURE Proc_Insert_SYMPTOM(
        Ip_symptom_name IN VARCHAR2,
        Ip_symptom_priority IN NUMBER
    ) IS
    v_symptom_id NUMBER;
    BEGIN
        v_symptom_id := SEQ_SYMPTOM.NEXTVAL;
        INSERT INTO SYMPTOM (symptom_id, symptom_name, symptom_priority)
        VALUES (v_symptom_id, Ip_symptom_name, Ip_symptom_priority);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Symptom already exists');
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Insert_SYMPTOM;


    PROCEDURE Proc_Update_SYMPTOM(
        Ip_symptom_id IN NUMBER,
        Ip_symptom_name IN VARCHAR2,
        Ip_symptom_priority IN NUMBER
    ) IS
    BEGIN
        UPDATE SYMPTOM
        SET symptom_name = Ip_symptom_name,
            symptom_priority = Ip_symptom_priority
        WHERE symptom_id = Ip_symptom_id;
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Update_SYMPTOM;


    PROCEDURE Proc_Get_All_SYMPTOM(
        Op_symptom OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_symptom FOR
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
        Ip_symptom_id IN NUMBER,
        Op_symptom OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_symptom FOR
        SELECT /*+ INDEX (s PK_SYMPTOM) */
            symptom_id, 
            symptom_name, 
            symptom_priority
        FROM SYMPTOM s
        WHERE s.symptom_id = Ip_symptom_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Get_SYMPTOM_BY_ID;
    
END PCK_SYMPTOM;
