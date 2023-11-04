CREATE OR REPLACE PACKAGE PCK_MEDICAL_FIELD IS
    /*******************************************************************************
    Description: Package for data manipulation of the tableMEDICAL_FIELD
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcMEDICAL_FIELD IS MEDICAL_FIELD%ROWTYPE;
    TYPE tytbMEDICAL_FIELD IS TABLE OF tyrcMEDICAL_FIELD INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table MEDICAL_FIELD
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_MEDICAL_FIELD (
        IOp_MEDICAL_FIELD IN OUT NOCOPY tyrcMEDICAL_FIELD
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table MEDICAL_FIELD
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_MEDICAL_FIELD (
        Op_MEDICAL_FIELD OUT NOCOPY tytbMEDICAL_FIELD
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table MEDICAL_FIELD by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_MEDICAL_FIELD (
        Ip_Id in NUMBER,
        Op_MEDICAL_FIELD OUT NOCOPY tyrcMEDICAL_FIELD
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table MEDICAL_FIELD
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_MEDICAL_FIELD (
        IOp_MEDICAL_FIELD IN OUT NOCOPY tyrcMEDICAL_FIELD
    );

END PCK_MEDICAL_FIELD;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_FIELD AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_MEDICAL_FIELD (IOp_MEDICAL_FIELD IN OUT NOCOPY tyrcMEDICAL_FIELD) IS
        BEGIN

            /* Initialazing values */
            IOp_MEDICAL_FIELD.medical_field_id := SEQ_MEDICAL_FIELD.NEXTVAL;

            /* Inserting a register */
            INSERT INTO MEDICAL_FIELD VALUES /*+PCK_MEDICAL_FIELD*/ IOp_MEDICAL_FIELD;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_MEDICAL_FIELD.Proc_Insert_MEDICAL_FIELD]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_MEDICAL_FIELD;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_MEDICAL_FIELD (Op_MEDICAL_FIELD OUT NOCOPY tytbMEDICAL_FIELD) IS
        CURSOR cur_MEDICAL_FIELD IS
            SELECT
                medical_field_id,
                medical_field_name,
                description
            FROM MEDICAL_FIELD;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_MEDICAL_FIELD LOOP
                Op_MEDICAL_FIELD(idx) := rec;
                idx := idx + 1;
            END LOOP;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_FIELD.Proc_Get_MEDICAL_FIELD]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_MEDICAL_FIELD;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_MEDICAL_FIELD (Ip_Id in NUMBER, Op_MEDICAL_FIELD OUT NOCOPY tyrcMEDICAL_FIELD) IS
        CURSOR cur_MEDICAL_FIELD IS
            SELECT
                medical_field_id,
                medical_field_name,
                description
            FROM MEDICAL_FIELD
            WHERE /*+PCK_MEDICAL_FIELD.Proc_Get_MEDICAL_FIELD*/ medical_field_id = Ip_Id;          
        BEGIN
            OPEN cur_MEDICAL_FIELD;
            FETCH cur_MEDICAL_FIELD INTO Op_MEDICAL_FIELD;
            CLOSE cur_MEDICAL_FIELD;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_FIELD.Proc_Get_MEDICAL_FIELD]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_MEDICAL_FIELD;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_MEDICAL_FIELD (IOp_MEDICAL_FIELD IN OUT NOCOPY tyrcMEDICAL_FIELD) IS
        /* Declaring variable for update */
            v_updated_record tyrcMEDICAL_FIELD;
        BEGIN
				UPDATE MEDICAL_FIELD
				SET
				    medical_field_name = IOp_MEDICAL_FIELD.medical_field_name,
				    description = IOp_MEDICAL_FIELD.description
				WHERE /*+PCK_MEDICAL_FIELD.Proc_Update_MEDICAL_FIELD*/ medical_field_id= IOp_MEDICAL_FIELD.medical_field_id;    
                Proc_Get_MEDICAL_FIELD(IOp_MEDICAL_FIELD.medical_field_id, v_updated_record);
                IOp_MEDICAL_FIELD := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_MEDICAL_FIELD;

END PCK_MEDICAL_FIELD;
