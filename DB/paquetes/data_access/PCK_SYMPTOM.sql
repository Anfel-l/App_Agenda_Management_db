CREATE OR REPLACE PACKAGE PCK_SYMPTOM IS
    /*******************************************************************************
    Description: Package for data manipulation of the table SYMPTOM
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcSYMPTOM IS SYMPTOM%ROWTYPE;
    TYPE tytbSYMPTOM IS TABLE OF tyrcSYMPTOM INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table SYMPTOM
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_SYMPTOM (
        IOp_SYMPTOM IN OUT NOCOPY tyrcSYMPTOM
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table SYMPTOM
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_SYMPTOM (
        Op_SYMPTOM OUT NOCOPY tytbSYMPTOM
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table SYMPTOM by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_SYMPTOM (
        Ip_Id in NUMBER,
        Op_SYMPTOM OUT NOCOPY tyrcSYMPTOM
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table SYMPTOM
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_SYMPTOM (
        IOp_SYMPTOM IN OUT NOCOPY tyrcSYMPTOM
    );

END PCK_SYMPTOM;

CREATE OR REPLACE PACKAGE BODY PCK_SYMPTOM AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_SYMPTOM (IOp_SYMPTOM IN OUT NOCOPY tyrcSYMPTOM) IS
        BEGIN

            /* Initialazing values */
            IOp_SYMPTOM.SYMPTOM_id := SEQ_SYMPTOM.NEXTVAL;

            /* Inserting a register */
            INSERT INTO SYMPTOM VALUES /*+PCK_SYMPTOM*/ IOp_SYMPTOM;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_SYMPTOM.Proc_Insert_SYMPTOM]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_SYMPTOM;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_SYMPTOM (Op_SYMPTOM OUT NOCOPY tytbSYMPTOM) IS
        CURSOR cur_SYMPTOM IS
            SELECT
                SYMPTOM_id,
                SYMPTOM_name,
                SYMPTOM_priority
            FROM SYMPTOM;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_SYMPTOM LOOP
                Op_SYMPTOM(idx) := rec;
                idx := idx + 1;
            END LOOP;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_SYMPTOM.Proc_Get_SYMPTOM]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_SYMPTOM;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_SYMPTOM (Ip_Id in NUMBER, Op_SYMPTOM OUT NOCOPY tyrcSYMPTOM) IS
        CURSOR cur_SYMPTOM IS
            SELECT
                SYMPTOM_id,
                SYMPTOM_name,
                SYMPTOM_priority
            FROM SYMPTOM
            WHERE /*+PCK_SYMPTOM.Proc_Get_SYMPTOM*/ SYMPTOM_id = Ip_Id;          
        BEGIN
            OPEN cur_SYMPTOM;
            FETCH cur_SYMPTOM INTO Op_SYMPTOM;
            CLOSE cur_SYMPTOM;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_SYMPTOM.Proc_Get_SYMPTOM]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_SYMPTOM;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_SYMPTOM (IOp_SYMPTOM IN OUT NOCOPY tyrcSYMPTOM) IS
        /* Declaring variable for update */
            v_updated_record tyrcSYMPTOM;
        BEGIN
				UPDATE SYMPTOM
				SET
				    SYMPTOM_name = IOp_SYMPTOM.SYMPTOM_name,
				    SYMPTOM_priority = IOp_SYMPTOM.SYMPTOM_priority
				WHERE /*+PCK_SYMPTOM.Proc_Update_SYMPTOM*/ SYMPTOM_id = IOp_SYMPTOM.SYMPTOM_id;    
                Proc_Get_SYMPTOM(IOp_SYMPTOM.SYMPTOM_id, v_updated_record);
                IOp_SYMPTOM := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_SYMPTOM;

END PCK_SYMPTOM;
