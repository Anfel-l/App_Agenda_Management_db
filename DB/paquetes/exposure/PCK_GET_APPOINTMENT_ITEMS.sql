CREATE OR REPLACE PACKAGE PCK_GET_APPOINTMENT_ITEMS IS

    PROCEDURE Proc_Get_All_Sympmtoms(
        Op_symptoms OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_All_Appointment_Type(
        Op_appointment_types OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_All_Medical_Field(
        Op_medical_fields OUT SYS_REFCURSOR
    );

END PCK_GET_APPOINTMENT_ITEMS;

CREATE OR REPLACE PACKAGE BODY PCK_GET_APPOINTMENT_ITEMS AS

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