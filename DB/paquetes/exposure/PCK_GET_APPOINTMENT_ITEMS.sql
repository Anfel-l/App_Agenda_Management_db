/*******************************************************************************
Description: Creation script for the package PCK_GET_APPOINTMENT_ITEMS
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE OR REPLACE PACKAGE PCK_GET_APPOINTMENT_ITEMS IS

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_All_Sympmtoms
    which returns all the symptoms registered in the system

    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_Sympmtoms(
        Op_symptoms OUT SYS_REFCURSOR
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_All_Appointment_Type
    which returns all the appointment types registered in the system

    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_Appointment_Type(
        Op_appointment_types OUT SYS_REFCURSOR
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_All_Medical_Field
    which returns all the medical fields registered in the system

    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_Medical_Field(
        Op_medical_fields OUT SYS_REFCURSOR
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_Medical_Center which
    returns the medical center information by id
    
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_Medical_Center(
        Ip_medical_center_id IN NUMBER,
        Op_medical_center OUT SYS_REFCURSOR
    );

END PCK_GET_APPOINTMENT_ITEMS;

CREATE OR REPLACE PACKAGE BODY PCK_GET_APPOINTMENT_ITEMS AS

    PROCEDURE Proc_Get_Medical_Center(
        Ip_medical_center_id IN NUMBER,
        Op_medical_center OUT SYS_REFCURSOR
    ) IS
    BEGIN
        PCK_MEDICAL_CENTER.Proc_Get_MEDICAL_CENTER_BY_ID(Ip_medical_center_id, Op_medical_center);
    EXCEPTION
            WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_Medical_Center;

    PROCEDURE Proc_Get_All_Sympmtoms(
        Op_symptoms OUT SYS_REFCURSOR
    ) IS
    BEGIN
        PCK_SYMPTOM.Proc_Get_All_SYMPTOM(Op_symptoms);
    EXCEPTION
            WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_All_Sympmtoms;

    PROCEDURE Proc_Get_All_Appointment_Type(
        Op_appointment_types OUT SYS_REFCURSOR
    ) IS
    BEGIN
        PCK_MEDICAL_APPOINTMENT_TYPE.Proc_Get_All_MEDICAL_APPOINTMENT_TYPE(Op_appointment_types);
    EXCEPTION
            WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_All_Appointment_Type;

    PROCEDURE Proc_Get_All_Medical_Field(
        Op_medical_fields OUT SYS_REFCURSOR
    ) IS
    BEGIN
        PCK_MEDICAL_FIELD.Proc_Get_All_MEDICAL_FIELD(Op_medical_fields);
    EXCEPTION
            WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_All_Medical_Field;

END PCK_GET_APPOINTMENT_ITEMS;