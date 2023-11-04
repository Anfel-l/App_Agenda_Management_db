CREATE OR REPLACE PACKAGE PCK_DOCTOR_SHIFT IS
    /*******************************************************************************
    Description: Package for data manipulation of the tableDOCTOR_SHIFT
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcDOCTOR_SHIFT IS DOCTOR_SHIFT%ROWTYPE;
    TYPE tytbDOCTOR_SHIFT IS TABLE OF tyrcDOCTOR_SHIFT INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table DOCTOR_SHIFT
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_DOCTOR_SHIFT (
        IOp_DOCTOR_SHIFT IN OUT NOCOPY tyrcDOCTOR_SHIFT
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table DOCTOR_SHIFT
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_DOCTOR_SHIFT (
        Op_DOCTOR_SHIFT OUT NOCOPY tytbDOCTOR_SHIFT
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table DOCTOR_SHIFT by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_DOCTOR_SHIFT (
        Ip_Id in NUMBER,
        Op_DOCTOR_SHIFT OUT NOCOPY tyrcDOCTOR_SHIFT
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table DOCTOR_SHIFT
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_DOCTOR_SHIFT (
        IOp_DOCTOR_SHIFT IN OUT NOCOPY tyrcDOCTOR_SHIFT
    );

END PCK_DOCTOR_SHIFT;

CREATE OR REPLACE PACKAGE BODY PCK_DOCTOR_SHIFT AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_DOCTOR_SHIFT (IOp_DOCTOR_SHIFT IN OUT NOCOPY tyrcDOCTOR_SHIFT) IS
        BEGIN

            /* Initialazing values */
            IOp_DOCTOR_SHIFT.doctor_shift_id := SEQ_DOCTOR_SHIFT.NEXTVAL;

            /* Inserting a register */
            INSERT INTO DOCTOR_SHIFT VALUES /*+PCK_DOCTOR_SHIFT*/ IOp_DOCTOR_SHIFT;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_DOCTOR_SHIFT.Proc_Insert_DOCTOR_SHIFT]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);

    END Proc_Insert_DOCTOR_SHIFT;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_DOCTOR_SHIFT (Op_DOCTOR_SHIFT OUT NOCOPY tytbDOCTOR_SHIFT) IS
        CURSOR cur_DOCTOR_SHIFT IS
            SELECT
                doctor_shift_id,
                doctor_id,
                shift_date,
                start_time,
                end_time
            FROM DOCTOR_SHIFT;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_DOCTOR_SHIFT LOOP
                Op_DOCTOR_SHIFT(idx) := rec;
                idx := idx + 1;
            END LOOP;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCTOR_SHIFT.Proc_Get_DOCTOR_SHIFT]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_DOCTOR_SHIFT;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_DOCTOR_SHIFT (Ip_Id in NUMBER, Op_DOCTOR_SHIFT OUT NOCOPY tyrcDOCTOR_SHIFT) IS
        CURSOR cur_DOCTOR_SHIFT IS
            SELECT
                doctor_shift_id,
                doctor_id,
                shift_date,
                start_time,
                end_time
            FROM DOCTOR_SHIFT
            WHERE /*+PCK_DOCTOR_SHIFT.Proc_Get_DOCTOR_SHIFT*/ doctor_shift_id = Ip_Id;          
        BEGIN
            OPEN cur_DOCTOR_SHIFT;
            FETCH cur_DOCTOR_SHIFT INTO Op_DOCTOR_SHIFT;
            CLOSE cur_DOCTOR_SHIFT;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCTOR_SHIFT.Proc_Get_DOCTOR_SHIFT]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_DOCTOR_SHIFT;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_DOCTOR_SHIFT (IOp_DOCTOR_SHIFT IN OUT NOCOPY tyrcDOCTOR_SHIFT) IS
        /* Declaring variable for update */
            v_updated_record tyrcDOCTOR_SHIFT;
        BEGIN
				UPDATE DOCTOR_SHIFT
				SET
				    doctor_id = IOp_DOCTOR_SHIFT.doctor_id,
				    shift_date = IOp_DOCTOR_SHIFT.shift_date,
				    start_time = IOp_DOCTOR_SHIFT.start_time,
                    end_time = IOp_DOCTOR_SHIFT.end_time
				WHERE /*+PCK_DOCTOR_SHIFT.Proc_Update_DOCTOR_SHIFT*/ doctor_shift_id = IOp_DOCTOR_SHIFT.doctor_shift_id;    
                Proc_Get_DOCTOR_SHIFT(IOp_DOCTOR_SHIFT.doctor_shift_id, v_updated_record);
                IOp_DOCTOR_SHIFT := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_DOCTOR_SHIFT;

END PCK_DOCTOR_SHIFT;
