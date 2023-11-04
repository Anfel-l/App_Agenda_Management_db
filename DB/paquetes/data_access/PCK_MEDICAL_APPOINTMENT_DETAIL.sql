CREATE OR REPLACE PACKAGE PCK_MEDICAL_APPOINTMENT_DETAIL IS
    /*******************************************************************************
    Description: Package for data manipulation of the tableMEDICAL_APPOINTMENT_DETAIL
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcMEDICAL_APPOINTMENT_DETAIL IS MEDICAL_APPOINTMENT_DETAIL%ROWTYPE;
    TYPE tytbMEDICAL_APPOINTMENT_DETAIL IS TABLE OF tyrcMEDICAL_APPOINTMENT_DETAIL INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table MEDICAL_APPOINTMENT_DETAIL
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_DETAIL (
        IOp_MEDICAL_APPOINTMENT_DETAIL IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_DETAIL
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table MEDICAL_APPOINTMENT_DETAIL
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_DETAIL (
        Op_MEDICAL_APPOINTMENT_DETAIL OUT NOCOPY tytbMEDICAL_APPOINTMENT_DETAIL
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table MEDICAL_APPOINTMENT_DETAIL by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_DETAIL (
        Ip_Id in NUMBER,
        Op_MEDICAL_APPOINTMENT_DETAIL OUT NOCOPY tyrcMEDICAL_APPOINTMENT_DETAIL
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table MEDICAL_APPOINTMENT_DETAIL
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_DETAIL (
        IOp_MEDICAL_APPOINTMENT_DETAIL IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_DETAIL
    );

END PCK_MEDICAL_APPOINTMENT_DETAIL;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_APPOINTMENT_DETAIL AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_DETAIL (IOp_MEDICAL_APPOINTMENT_DETAIL IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_DETAIL) IS
        BEGIN

            /* Initialazing values */
            IOp_MEDICAL_APPOINTMENT_DETAIL.detail_id := SEQ_MEDICAL_APPOINTMENT_DETAIL.NEXTVAL;

            /* Inserting a register */
            INSERT INTO MEDICAL_APPOINTMENT_DETAIL VALUES /*+PCK_MEDICAL_APPOINTMENT_DETAIL*/ IOp_MEDICAL_APPOINTMENT_DETAIL;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_MEDICAL_APPOINTMENT_DETAIL.Proc_Insert_MEDICAL_APPOINTMENT_DETAIL]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);

    END Proc_Insert_MEDICAL_APPOINTMENT_DETAIL;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_DETAIL (Op_MEDICAL_APPOINTMENT_DETAIL OUT NOCOPY tytbMEDICAL_APPOINTMENT_DETAIL) IS
		CURSOR cur_MEDICAL_APPOINTMENT_DETAIL IS
		    SELECT
			    detail_id,
			    user_id,
			    medical_appointment_id,
			    appointment_fee_id,
			    medical_appointment_status_id,
			    appointment_time,
			   	doctor_id
		    FROM MEDICAL_APPOINTMENT_DETAIL;
		    idx BINARY_INTEGER := 1;
		BEGIN
		    FOR rec IN cur_MEDICAL_APPOINTMENT_DETAIL LOOP
		        Op_MEDICAL_APPOINTMENT_DETAIL(idx) := rec;
		        idx := idx + 1;
		    END LOOP;


        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_APPOINTMENT_DETAIL.Proc_Get_MEDICAL_APPOINTMENT_DETAIL]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_MEDICAL_APPOINTMENT_DETAIL;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_DETAIL (Ip_Id in NUMBER, Op_MEDICAL_APPOINTMENT_DETAIL OUT NOCOPY tyrcMEDICAL_APPOINTMENT_DETAIL) IS
        CURSOR cur_MEDICAL_APPOINTMENT_DETAIL IS
			SELECT
			    detail_id,
			    user_id,
			    medical_appointment_id,
			    appointment_fee_id,
			    medical_appointment_status_id,
			    appointment_time,
			   	doctor_id
			FROM MEDICAL_APPOINTMENT_DETAIL

            WHERE /*+PCK_MEDICAL_APPOINTMENT_DETAIL.Proc_Get_MEDICAL_APPOINTMENT_DETAIL*/ detail_id = Ip_Id;          
        BEGIN
            OPEN cur_MEDICAL_APPOINTMENT_DETAIL;
            FETCH cur_MEDICAL_APPOINTMENT_DETAIL INTO Op_MEDICAL_APPOINTMENT_DETAIL;
            CLOSE cur_MEDICAL_APPOINTMENT_DETAIL;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_APPOINTMENT_DETAIL.Proc_Get_MEDICAL_APPOINTMENT_DETAIL]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_MEDICAL_APPOINTMENT_DETAIL;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_DETAIL (IOp_MEDICAL_APPOINTMENT_DETAIL IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_DETAIL) IS
        /* Declaring variable for update */
            v_updated_record tyrcMEDICAL_APPOINTMENT_DETAIL;
        BEGIN
				UPDATE MEDICAL_APPOINTMENT_DETAIL
				SET
				    user_id = IOp_MEDICAL_APPOINTMENT_DETAIL.user_id,
				    doctor_id = IOp_MEDICAL_APPOINTMENT_DETAIL.doctor_id,
				    medical_appointment_id = IOp_MEDICAL_APPOINTMENT_DETAIL.medical_appointment_id,
				    appointment_fee_id = IOp_MEDICAL_APPOINTMENT_DETAIL.appointment_fee_id,
				    medical_appointment_status_id = IOp_MEDICAL_APPOINTMENT_DETAIL.medical_appointment_status_id,
				    appointment_time = IOp_MEDICAL_APPOINTMENT_DETAIL.appointment_time

				WHERE /*+PCK_MEDICAL_APPOINTMENT_DETAIL.Proc_Update_MEDICAL_APPOINTMENT_DETAIL*/ detail_id = IOp_MEDICAL_APPOINTMENT_DETAIL.detail_id;    
                Proc_Get_MEDICAL_APPOINTMENT_DETAIL(IOp_MEDICAL_APPOINTMENT_DETAIL.detail_id, v_updated_record);
                IOp_MEDICAL_APPOINTMENT_DETAIL := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_MEDICAL_APPOINTMENT_DETAIL;

END PCK_MEDICAL_APPOINTMENT_DETAIL;
