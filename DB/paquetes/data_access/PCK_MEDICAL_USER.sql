CREATE OR REPLACE PACKAGE PCK_MEDICAL_USER IS
    /* Procedures and function declaration*/

    PROCEDURE Proc_Insert_MEDICAL_USER (
        p_first_name         IN  VARCHAR2,
        p_second_name        IN  VARCHAR2,
        p_last_name          IN  VARCHAR2,
        p_document_type_id   IN  NUMBER,
        p_document           IN  VARCHAR2,
        p_password           IN  VARCHAR2,
        p_contract_type_id   IN  NUMBER,
        p_location_id        IN  NUMBER,
        p_email              IN  VARCHAR2
    );

    PROCEDURE Proc_Get_All_MEDICAL_USER (
        p_medical_users OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_MEDICAL_USER_BY_ID (
        p_user_id       IN NUMBER,
        p_medical_user  OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_MEDICAL_USER_BY_DOCUMENT (
        p_document      IN  VARCHAR2,
        p_medical_user  OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Update_MEDICAL_USER (
        p_user_id            IN  NUMBER,
        p_first_name         IN  VARCHAR2,
        p_second_name        IN  VARCHAR2,
        p_last_name          IN  VARCHAR2,
        p_document_type_id   IN  NUMBER,
        p_document           IN  VARCHAR2,
        p_password           IN  VARCHAR2,
        p_contract_type_id   IN  NUMBER,
        p_location_id        IN  NUMBER,
        p_email              IN  VARCHAR2
    );

END PCK_MEDICAL_USER;
CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_USER AS

    PROCEDURE Proc_Insert_MEDICAL_USER (
        p_first_name         IN  VARCHAR2,
        p_second_name        IN  VARCHAR2,
        p_last_name          IN  VARCHAR2,
        p_document_type_id   IN  NUMBER,
        p_document           IN  VARCHAR2,
        p_password           IN  VARCHAR2,
        p_contract_type_id   IN  NUMBER,
        p_location_id        IN  NUMBER,
        p_email              IN  VARCHAR2
    ) IS
    
    v_user_id NUMBER;
   
    BEGIN
	    v_user_id := SEQ_MEDICAL_USER.NEXTVAL;
	   
        INSERT INTO MEDICAL_USER (user_id, first_name, second_name, last_name, document_type_id, document, password, contract_type_id, location_id, email)
        VALUES (v_user_id, p_first_name, p_second_name, p_last_name, p_document_type_id, p_document, p_password, p_contract_type_id, p_location_id, p_email);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on insert');
        WHEN OTHERS THEN
            RAISE;
    END Proc_Insert_MEDICAL_USER;

    PROCEDURE Proc_Get_All_MEDICAL_USER (p_medical_users OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_medical_users FOR
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
    END Proc_Get_All_MEDICAL_USER;

    PROCEDURE Proc_Get_MEDICAL_USER_BY_ID (
        p_user_id       IN  NUMBER,
        p_medical_user  OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN p_medical_user FOR
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
       	FROM MEDICAL_USER WHERE user_id = p_user_id;
    END Proc_Get_MEDICAL_USER_BY_ID;

    PROCEDURE Proc_Get_MEDICAL_USER_BY_DOCUMENT (
        p_document      IN  VARCHAR2,
        p_medical_user  OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN p_medical_user FOR
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
        FROM MEDICAL_USER WHERE document = p_document;
    END Proc_Get_MEDICAL_USER_BY_DOCUMENT;

    PROCEDURE Proc_Update_MEDICAL_USER (
        p_user_id            IN  NUMBER,
        p_first_name         IN  VARCHAR2,
        p_second_name        IN  VARCHAR2,
        p_last_name          IN  VARCHAR2,
        p_document_type_id   IN  NUMBER,
        p_document           IN  VARCHAR2,
        p_password           IN  VARCHAR2,
        p_contract_type_id   IN  NUMBER,
        p_location_id        IN  NUMBER,
        p_email              IN  VARCHAR2
    ) IS
    BEGIN
        UPDATE MEDICAL_USER
        SET first_name = p_first_name,
            second_name = p_second_name,
            last_name = p_last_name,
            document_type_id = p_document_type_id,
            document = p_document,
            password = p_password,
            contract_type_id = p_contract_type_id,
            location_id = p_location_id,
            email = p_email
        WHERE user_id = p_user_id;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on update');
        WHEN OTHERS THEN
            RAISE;
    END Proc_Update_MEDICAL_USER;

END PCK_MEDICAL_USER;
