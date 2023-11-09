CREATE OR REPLACE PACKAGE PCK_MEDICAL_USER IS

    PROCEDURE Proc_Insert_Medical_Users (
        Ip_medical_users IN medical_user_tbl
    );

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

    PROCEDURE Proc_Get_All_MEDICAL_USER (
        Op_medical_users OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_MEDICAL_USER_BY_ID (
        Ip_user_id       IN NUMBER,
        Op_medical_user  OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_MEDICAL_USER_BY_DOCUMENT (
        Ip_document      IN  VARCHAR2,
        Op_medical_user  OUT SYS_REFCURSOR
    );

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

    TYPE medical_user_rec IS RECORD (
        first_name        VARCHAR2(255),
        second_name       VARCHAR2(255),
        last_name         VARCHAR2(255),
        document_type_id  NUMBER,
        document          VARCHAR2(255),
        password          VARCHAR2(255),
        contract_type_id  NUMBER,
        location_id       NUMBER,
        email             VARCHAR2(255)
    );

    TYPE medical_user_tbl IS TABLE OF medical_user_rec INDEX BY PLS_INTEGER;

    PROCEDURE Proc_Insert_Medical_Users (Ip_medical_users IN medical_user_tbl) IS
    BEGIN
        FORALL i IN Ip_medical_users.FIRST .. Ip_medical_users.LAST
            INSERT INTO MEDICAL_USER (
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
            )
            VALUES (
                SEQ_MEDICAL_USER.NEXTVAL,
                Ip_medical_users(i).first_name,
                Ip_medical_users(i).second_name,
                Ip_medical_users(i).last_name,
                Ip_medical_users(i).document_type_id,
                Ip_medical_users(i).document,
                Ip_medical_users(i).password,
                Ip_medical_users(i).contract_type_id,
                Ip_medical_users(i).location_id,
                Ip_medical_users(i).email
            );
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on insert');
        WHEN OTHERS THEN
            RAISE;
    END Proc_Insert_Medical_Users;



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
            RAISE;
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
    END Proc_Get_All_MEDICAL_USER;

    PROCEDURE Proc_Get_MEDICAL_USER_BY_ID (
        Ip_user_id       IN  NUMBER,
        Op_medical_user  OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_medical_user FOR
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
       	FROM MEDICAL_USER WHERE user_id = Ip_user_id;
    END Proc_Get_MEDICAL_USER_BY_ID;

    PROCEDURE Proc_Get_MEDICAL_USER_BY_DOCUMENT (
        Ip_document      IN  VARCHAR2,
        Op_medical_user  OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_medical_user FOR
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
        FROM MEDICAL_USER WHERE document = Ip_document;
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
            RAISE;
    END Proc_Update_MEDICAL_USER;

END PCK_MEDICAL_USER;
