CREATE OR REPLACE PACKAGE PCK_MEDICAL_APPOINTMENT_TYPE IS
    /*******************************************************************************
    Description: Package for data manipulation of the tableMEDICAL_APPOINTMENT_DETAIL
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcMEDICAL_APPOINTMENT_TYPE IS MEDICAL_APPOINTMENT_TYPE%ROWTYPE;
    TYPE tytbMEDICAL_APPOINTMENT_TYPE IS TABLE OF tyrcMEDICAL_APPOINTMENT_TYPE INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table MEDICAL_APPOINTMENT_TYPE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_TYPE (
        IOp_MEDICAL_APPOINTMENT_TYPE IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_TYPE
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table MEDICAL_APPOINTMENT_TYPE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_TYPE (
        Op_MEDICAL_APPOINTMENT_TYPE OUT NOCOPY tytbMEDICAL_APPOINTMENT_TYPE
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table MEDICAL_APPOINTMENT_TYPE by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_TYPE (
        Ip_Id in NUMBER,
        Op_MEDICAL_APPOINTMENT_TYPE OUT NOCOPY tyrcMEDICAL_APPOINTMENT_TYPE
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table MEDICAL_APPOINTMENT_TYPE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_TYPE (
        IOp_MEDICAL_APPOINTMENT_TYPE IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_TYPE
    );

END PCK_MEDICAL_APPOINTMENT_TYPE;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_APPOINTMENT_TYPE AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_TYPE (IOp_MEDICAL_APPOINTMENT_TYPE IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_TYPE) IS
        BEGIN

            /* Initialazing values */
            IOp_MEDICAL_APPOINTMENT_TYPE.medical_appointment_type_id:= SEQ_MEDICAL_APPOINTMENT_TYPE.NEXTVAL;

            /* Inserting a register */
            INSERT INTO MEDICAL_APPOINTMENT_TYPE VALUES /*+PCK_MEDICAL_APPOINTMENT_TYPE*/ IOp_MEDICAL_APPOINTMENT_TYPE;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_MEDICAL_APPOINTMENT_TYPE.Proc_Insert_MEDICAL_APPOINTMENT_TYPE]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_MEDICAL_APPOINTMENT_TYPE;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_TYPE (Op_MEDICAL_APPOINTMENT_TYPE OUT NOCOPY tytbMEDICAL_APPOINTMENT_TYPE) IS
        CURSOR cur_MEDICAL_APPOINTMENT_TYPE IS
            SELECT
                medical_appointment_type_id,
                medical_appointment_type_name,
                description
            FROM MEDICAL_APPOINTMENT_TYPE;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_MEDICAL_APPOINTMENT_TYPE LOOP
                Op_MEDICAL_APPOINTMENT_TYPE(idx) := rec;
                idx := idx + 1;
            END LOOP;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_APPOINTMENT_TYPE.Proc_Get_MEDICAL_APPOINTMENT_TYPE]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_MEDICAL_APPOINTMENT_TYPE;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_TYPE (Ip_Id in NUMBER, Op_MEDICAL_APPOINTMENT_TYPE OUT NOCOPY tyrcMEDICAL_APPOINTMENT_TYPE) IS
        CURSOR cur_MEDICAL_APPOINTMENT_TYPE IS
            SELECT
                medical_appointment_type_id,
                medical_appointment_type_name,
                description
            FROM MEDICAL_APPOINTMENT_TYPE
            WHERE /*+PCK_MEDICAL_APPOINTMENT_TYPE.Proc_Get_MEDICAL_APPOINTMENT_TYPE*/ medical_appointment_type_id = Ip_Id;          
        BEGIN
            OPEN cur_MEDICAL_APPOINTMENT_TYPE;
            FETCH cur_MEDICAL_APPOINTMENT_TYPE INTO Op_MEDICAL_APPOINTMENT_TYPE;
            CLOSE cur_MEDICAL_APPOINTMENT_TYPE;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_APPOINTMENT_TYPE.Proc_Get_MEDICAL_APPOINTMENT_TYPE]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_MEDICAL_APPOINTMENT_TYPE;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_TYPE (IOp_MEDICAL_APPOINTMENT_TYPE IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_TYPE) IS
        /* Declaring variable for update */
            v_updated_record tyrcMEDICAL_APPOINTMENT_TYPE;
        BEGIN
				UPDATE MEDICAL_APPOINTMENT_TYPE
				SET
				    medical_appointment_type_name = IOp_MEDICAL_APPOINTMENT_TYPE.medical_appointment_type_name,
				    description = IOp_MEDICAL_APPOINTMENT_TYPE.description
                    
				WHERE /*+PCK_APPOINTMENT_FEE.Proc_Update_MEDICAL_APPOINTMENT_TYPE*/ medical_appointment_type_id = IOp_MEDICAL_APPOINTMENT_TYPE.medical_appointment_type_id;    
                Proc_Get_MEDICAL_APPOINTMENT_TYPE(IOp_MEDICAL_APPOINTMENT_TYPE.medical_appointment_type_id, v_updated_record);
                IOp_MEDICAL_APPOINTMENT_TYPE := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_MEDICAL_APPOINTMENT_TYPE;

END PCK_MEDICAL_APPOINTMENT_TYPE;
