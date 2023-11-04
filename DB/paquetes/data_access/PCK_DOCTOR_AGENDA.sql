CREATE OR REPLACE PACKAGE PCK_DOCTOR_AGENDA IS
    /*******************************************************************************
    Description: Package for data manipulation of the tableDOCTOR_AGENDA
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcDOCTOR_AGENDA IS DOCTOR_AGENDA%ROWTYPE;
    TYPE tytbDOCTOR_AGENDA IS TABLE OF tyrcDOCTOR_AGENDA INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table DOCTOR_AGENDA
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_DOCTOR_AGENDA (
        IOp_DOCTOR_AGENDA IN OUT NOCOPY tyrcDOCTOR_AGENDA
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table DOCTOR_AGENDA
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_DOCTOR_AGENDA (
        Op_DOCTOR_AGENDA OUT NOCOPY tytbDOCTOR_AGENDA
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table DOCTOR_AGENDA by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_DOCTOR_AGENDA (
        Ip_Id in NUMBER,
        Op_DOCTOR_AGENDA OUT NOCOPY tyrcDOCTOR_AGENDA
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table DOCTOR_AGENDA
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_DOCTOR_AGENDA (
        IOp_DOCTOR_AGENDA IN OUT NOCOPY tyrcDOCTOR_AGENDA
    );

END PCK_DOCTOR_AGENDA;

CREATE OR REPLACE PACKAGE BODY PCK_DOCTOR_AGENDA AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_DOCTOR_AGENDA (IOp_DOCTOR_AGENDA IN OUT NOCOPY tyrcDOCTOR_AGENDA) IS
        BEGIN

            /* Initialazing values */
            IOp_DOCTOR_AGENDA.doctor_agenda_id := SEQ_DOCTOR_AGENDA.NEXTVAL;

            /* Inserting a register */
            INSERT INTO DOCTOR_AGENDA VALUES /*+PCK_DOCTOR_AGENDA*/ IOp_DOCTOR_AGENDA;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_DOCTOR_AGENDA.Proc_Insert_DOCTOR_AGENDA]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_DOCTOR_AGENDA;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_DOCTOR_AGENDA (Op_DOCTOR_AGENDA OUT NOCOPY tytbDOCTOR_AGENDA) IS
        CURSOR cur_DOCTOR_AGENDA IS
            SELECT
                doctor_agenda_id,
                doctor_id,
                detail_id
            FROM DOCTOR_AGENDA;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_DOCTOR_AGENDA LOOP
                Op_DOCTOR_AGENDA(idx) := rec;
                idx := idx + 1;
            END LOOP;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCTOR_AGENDA.Proc_Get_DOCTOR_AGENDA]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_DOCTOR_AGENDA;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_DOCTOR_AGENDA (Ip_Id in NUMBER, Op_DOCTOR_AGENDA OUT NOCOPY tyrcDOCTOR_AGENDA) IS
        CURSOR cur_DOCTOR_AGENDA IS
            SELECT
                doctor_agenda_id,
                doctor_id,
                detail_id
            FROM DOCTOR_AGENDA
            WHERE /*+PCK_DOCTOR_AGENDA.Proc_Get_DOCTOR_AGENDA*/ doctor_agenda_id = Ip_Id;          
        BEGIN
            OPEN cur_DOCTOR_AGENDA;
            FETCH cur_DOCTOR_AGENDA INTO Op_DOCTOR_AGENDA;
            CLOSE cur_DOCTOR_AGENDA;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCTOR_AGENDA.Proc_Get_DOCTOR_AGENDA]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_DOCTOR_AGENDA;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_DOCTOR_AGENDA (IOp_DOCTOR_AGENDA IN OUT NOCOPY tyrcDOCTOR_AGENDA) IS
        /* Declaring variable for update */
            v_updated_record tyrcDOCTOR_AGENDA;
        BEGIN
				UPDATE DOCTOR_AGENDA
				SET
				    doctor_id = IOp_DOCTOR_AGENDA.doctor_id,
				    detail_id = IOp_DOCTOR_AGENDA.detail_id
				WHERE /*+PCK_DOCTOR_AGENDA.Proc_Update_DOCTOR_AGENDA*/ DOCTOR_AGENDA_id = IOp_DOCTOR_AGENDA.doctor_agenda_id;    
                Proc_Get_DOCTOR_AGENDA(IOp_DOCTOR_AGENDA.doctor_agenda_id, v_updated_record);
                IOp_DOCTOR_AGENDA := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_DOCTOR_AGENDA;

END PCK_DOCTOR_AGENDA;

