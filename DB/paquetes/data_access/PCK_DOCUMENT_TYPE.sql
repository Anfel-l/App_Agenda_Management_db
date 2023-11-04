CREATE OR REPLACE PACKAGE PCK_DOCUMENT_TYPE IS
    /*******************************************************************************
    Description: Package for data manipulation of the tableDOCUMENT_TYPE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcDOCUMENT_TYPE IS DOCUMENT_TYPE%ROWTYPE;
    TYPE tytbDOCUMENT_TYPE IS TABLE OF tyrcDOCUMENT_TYPE INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table DOCUMENT_TYPE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_DOCUMENT_TYPE (
        IOp_DOCUMENT_TYPE IN OUT NOCOPY tyrcDOCUMENT_TYPE
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table DOCUMENT_TYPE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_DOCUMENT_TYPE (
        Op_DOCUMENT_TYPE OUT NOCOPY tytbDOCUMENT_TYPE
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table DOCUMENT_TYPE by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_DOCUMENT_TYPE (
        Ip_Id in NUMBER,
        Op_DOCUMENT_TYPE OUT NOCOPY tyrcDOCUMENT_TYPE
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table DOCUMENT_TYPE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_DOCUMENT_TYPE (
        IOp_DOCUMENT_TYPE IN OUT NOCOPY tyrcDOCUMENT_TYPE
    );

END PCK_DOCUMENT_TYPE;

CREATE OR REPLACE PACKAGE BODY PCK_DOCUMENT_TYPE AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_DOCUMENT_TYPE (IOp_DOCUMENT_TYPE IN OUT NOCOPY tyrcDOCUMENT_TYPE) IS
        BEGIN

            /* Initialazing values */
            IOp_DOCUMENT_TYPE.document_type_id := SEQ_DOCUMENT_TYPE.NEXTVAL;

            /* Inserting a register */
            INSERT INTO DOCUMENT_TYPE VALUES /*+PCK_DOCUMENT_TYPE*/ IOp_DOCUMENT_TYPE;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_DOCUMENT_TYPE.Proc_Insert_DOCUMENT_TYPE]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);

    END Proc_Insert_DOCUMENT_TYPE;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_DOCUMENT_TYPE (Op_DOCUMENT_TYPE OUT NOCOPY tytbDOCUMENT_TYPE) IS
        CURSOR cur_DOCUMENT_TYPE IS
            SELECT
                document_type_id,
                document_type_abbreviation,
                description
            FROM DOCUMENT_TYPE;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_DOCUMENT_TYPE LOOP
                Op_DOCUMENT_TYPE(idx) := rec;
                idx := idx + 1;
            END LOOP;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCUMENT_TYPE.Proc_Get_DOCUMENT_TYPE]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_DOCUMENT_TYPE;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_DOCUMENT_TYPE (Ip_Id in NUMBER, Op_DOCUMENT_TYPE OUT NOCOPY tyrcDOCUMENT_TYPE) IS
         CURSOR cur_DOCUMENT_TYPE IS
            SELECT
                document_type_id,
                document_type_abbreviation,
                description
            FROM DOCUMENT_TYPE
            WHERE /*+PCK_DOCUMENT_TYPE.Proc_Get_DOCUMENT_TYPE*/ document_type_id = Ip_Id;          
        BEGIN
            OPEN cur_DOCUMENT_TYPE;
            FETCH cur_DOCUMENT_TYPE INTO Op_DOCUMENT_TYPE;
            CLOSE cur_DOCUMENT_TYPE;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCUMENT_TYPE.Proc_Get_DOCUMENT_TYPE]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_DOCUMENT_TYPE;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_DOCUMENT_TYPE (IOp_DOCUMENT_TYPE IN OUT NOCOPY tyrcDOCUMENT_TYPE) IS
        /* Declaring variable for update */
            v_updated_record tyrcDOCUMENT_TYPE;
        BEGIN
				UPDATE DOCUMENT_TYPE
				SET
				    document_type_abbreviation = IOp_DOCUMENT_TYPE.document_type_abbreviation,
				    description = IOp_DOCUMENT_TYPE.description

				WHERE /*+PCK_DOCUMENT_TYPE.Proc_Update_DOCUMENT_TYPE*/ document_type_id = IOp_DOCUMENT_TYPE.document_type_id;    
                Proc_Get_DOCUMENT_TYPE(IOp_DOCUMENT_TYPE.document_type_id, v_updated_record);
                IOp_DOCUMENT_TYPE := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_DOCUMENT_TYPE;

END PCK_DOCUMENT_TYPE;
