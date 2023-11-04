CREATE OR REPLACE PACKAGE PCK_CONTRACT_TYPE IS
    /*******************************************************************************
    Description: Package for data manipulation of the table CONTRACT_TYPE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcCONTRACT_TYPE IS CONTRACT_TYPE%ROWTYPE;
    TYPE tytbCONTRACT_TYPE IS TABLE OF tyrcCONTRACT_TYPE INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table CONTRACT_TYPE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_CONTRACT_TYPE (
        IOp_CONTRACT_TYPE IN OUT NOCOPY tyrcCONTRACT_TYPE
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table CONTRACT_TYPE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_CONTRACT_TYPE (
        Op_CONTRACT_TYPE OUT NOCOPY tytbCONTRACT_TYPE
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table CONTRACT_TYPE by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_CONTRACT_TYPE (
        Ip_Id in NUMBER,
        Op_CONTRACT_TYPE OUT NOCOPY tyrcCONTRACT_TYPE
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table CONTRACT_TYPE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_CONTRACT_TYPE (
        IOp_CONTRACT_TYPE IN OUT NOCOPY tyrcCONTRACT_TYPE
    );

END PCK_CONTRACT_TYPE;

CREATE OR REPLACE PACKAGE BODY PCK_CONTRACT_TYPE AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_CONTRACT_TYPE (IOp_CONTRACT_TYPE IN OUT NOCOPY tyrcCONTRACT_TYPE) IS
        BEGIN

            /* Initialazing values */
            IOp_CONTRACT_TYPE.contract_type_id := SEQ_CONTRACT_TYPE.NEXTVAL;

            /* Inserting a register */
            INSERT INTO CONTRACT_TYPE VALUES /*+PCK_CONTRACT_TYPE*/ IOp_CONTRACT_TYPE;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_CONTRACT_TYPE.Proc_Insert_CONTRACT_TYPE]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_CONTRACT_TYPE;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_CONTRACT_TYPE (Op_CONTRACT_TYPE OUT NOCOPY tytbCONTRACT_TYPE) IS
        CURSOR cur_CONTRACT_TYPE IS
            SELECT
                contract_type_id,
                contract_type_name,
                description,
                contract_type_priority
            FROM CONTRACT_TYPE;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_CONTRACT_TYPE LOOP
                Op_CONTRACT_TYPE(idx) := rec;
                idx := idx + 1;
            END LOOP;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_CONTRACT_TYPE.Proc_Get_CONTRACT_TYPE]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_CONTRACT_TYPE;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_CONTRACT_TYPE (Ip_Id in NUMBER, Op_CONTRACT_TYPE OUT NOCOPY tyrcCONTRACT_TYPE) IS
        CURSOR cur_CONTRACT_TYPE IS
            SELECT
                contract_type_id,
                contract_type_name,
                description,
                contract_type_priority
            FROM CONTRACT_TYPE
            WHERE /*+PCK_CONTRACT_TYPE.Proc_Get_CONTRACT_TYPE*/ contract_type_id = Ip_Id;          
        BEGIN
            OPEN cur_CONTRACT_TYPE;
            FETCH cur_CONTRACT_TYPE INTO Op_CONTRACT_TYPE;
            CLOSE cur_CONTRACT_TYPE;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_CONTRACT_TYPE.Proc_Get_CONTRACT_TYPE]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_CONTRACT_TYPE;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_CONTRACT_TYPE (IOp_CONTRACT_TYPE IN OUT NOCOPY tyrcCONTRACT_TYPE) IS
        /* Declaring variable for update */
            v_updated_record tyrcCONTRACT_TYPE;
        BEGIN
				UPDATE CONTRACT_TYPE
				SET
				    contract_type_name = IOp_CONTRACT_TYPE.contract_type_name,
				    description = IOp_CONTRACT_TYPE.description,
                    contract_type_priority = IOp_CONTRACT_TYPE.contract_type_priority
				WHERE /*+PCK_CONTRACT_TYPE.Proc_Update_CONTRACT_TYPE*/ contract_type_id = IOp_CONTRACT_TYPE.contract_type_id;    
                Proc_Get_CONTRACT_TYPE(IOp_CONTRACT_TYPE.contract_type_id, v_updated_record);
                IOp_CONTRACT_TYPE := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_CONTRACT_TYPE;

END PCK_CONTRACT_TYPE;
