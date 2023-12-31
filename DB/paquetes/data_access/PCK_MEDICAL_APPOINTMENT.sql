/*******************************************************************************
Description: Creation script for the package PCK_MEDICAL_APPOINTMENT
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE OR REPLACE PACKAGE PCK_MEDICAL_APPOINTMENT IS
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT(
        Ip_medical_appointment_type_id IN NUMBER,
        Ip_symptom_id IN NUMBER,
        Ip_medical_priority IN DECIMAL,
        Ip_medical_field_id IN NUMBER,
        Op_appointment_id OUT NUMBER

    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Update_MEDICAL_APPOINTMENT
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT(
        Ip_medical_appointment_id IN NUMBER,
        Ip_medical_appointment_type_id IN NUMBER,
        Ip_symptom_id IN NUMBER,
        Ip_medical_priority IN DECIMAL,
        Ip_medical_field_id IN NUMBER
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_All_MEDICAL_APPOINTMENT
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT(
        Op_medical_appointment OUT SYS_REFCURSOR
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_MEDICAL_APPOINTMENT_BY_ID
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_BY_ID(
        Ip_medical_appointment_id IN NUMBER,
        Op_medical_appointment OUT SYS_REFCURSOR
    );

END PCK_MEDICAL_APPOINTMENT;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_APPOINTMENT AS
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT(
        Ip_medical_appointment_type_id IN NUMBER,
        Ip_symptom_id IN NUMBER,
        Ip_medical_priority IN DECIMAL,
        Ip_medical_field_id IN NUMBER,
        Op_appointment_id OUT NUMBER

    )IS
    v_medical_appointment_id NUMBER;
    BEGIN
    v_medical_appointment_id := SEQ_MEDICAL_APPOINTMENT.NEXTVAL;

    INSERT INTO MEDICAL_APPOINTMENT(
        medical_appointment_id,
        medical_appointment_type_id,
        symptom_id,
        medical_priority,
        medical_field_id)

    VALUES(v_medical_appointment_id,
        Ip_medical_appointment_type_id,
        Ip_symptom_id,
        Ip_medical_priority,
        Ip_medical_field_id);
    Op_appointment_id := v_medical_appointment_id;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Medical appointment already exists' || SQLERRM );
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Insert_MEDICAL_APPOINTMENT;

    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT(
        Ip_medical_appointment_id IN NUMBER,
        Ip_medical_appointment_type_id IN NUMBER,
        Ip_symptom_id IN NUMBER,
        Ip_medical_priority IN DECIMAL,
        Ip_medical_field_id IN NUMBER
    )IS
    BEGIN
        UPDATE MEDICAL_APPOINTMENT
        SET medical_appointment_type_id = Ip_medical_appointment_type_id,
            symptom_id = Ip_symptom_id,
            medical_priority = Ip_medical_priority,
            medical_field_id = Ip_medical_field_id
        WHERE medical_appointment_id = Ip_medical_appointment_id;
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Update_MEDICAL_APPOINTMENT;

    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT(
        Op_medical_appointment OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_medical_appointment FOR
            SELECT 
                medical_appointment_id,
                medical_appointment_type_id,
                symptom_id,
                medical_priority,
                medical_field_id
            FROM MEDICAL_APPOINTMENT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM); 
    END Proc_Get_All_MEDICAL_APPOINTMENT;

    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT_BY_ID(
        Ip_medical_appointment_id IN NUMBER,
        Op_medical_appointment OUT SYS_REFCURSOR
    )IS
    BEGIN
        OPEN Op_medical_appointment FOR
            SELECT /*+ INDEX(l PK_MEDICAL_APPOINTMENT) */
                medical_appointment_id,
                medical_appointment_type_id,
                symptom_id,
                medical_priority,
                medical_field_id
            FROM MEDICAL_APPOINTMENT ma
            WHERE ma.medical_appointment_id = Ip_medical_appointment_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM); 
    END Proc_Get_MEDICAL_APPOINTMENT_BY_ID;
END PCK_MEDICAL_APPOINTMENT;
