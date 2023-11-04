CREATE OR REPLACE PACKAGE PCK_DOCTOR IS
    /*******************************************************************************
    Description: Package for data manipulation of the tableDOCTOR
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcDOCTOR IS DOCTOR%ROWTYPE;
    TYPE tytbDOCTOR IS TABLE OF tyrcDOCTOR INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table DOCTOR
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_DOCTOR (
        IOp_DOCTOR IN OUT NOCOPY tyrcDOCTOR
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table DOCTOR
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_DOCTOR (
        Op_DOCTOR OUT NOCOPY tytbDOCTOR
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table DOCTOR by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_DOCTOR (
        Ip_Id in NUMBER,
        Op_DOCTOR OUT NOCOPY tyrcDOCTOR
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table DOCTOR
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_DOCTOR (
        IOp_DOCTOR IN OUT NOCOPY tyrcDOCTOR
    );

END PCK_DOCTOR;

CREATE OR REPLACE PACKAGE BODY PCK_DOCTOR AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_DOCTOR (IOp_DOCTOR IN OUT NOCOPY tyrcDOCTOR) IS
        BEGIN

            /* Initialazing values */
            IOp_DOCTOR.doctor_id := SEQ_DOCTOR.NEXTVAL;

            /* Inserting a register */
            INSERT INTO DOCTOR VALUES /*+PCK_DOCTOR*/ IOp_DOCTOR;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_DOCTOR.Proc_Insert_DOCTOR]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);

    END Proc_Insert_DOCTOR;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_DOCTOR (Op_DOCTOR OUT NOCOPY tytbDOCTOR) IS
        CURSOR cur_DOCTOR IS
            SELECT
                doctor_id,
                first_name,
                second_name,
                last_name,
                medical_field_id,
                medical_center_id
            FROM DOCTOR;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_DOCTOR LOOP
                Op_DOCTOR(idx) := rec;
                idx := idx + 1;
            END LOOP;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCTOR.Proc_Get_DOCTOR]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_DOCTOR;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_DOCTOR (Ip_Id in NUMBER, Op_DOCTOR OUT NOCOPY tyrcDOCTOR) IS
        CURSOR cur_DOCTOR IS
            SELECT
                doctor_id,
                first_name,
                second_name,
                last_name,
                medical_field_id,
                medical_center_id
            FROM DOCTOR
            WHERE /*+PCK_DOCTOR.Proc_Get_DOCTOR*/ doctor_id = Ip_Id;          
        BEGIN
            OPEN cur_DOCTOR;
            FETCH cur_DOCTOR INTO Op_DOCTOR;
            CLOSE cur_DOCTOR;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCTOR.Proc_Get_DOCTOR]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_DOCTOR;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_DOCTOR (IOp_DOCTOR IN OUT NOCOPY tyrcDOCTOR) IS
        /* Declaring variable for update */
            v_updated_record tyrcDOCTOR;
        BEGIN
				UPDATE DOCTOR
				SET
				    first_name = IOp_DOCTOR.first_name,
				    second_name = IOp_DOCTOR.second_name,
                    last_name = IOp_DOCTOR.last_name,
                    medical_field_id= IOp_DOCTOR.medical_field_id,
                    medical_center_id = IOp_DOCTOR.medical_center_id
				WHERE /*+PCK_DOCTOR.Proc_Update_DOCTOR*/ doctor_id = IOp_DOCTOR.doctor_id;    
                Proc_Get_DOCTOR(IOp_DOCTOR.doctor_id, v_updated_record);
                IOp_DOCTOR := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_DOCTOR;

END PCK_DOCTOR;
