/*******************************************************************************
Description: Creation script for the package PCK_MEDICAL_FIELD
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE OR REPLACE PACKAGE PCK_MEDICAL_FIELD IS

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Insert_MEDICAL_FIELD
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/    
    PROCEDURE Proc_Insert_MEDICAL_FIELD(
        Ip_medical_field_name IN VARCHAR2,
        Ip_description IN VARCHAR2
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Update_MEDICAL_FIELD
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_MEDICAL_FIELD(
        Ip_medical_field_id IN NUMBER,
        Ip_medical_field_name IN VARCHAR2,
        Ip_description IN VARCHAR2
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_All_MEDICAL_FIELD
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_MEDICAL_FIELD(
        Op_medical_field OUT SYS_REFCURSOR
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_MEDICAL_FIELD_BY_ID
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_MEDICAL_FIELD_BY_ID(
        Ip_medical_field_id IN NUMBER,
        Op_medical_field OUT SYS_REFCURSOR
    );

END PCK_MEDICAL_FIELD;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_FIELD AS

    
    PROCEDURE Proc_Insert_MEDICAL_FIELD(
        Ip_medical_field_name IN VARCHAR2,
        Ip_description IN VARCHAR2
    )IS

    v_medical_field_id NUMBER;
    BEGIN
        v_medical_field_id := SEQ_MEDICAL_FIELD.NEXTVAL;
        INSERT INTO MEDICAL_FIELD(medical_field_id,medical_field_name,description)
        VALUES(v_medical_field_id,Ip_medical_field_name,Ip_description);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001,'Already existing - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Insert_MEDICAL_FIELD;

    PROCEDURE Proc_Update_MEDICAL_FIELD(
        Ip_medical_field_id IN NUMBER,
        Ip_medical_field_name IN VARCHAR2,
        Ip_description IN VARCHAR2
    )IS
    BEGIN
        UPDATE MEDICAL_FIELD
        SET medical_field_name = Ip_medical_field_name,
            description = Ip_description
        WHERE medical_field_id = Ip_medical_field_id;
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Update_MEDICAL_FIELD;

    PROCEDURE Proc_Get_All_MEDICAL_FIELD(
        Op_medical_field OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_medical_field FOR
        SELECT 
            medical_field_id,
            medical_field_name,
            description
        FROM MEDICAL_FIELD;
    EXCEPTION
         WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Get_All_MEDICAL_FIELD;

    PROCEDURE Proc_Get_MEDICAL_FIELD_BY_ID(
        Ip_medical_field_id IN NUMBER,
        Op_medical_field OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_medical_field FOR
        SELECT /*+ INDEX(mf PK_MEDICAL_FIELD) */
            medical_field_id,
            medical_field_name,
            description
        FROM MEDICAL_FIELD mf
        WHERE mf.medical_field_id = Ip_medical_field_id;
    EXCEPTION
         WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Get_MEDICAL_FIELD_BY_ID;


END PCK_MEDICAL_FIELD;
