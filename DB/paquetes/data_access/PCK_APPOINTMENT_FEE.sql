CREATE OR REPLACE PACKAGE PCK_APPOINTMENT_FEE IS
    PROCEDURE Proc_Insert_APPOINTMENT_FEE(
        Ip_contract_type_id IN NUMBER,
        Ip_fee_value IN NUMBER
    );

    PROCEDURE Proc_Update_APPOINTMENT_FEE(
        Ip_appointment_fee_id IN NUMBER,
        Ip_contract_type_id IN NUMBER,
        Ip_fee_value IN NUMBER
    );

    PROCEDURE Proc_Get_All_APPOINTMENT_FEE(
        Op_appointment_fee OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_APPOINTMENT_FEE_BY_CONTRACT_TYPE_ID(
        Ip_contract_type_id IN NUMBER,
        Op_appointment_fee OUT SYS_REFCURSOR
    );

END PCK_APPOINTMENT_FEE;

CREATE OR REPLACE PACKAGE BODY PCK_APPOINTMENT_FEE AS
    PROCEDURE Proc_Insert_APPOINTMENT_FEE(
        Ip_contract_type_id IN NUMBER,
        Ip_fee_value IN NUMBER
    ) IS
    v_appointment_fee_id NUMBER;
    BEGIN
    v_appointment_fee_id := SEQ_APPOINTMENT_FEE.NEXTVAL;
        INSERT INTO APPOINTMENT_FEE
        (
            appointment_fee_id,
            contract_type_id,
            fee_value
        )
        VALUES
        (
            v_appointment_fee_id,
            Ip_contract_type_id,
            Ip_fee_value
        );
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'APPOINTMENT_FEE already exists.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
    END Proc_Insert_APPOINTMENT_FEE;

    PROCEDURE Proc_Update_APPOINTMENT_FEE(
        Ip_appointment_fee_id IN NUMBER,
        Ip_contract_type_id IN NUMBER,
        Ip_fee_value IN NUMBER
    ) IS
    BEGIN
        UPDATE APPOINTMENT_FEE
        SET
            contract_type_id = Ip_contract_type_id,
            fee_value = Ip_fee_value
        WHERE appointment_fee_id = Ip_appointment_fee_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
    END Proc_Update_APPOINTMENT_FEE;

    PROCEDURE Proc_Get_All_APPOINTMENT_FEE(
        Op_appointment_fee OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_appointment_fee FOR
            SELECT
                appointment_fee_id,
                contract_type_id,
                fee_value
            FROM APPOINTMENT_FEE;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
    END Proc_Get_All_APPOINTMENT_FEE;

    PROCEDURE Proc_Get_APPOINTMENT_FEE_BY_CONTRACT_TYPE_ID(
        Ip_contract_type_id IN NUMBER,
        Op_appointment_fee OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_appointment_fee FOR
            SELECT /*+ INDEX(af idx_appointment_fee_contract_type_id) */
                appointment_fee_id,
                contract_type_id,
                fee_value
            FROM APPOINTMENT_FEE af
            WHERE af.contract_type_id = Ip_contract_type_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
    END Proc_Get_APPOINTMENT_FEE_BY_CONTRACT_TYPE_ID;
END PCK_APPOINTMENT_FEE;
