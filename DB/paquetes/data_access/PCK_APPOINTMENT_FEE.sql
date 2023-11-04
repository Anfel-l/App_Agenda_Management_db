CREATE OR REPLACE PACKAGE PCK_APPOINTMENT_FEE IS
    /*******************************************************************************
    Description: Package for data manipulation of the table APPOINMENT_FEE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcAPPOINTMENT_FEE IS APPOINTMENT_FEE%ROWTYPE;
    TYPE tytbAPPOINTMENT_FEE IS TABLE OF tyrcAPPOINTMENT_FEE INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table APPOINTMENT_FEE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_APPOINTMENT_FEE (
        IOp_Appointment_Fee IN OUT NOCOPY tyrcAPPOINTMENT_FEE
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table APPOINTMENT_FEE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_APPOINTMENT_FEE (
        Op_Appointment_Fee OUT NOCOPY tytbAPPOINTMENT_FEE
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table APPOINTMENT_FEE by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_APPOINTMENT_FEE (
        Ip_Id in NUMBER,
        Op_Appointment_Fee OUT NOCOPY tyrcAPPOINTMENT_FEE
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table APPOINTMENT_FEE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_APPOINTMENT_FEE (
        IOp_Appointment_Fee IN OUT NOCOPY tyrcAPPOINTMENT_FEE
    );

END PCK_APPOINTMENT_FEE;

CREATE OR REPLACE PACKAGE BODY PCK_APPOINTMENT_FEE AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_APPOINTMENT_FEE (IOp_Appointment_Fee IN OUT NOCOPY tyrcAPPOINTMENT_FEE) IS
        BEGIN

            /* Initialazing values */
            IOp_Appointment_Fee.appointment_fee_id := SEQ_APPOINTMENT_FEE.NEXTVAL;

            /* Inserting a register */
            INSERT INTO APPOINTMENT_FEE VALUES /*+PCK_APPOINTMENT_FEE*/ IOp_Appointment_Fee;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_APPOINTMENT_FEE.Proc_Insert_APPOINTMENT_FEE]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_APPOINTMENT_FEE;


    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_APPOINTMENT_FEE (Op_Appointment_Fee OUT NOCOPY tytbAPPOINTMENT_FEE) IS
        CURSOR cur_APPOINTMENT_FEE IS
            SELECT
                appointment_fee_id,
                contract_type_id,
                fee_value
            FROM APPOINTMENT_FEE;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_APPOINTMENT_FEE LOOP
                Op_Appointment_Fee(idx) := rec;
                idx := idx + 1;
            END LOOP;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_APPOINTMENT_FEE.Proc_Get_APPOINTMENT_FEE]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_APPOINTMENT_FEE;


    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_APPOINTMENT_FEE (Ip_Id in NUMBER, Op_Appointment_Fee OUT NOCOPY tyrcAPPOINTMENT_FEE) IS
        CURSOR cur_APPOINTMENT_FEE IS
            SELECT
                appointment_fee_id,
                contract_type_id,
                fee_value
            FROM APPOINTMENT_FEE
            WHERE /*+PCK_APPOINTMENT_FEE.Proc_Get_APPOINTMENT_FEE*/ appointment_fee_id = Ip_Id;          
        BEGIN
            OPEN cur_APPOINTMENT_FEE;
            FETCH cur_APPOINTMENT_FEE INTO Op_Appointment_Fee;
            CLOSE cur_APPOINTMENT_FEE;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
                RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_APPOINTMENT_FEE.Proc_Get_APPOINTMENT_FEE]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_APPOINTMENT_FEE;


    /* Update Information Procedure */
    PROCEDURE Proc_Update_APPOINTMENT_FEE (IOp_Appointment_Fee IN OUT NOCOPY tyrcAPPOINTMENT_FEE) IS
        /* Declaring variable for update */
            v_updated_record tyrcAPPOINTMENT_FEE;
        BEGIN
				UPDATE APPOINTMENT_FEE
				SET
				    contract_type_id = IOp_Appointment_Fee.contract_type_id,
				    fee_value = IOp_Appointment_Fee.fee_value
				WHERE /*+PCK_APPOINTMENT_FEE.Proc_Update_APPOINTMENT_FEE*/ appointment_fee_id = IOp_Appointment_Fee.appointment_fee_id;    
                Proc_Get_APPOINTMENT_FEE(IOp_Appointment_Fee.appointment_fee_id, v_updated_record);
                IOp_Appointment_Fee := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_APPOINTMENT_FEE;

END PCK_APPOINTMENT_FEE;
