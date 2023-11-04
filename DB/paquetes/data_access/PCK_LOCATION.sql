CREATE OR REPLACE PACKAGE PCK_LOCATION IS
    /*******************************************************************************
    Description: Package for data manipulation of the table APPOINMENT_FEE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcLOCATION IS LOCATION%ROWTYPE;
    TYPE tytbLOCATION IS TABLE OF tyrcLOCATION INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table LOCATION
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_LOCATION (
        IOp_LOCATION IN OUT NOCOPY tyrcLOCATION
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table LOCATION
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_LOCATION (
        Op_LOCATION OUT NOCOPY tytbLOCATION
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table LOCATION by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_LOCATION (
        Ip_Id in NUMBER,
        Op_LOCATION OUT NOCOPY tyrcLOCATION
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table LOCATION
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_LOCATION (
        IOp_LOCATION IN OUT NOCOPY tyrcLOCATION
    );

END PCK_LOCATION;

CREATE OR REPLACE PACKAGE BODY PCK_LOCATION AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_LOCATION (IOp_LOCATION IN OUT NOCOPY tyrcLOCATION) IS
        BEGIN

            /* Initialazing values */
            IOp_LOCATION.location_id := SEQ_LOCATION.NEXTVAL;

            /* Inserting a register */
            INSERT INTO LOCATION VALUES /*+PCK_LOCATION*/ IOp_LOCATION;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_LOCATION.Proc_Insert_LOCATION]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_LOCATION;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_LOCATION (Op_LOCATION OUT NOCOPY tytbLOCATION) IS
        CURSOR cur_LOCATION IS
            SELECT
                location_id,
                location_name
            FROM LOCATION;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_LOCATION LOOP
                Op_LOCATION(idx) := rec;
                idx := idx + 1;
            END LOOP;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_LOCATION.Proc_Get_LOCATION]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_LOCATION;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_LOCATION (Ip_Id in NUMBER, Op_LOCATION OUT NOCOPY tyrcLOCATION) IS
        CURSOR cur_LOCATION IS
            SELECT
                location_id,
                location_name
            FROM LOCATION
            WHERE /*+PCK_LOCATION.Proc_Get_LOCATION*/ location_id = Ip_Id;          
        BEGIN
            OPEN cur_LOCATION;
            FETCH cur_LOCATION INTO Op_LOCATION;
            CLOSE cur_LOCATION;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_LOCATION.Proc_Get_LOCATION]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_LOCATION;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_LOCATION (IOp_LOCATION IN OUT NOCOPY tyrcLOCATION) IS
        /* Declaring variable for update */
            v_updated_record tyrcLOCATION;
        BEGIN
				UPDATE LOCATION
				SET
				    location_name = IOp_LOCATION.location_name
				WHERE /*+PCK_LOCATION.Proc_Update_LOCATION*/ location_id = IOp_LOCATION.location_id;    
                Proc_Get_LOCATION(IOp_LOCATION.location_id, v_updated_record);
                IOp_LOCATION := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_LOCATION;

END PCK_LOCATION;
