/*******************************************************************************
Description: Creation script for the package PCK_MEDICAL_USER
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE OR REPLACE PACKAGE PCK_MEDICAL_USER IS

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Insert_MEDICAL_USER
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_MEDICAL_USER (
        Ip_first_name         IN  VARCHAR2,
        Ip_second_name        IN  VARCHAR2,
        Ip_last_name          IN  VARCHAR2,
        Ip_document_type_id   IN  NUMBER,
        Ip_document           IN  VARCHAR2,
        Ip_password           IN  VARCHAR2,
        Ip_contract_type_id   IN  NUMBER,
        Ip_location_id        IN  NUMBER,
        Ip_email              IN  VARCHAR2
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_All_MEDICAL_USER
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_MEDICAL_USER (
        Op_medical_users OUT SYS_REFCURSOR
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_MEDICAL_USER_BY_ID
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_MEDICAL_USER_BY_ID (
        Ip_user_id       IN NUMBER,
        Op_medical_user  OUT SYS_REFCURSOR
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_MEDICAL_USER_BY_DOCUMENT
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_MEDICAL_USER_BY_DOCUMENT (
        Ip_document      IN  VARCHAR2,
        Op_medical_user  OUT SYS_REFCURSOR
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Update_MEDICAL_USER
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_MEDICAL_USER (
        Ip_user_id            IN  NUMBER,
        Ip_first_name         IN  VARCHAR2,
        Ip_second_name        IN  VARCHAR2,
        Ip_last_name          IN  VARCHAR2,
        Ip_document_type_id   IN  NUMBER,
        Ip_document           IN  VARCHAR2,
        Ip_password           IN  VARCHAR2,
        Ip_contract_type_id   IN  NUMBER,
        Ip_location_id        IN  NUMBER,
        Ip_email              IN  VARCHAR2
    );

END PCK_MEDICAL_USER;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_USER AS

    PROCEDURE Proc_Insert_MEDICAL_USER (
        Ip_first_name         IN  VARCHAR2,
        Ip_second_name        IN  VARCHAR2,
        Ip_last_name          IN  VARCHAR2,
        Ip_document_type_id   IN  NUMBER,
        Ip_document           IN  VARCHAR2,
        Ip_password           IN  VARCHAR2,
        Ip_contract_type_id   IN  NUMBER,
        Ip_location_id        IN  NUMBER,
        Ip_email              IN  VARCHAR2
    ) IS
    
    v_user_id NUMBER;
   
    BEGIN
	    v_user_id := SEQ_MEDICAL_USER.NEXTVAL;
	   
        INSERT INTO MEDICAL_USER (user_id, first_name, second_name, last_name, document_type_id, document, password, contract_type_id, location_id, email)
        VALUES (v_user_id, Ip_first_name, Ip_second_name, Ip_last_name, Ip_document_type_id, Ip_document, Ip_password, Ip_contract_type_id, Ip_location_id, Ip_email);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on insert');
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Insert_MEDICAL_USER;

    PROCEDURE Proc_Get_All_MEDICAL_USER (Op_medical_users OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN Op_medical_users FOR
        SELECT
            user_id,
        	first_name,
            second_name,
            last_name,
            document_type_id,
            document,
            password,
            contract_type_id,
            location_id,
            email
        FROM MEDICAL_USER;
    EXCEPTION
         WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Get_All_MEDICAL_USER;

    PROCEDURE Proc_Get_MEDICAL_USER_BY_ID (
        Ip_user_id       IN  NUMBER,
        Op_medical_user  OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_medical_user FOR
        SELECT /*+ INDEX(mu PK_MEDICAL_USER) */ 
            user_id,
        	first_name,
            second_name,
            last_name,
            document_type_id,
            document,
            password,
            contract_type_id,
            location_id,
            email
       	FROM MEDICAL_USER mu
        WHERE mu.user_id = Ip_user_id;
    EXCEPTION
         WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Get_MEDICAL_USER_BY_ID;

    PROCEDURE Proc_Get_MEDICAL_USER_BY_DOCUMENT (
        Ip_document      IN  VARCHAR2,
        Op_medical_user  OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_medical_user FOR
        SELECT /*+ INDEX(mu idx_medical_user_document) */
        	user_id,
        	first_name,
            second_name,
            last_name,
            document_type_id,
            document,
            password,
            contract_type_id,
            location_id,
            email
        FROM MEDICAL_USER mu 
        WHERE mu.document = Ip_document;
    EXCEPTION
         WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END Proc_Get_MEDICAL_USER_BY_DOCUMENT;

    PROCEDURE Proc_Update_MEDICAL_USER (
        Ip_user_id            IN  NUMBER,
        Ip_first_name         IN  VARCHAR2,
        Ip_second_name        IN  VARCHAR2,
        Ip_last_name          IN  VARCHAR2,
        Ip_document_type_id   IN  NUMBER,
        Ip_document           IN  VARCHAR2,
        Ip_password           IN  VARCHAR2,
        Ip_contract_type_id   IN  NUMBER,
        Ip_location_id        IN  NUMBER,
        Ip_email              IN  VARCHAR2
    ) IS
    BEGIN
        UPDATE MEDICAL_USER
        SET first_name = Ip_first_name,
            second_name = Ip_second_name,
            last_name = Ip_last_name,
            document_type_id = Ip_document_type_id,
            document = Ip_document,
            password = Ip_password,
            contract_type_id = Ip_contract_type_id,
            location_id = Ip_location_id,
            email = Ip_email
        WHERE user_id = Ip_user_id;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on update');
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Update_MEDICAL_USER;

END PCK_MEDICAL_USER;
