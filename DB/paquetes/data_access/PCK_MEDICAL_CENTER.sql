CREATE OR REPLACE PACKAGE PCK_MEDICAL_CENTER IS
    /*******************************************************************************
    Description: Package for data manipulation of the tableMEDICAL_CENTER
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcMEDICAL_CENTER IS MEDICAL_CENTER%ROWTYPE;
    TYPE tytbMEDICAL_CENTER IS TABLE OF tyrcMEDICAL_CENTER INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table MEDICAL_CENTER
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_MEDICAL_CENTER (
        IOp_MEDICAL_CENTER IN OUT NOCOPY tyrcMEDICAL_CENTER
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table MEDICAL_CENTER
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_MEDICAL_CENTER (
        Op_MEDICAL_CENTER OUT NOCOPY tytbMEDICAL_CENTER
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table MEDICAL_CENTER by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_MEDICAL_CENTER (
        Ip_Id in NUMBER,
        Op_MEDICAL_CENTER OUT NOCOPY tyrcMEDICAL_CENTER
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table MEDICAL_CENTER
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_MEDICAL_CENTER (
        IOp_MEDICAL_CENTER IN OUT NOCOPY tyrcMEDICAL_CENTER
    );



    PROCEDURE Proc_Get_MEDICAL_CENTER_By_Location (
        Ip_Location_Id IN NUMBER,
        Op_MEDICAL_CENTERS OUT NOCOPY tytbMEDICAL_CENTER
    );


END PCK_MEDICAL_CENTER;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_CENTER AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_MEDICAL_CENTER (IOp_MEDICAL_CENTER IN OUT NOCOPY tyrcMEDICAL_CENTER) IS
        BEGIN

            /* Initialazing values */
            IOp_MEDICAL_CENTER.medical_center_id := SEQ_MEDICAL_CENTER.NEXTVAL;

            /* Inserting a register */
            INSERT INTO MEDICAL_CENTER VALUES /*+PCK_MEDICAL_CENTER*/ IOp_MEDICAL_CENTER;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_MEDICAL_CENTER.Proc_Insert_MEDICAL_CENTER]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_MEDICAL_CENTER;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_MEDICAL_CENTER (Op_MEDICAL_CENTER OUT NOCOPY tytbMEDICAL_CENTER) IS
        CURSOR cur_MEDICAL_CENTER IS
            SELECT
                medical_center_id,
                medical_center_name,
                location_id
            FROM MEDICAL_CENTER;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_MEDICAL_CENTER LOOP
                Op_MEDICAL_CENTER(idx) := rec;
                idx := idx + 1;
            END LOOP;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_CENTER.Proc_Get_MEDICAL_CENTER]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_MEDICAL_CENTER;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_MEDICAL_CENTER (Ip_Id in NUMBER, Op_MEDICAL_CENTER OUT NOCOPY tyrcMEDICAL_CENTER) IS
        CURSOR cur_MEDICAL_CENTER IS
            SELECT
                medical_center_id,
                medical_center_name,
                location_id
            FROM MEDICAL_CENTER
            WHERE /*+PCK_MEDICAL_CENTER.Proc_Get_MEDICAL_CENTER*/ medical_center_id = Ip_Id;          
        BEGIN
            OPEN cur_MEDICAL_CENTER;
            FETCH cur_MEDICAL_CENTER INTO Op_MEDICAL_CENTER;
            CLOSE cur_MEDICAL_CENTER;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_CENTER.Proc_Get_MEDICAL_CENTER]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_MEDICAL_CENTER;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_MEDICAL_CENTER (IOp_MEDICAL_CENTER IN OUT NOCOPY tyrcMEDICAL_CENTER) IS
        /* Declaring variable for update */
            v_updated_record tyrcMEDICAL_CENTER;
        BEGIN
				UPDATE MEDICAL_CENTER
				SET
				    medical_center_name = IOp_MEDICAL_CENTER.medical_center_name,
				    location_id = IOp_MEDICAL_CENTER.location_id
				WHERE /*+PCK_MEDICAL_CENTER.Proc_Update_MEDICAL_CENTER*/ medical_center_id = IOp_MEDICAL_CENTER.medical_center_id;    
                Proc_Get_MEDICAL_CENTER(IOp_MEDICAL_CENTER.medical_center_id, v_updated_record);
                IOp_MEDICAL_CENTER := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Update_MEDICAL_CENTER;


    PROCEDURE Proc_Get_MEDICAL_CENTER_By_Location (Ip_Location_Id IN NUMBER, Op_MEDICAL_CENTERS OUT NOCOPY tytbMEDICAL_CENTER) IS
        v_idx BINARY_INTEGER := 1;
    BEGIN
        FOR rec IN (SELECT * FROM MEDICAL_CENTER WHERE location_id = Ip_Location_Id) LOOP
            Op_MEDICAL_CENTERS(v_idx) := rec;
            v_idx := v_idx + 1;
        END LOOP;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_CENTER.Proc_Get_MEDICAL_CENTER_By_Location]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_MEDICAL_CENTER_By_Location;

END PCK_MEDICAL_CENTER;
