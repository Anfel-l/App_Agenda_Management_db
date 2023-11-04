CREATE OR REPLACE PACKAGE PCK_MEDICAL_APPOINTMENT_STATUS IS
    /* Data types declaration */

    SUBTYPE tyrcMEDICAL_APPOINTMENT_STATUS IS MEDICAL_APPOINTMENT_STATUS%ROWTYPE;
    TYPE tytbMEDICAL_APPOINTMENT_STATUS IS TABLE OF tyrcMEDICAL_APPOINTMENT_STATUS INDEX BY BINARY_INTEGER;

    /* Procedures and function declaration */

    /*******************************************************************************
    Description: Procedure that inserts information in the table MEDICAL_APPOINTMENT_STATUS
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_STATUS (
        IOp_MEDICAL_APPOINTMENT_STATUS IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_STATUS
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table MEDICAL_APPOINTMENT_STATUS
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_STATUS (
        Op_MEDICAL_APPOINTMENT_STATUS OUT NOCOPY tytbMEDICAL_APPOINTMENT_STATUS
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table MEDICAL_APPOINTMENT_STATUS by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_STATUS (
        Ip_Id IN NUMBER,
        Op_MEDICAL_APPOINTMENT_STATUS OUT NOCOPY tyrcMEDICAL_APPOINTMENT_STATUS
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table MEDICAL_APPOINTMENT_STATUS
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_STATUS (
        IOp_MEDICAL_APPOINTMENT_STATUS IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_STATUS
    );

END PCK_MEDICAL_APPOINTMENT_STATUS;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_APPOINTMENT_STATUS AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_STATUS (IOp_MEDICAL_APPOINTMENT_STATUS IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_STATUS) IS
    BEGIN
        /* Initializing values */
        IOp_MEDICAL_APPOINTMENT_STATUS.medical_appointment_status_id := SEQ_MEDICAL_APPOINTMENT_STATUS.NEXTVAL;

        /* Inserting a record */
        INSERT INTO MEDICAL_APPOINTMENT_STATUS VALUES IOp_MEDICAL_APPOINTMENT_STATUS;

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_MEDICAL_APPOINTMENT_STATUS.Proc_Insert_MEDICAL_APPOINTMENT_STATUS]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);

    END Proc_Insert_MEDICAL_APPOINTMENT_STATUS;


    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_STATUS (Op_MEDICAL_APPOINTMENT_STATUS OUT NOCOPY tytbMEDICAL_APPOINTMENT_STATUS) IS
        CURSOR cur_MEDICAL_APPOINTMENT_STATUS IS
            SELECT medical_appointment_status_id, status
            FROM MEDICAL_APPOINTMENT_STATUS;
        BEGIN
            OPEN cur_MEDICAL_APPOINTMENT_STATUS;
            FETCH cur_MEDICAL_APPOINTMENT_STATUS BULK COLLECT INTO Op_MEDICAL_APPOINTMENT_STATUS;
            CLOSE cur_MEDICAL_APPOINTMENT_STATUS;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
                RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_APPOINTMENT_STATUS.Proc_Get_All_MEDICAL_APPOINTMENT_STATUS]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Get_All_MEDICAL_APPOINTMENT_STATUS;


    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_STATUS (Ip_Id IN NUMBER,Op_MEDICAL_APPOINTMENT_STATUS OUT NOCOPY tyrcMEDICAL_APPOINTMENT_STATUS) IS
        CURSOR cur_MEDICAL_APPOINTMENT_STATUS IS
            SELECT medical_appointment_status_id, status
            FROM MEDICAL_APPOINTMENT_STATUS
            WHERE medical_appointment_status_id = Ip_Id;
        BEGIN
            OPEN cur_MEDICAL_APPOINTMENT_STATUS;
            FETCH cur_MEDICAL_APPOINTMENT_STATUS INTO Op_MEDICAL_APPOINTMENT_STATUS;
            CLOSE cur_MEDICAL_APPOINTMENT_STATUS;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
                RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_APPOINTMENT_STATUS.Proc_Get_MEDICAL_APPOINTMENT_STATUS]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_MEDICAL_APPOINTMENT_STATUS;


    /* Update Information Procedure */
    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_STATUS (IOp_MEDICAL_APPOINTMENT_STATUS IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT_STATUS) IS
        /* Declare a variable for the updated record */
        v_updated_record tyrcMEDICAL_APPOINTMENT_STATUS;
    BEGIN
        UPDATE MEDICAL_APPOINTMENT_STATUS
        SET status = IOp_MEDICAL_APPOINTMENT_STATUS.status
        WHERE medical_appointment_status_id = IOp_MEDICAL_APPOINTMENT_STATUS.medical_appointment_status_id;

        /* Fetch the updated record */
        Proc_Get_MEDICAL_APPOINTMENT_STATUS(IOp_MEDICAL_APPOINTMENT_STATUS.medical_appointment_status_id, v_updated_record);
        IOp_MEDICAL_APPOINTMENT_STATUS := v_updated_record;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_MEDICAL_APPOINTMENT_STATUS;

END PCK_MEDICAL_APPOINTMENT_STATUS;
