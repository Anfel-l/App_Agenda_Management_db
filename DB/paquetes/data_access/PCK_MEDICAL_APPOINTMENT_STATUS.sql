/*******************************************************************************
Description: Creation script for the package PCK_MEDICAL_APPOINTMENT_STATUS
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE OR REPLACE PACKAGE PCK_MEDICAL_APPOINTMENT_STATUS IS

    /*******************************************************************************
    Description: Creation script for procedure Proc_Insert_MEDICAL_APPOINTMENT_STATUS
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_STATUS(
        Ip_status IN VARCHAR2
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Update_MEDICAL_APPOINTMENT_STATUS
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_STATUS(
        Ip_medical_appointment_status_id IN NUMBER,
        Ip_status IN VARCHAR2
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_All_MEDICAL_APPOINTMENT_STATUS
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_STATUS(
        Op_medical_appointment_status OUT SYS_REFCURSOR
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_MEDICAL_APPOINTMENT_STATUS_BY_ID
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_STATUS_BY_ID(
        Ip_medical_appointment_status_id IN NUMBER,
        Op_medical_appointment_status OUT SYS_REFCURSOR
    );

END PCK_MEDICAL_APPOINTMENT_STATUS;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_APPOINTMENT_STATUS AS

    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT_STATUS(
        Ip_status IN VARCHAR2
    ) IS
    v_medical_appointment_status_id NUMBER; 
    BEGIN
    v_medical_appointment_status_id := SEQ_MEDICAL_APPOINTMENT_STATUS.NEXTVAL;
    INSERT INTO MEDICAL_APPOINTMENT_STATUS(medical_appointment_status_id, status)
    VALUES(v_medical_appointment_status_id, Ip_status);

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Status already exists');
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Insert_MEDICAL_APPOINTMENT_STATUS;

    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT_STATUS(
        Ip_medical_appointment_status_id IN NUMBER,
        Ip_status IN VARCHAR2
    ) IS
    BEGIN
    UPDATE MEDICAL_APPOINTMENT_STATUS
    SET status = Ip_status
    WHERE medical_appointment_status_id = Ip_medical_appointment_status_id;
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Update_MEDICAL_APPOINTMENT_STATUS;

    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT_STATUS(
        Op_medical_appointment_status OUT SYS_REFCURSOR
    ) IS
    BEGIN    
        OPEN Op_medical_appointment_status FOR
        SELECT 
            medical_appointment_status_id, 
            status
        FROM MEDICAL_APPOINTMENT_STATUS;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '||SQLCODE||' - Error - '||SQLERRM);
    END Proc_Get_All_MEDICAL_APPOINTMENT_STATUS;

    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_STATUS_BY_ID(
        Ip_medical_appointment_status_id IN NUMBER,
        Op_medical_appointment_status OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Op_medical_appointment_status FOR
        SELECT /*+ INDEX(ms PK_MEDICAL_STATUS) */
            medical_appointment_status_id, 
            status
        FROM MEDICAL_APPOINTMENT_STATUS ms
        WHERE ms.medical_appointment_status_id = Ip_medical_appointment_status_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '||SQLCODE||' - Error - '||SQLERRM);
    END Proc_Get_MEDICAL_APPOINTMENT_STATUS_BY_ID;
END PCK_MEDICAL_APPOINTMENT_STATUS;
