CREATE OR REPLACE PACKAGE PCK_CONTRACT_TYPE IS
    PROCEDURE Proc_Insert_CONTRACT_TYPE(
        Ip_contract_type_name IN VARCHAR2,
        Ip_description IN VARCHAR2,
        Ip_contract_type_priority IN NUMBER
    );

    PROCEDURE Proc_Update_CONTRACT_TYPE(
        Ip_contract_type_id IN NUMBER,
        Ip_contract_type_name IN VARCHAR2,
        Ip_description IN VARCHAR2,
        Ip_contract_type_priority IN NUMBER

    );

    PROCEDURE Proc_Get_All_CONTRACT_TYPE(
        Op_contract_type OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_CONTRACT_TYPE_BY_ID(
        Ip_contract_type_id IN NUMBER,
        Op_contract_type OUT SYS_REFCURSOR
    );

END PCK_CONTRACT_TYPE;

CREATE OR REPLACE PACKAGE BODY PCK_CONTRACT_TYPE AS
    PROCEDURE Proc_Insert_CONTRACT_TYPE(
        Ip_contract_type_name IN VARCHAR2,
        Ip_description IN VARCHAR2,
        Ip_contract_type_priority IN NUMBER
    )IS
    v_contract_type_id NUMBER;
    BEGIN
    v_contract_type_id := SEQ_CONTRACT_TYPE.NEXTVAL;
    INSERT INTO CONTRACT_TYPE(
        contract_type_id,
        contract_type_name,
        description,
        contract_type_priority)
    VALUES(
        v_contract_type_id,
        Ip_contract_type_name,
        Ip_description,
        Ip_contract_type_priority);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Duplicate value');
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Insert_CONTRACT_TYPE;

    PROCEDURE Proc_Update_CONTRACT_TYPE(
        Ip_contract_type_id IN NUMBER,
        Ip_contract_type_name IN VARCHAR2,
        Ip_description IN VARCHAR2,
        Ip_contract_type_priority IN NUMBER

    )IS
    BEGIN
        UPDATE CONTRACT_TYPE
        SET
            contract_type_name = Ip_contract_type_name,
            description = Ip_description,
            contract_type_priority = Ip_contract_type_priority
        WHERE
            contract_type_id = Ip_contract_type_id; 
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Update_CONTRACT_TYPE;

    PROCEDURE Proc_Get_All_CONTRACT_TYPE(
        Op_contract_type OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_contract_type FOR
            SELECT
                contract_type_id,
                contract_type_name,
                description,
                contract_type_priority
            FROM
                CONTRACT_TYPE;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered -' || SQLCODE || '- ERROR -' || SQLERRM);
    END Proc_Get_All_CONTRACT_TYPE;

    PROCEDURE Proc_Get_CONTRACT_TYPE_BY_ID(
        Ip_contract_type_id IN NUMBER,
        Op_contract_type OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_contract_type FOR
        SELECT /*+ INDEX(ct PK_CONTRACT_TYPE) */
            contract_type_id,
            contract_type_name,
            description,
            contract_type_priority
        FROM CONTRACT_TYPE ct
        WHERE ct.contract_type_id = Ip_contract_type_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered -' || SQLCODE || '- ERROR -' || SQLERRM);
    END Proc_Get_CONTRACT_TYPE_BY_ID;
END PCK_CONTRACT_TYPE;
