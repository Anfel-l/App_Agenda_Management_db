CREATE OR REPLACE PACKAGE PCK_APPOINTMENT_DETAILS IS

    PROCEDURE Proc_Enter_Appointment_Details(
        Ip_User_Id IN NUMBER,
        Ip_MedicalAppointmentTypeId IN NUMBER,
        Ip_Medical_fieldId IN NUMBER,
        Ip_SymptomId IN NUMBER,
        Op_AppointmentId OUT NUMBER
    );

    PROCEDURE Proc_Calculate_Priority(
        Ip_ContractTypeId IN NUMBER,
        Ip_SymptomId IN NUMBER,
        Op_Priority OUT DECIMAL
    );

END PCK_APPOINTMENT_DETAILS;


CREATE OR REPLACE PACKAGE BODY PCK_APPOINTMENT_DETAILS IS

    PROCEDURE Proc_Calculate_Priority(
        Ip_ContractTypeId IN NUMBER,
        Ip_SymptomId IN NUMBER,
        Op_Priority OUT DECIMAL
    ) IS
        v_contract_type_cursor SYS_REFCURSOR;
        v_symptom_cursor SYS_REFCURSOR;

        v_contract_type_record CONTRACT_TYPE%ROWTYPE;
        v_symptom_record SYMPTOM%ROWTYPE;
    BEGIN
        PCK_CONTRACT_TYPE.Proc_Get_CONTRACT_TYPE_BY_ID(Ip_ContractTypeId, v_contract_type_cursor);
        PCK_SYMPTOM.Proc_Get_SYMPTOM_BY_ID(Ip_SymptomId, v_symptom_cursor);

        FETCH v_contract_type_cursor INTO v_contract_type_record;
        FETCH v_symptom_cursor INTO v_symptom_record;
        
        Op_Priority := (0.6 * v_symptom_record.SYMPTOM_priority) + (0.4 * v_contract_type_record.contract_type_priority);

    EXCEPTION
        WHEN OTHERS THEN
            Op_Priority := NULL;
    END Proc_Calculate_Priority;


    PROCEDURE Proc_Enter_Appointment_Details(
        Ip_User_Id IN NUMBER,
        Ip_MedicalAppointmentTypeId IN NUMBER,
        Ip_Medical_fieldId IN NUMBER,
        Ip_SymptomId IN NUMBER,
        Op_AppointmentId OUT NUMBER
    ) IS
        v_appointment_record MEDICAL_APPOINTMENT%ROWTYPE;
        v_user_record MEDICAL_USER%ROWTYPE;
        v_user_cursor SYS_REFCURSOR;
        v_priority_value DECIMAL;
    BEGIN

        PCK_MEDICAL_USER.Proc_Get_MEDICAL_USER_BY_ID(Ip_User_Id, v_user_cursor);
        FETCH v_user_cursor INTO v_user_record;

        Proc_Calculate_Priority(v_user_record.contract_type_id, Ip_SymptomId, v_priority_value);

        v_appointment_record.medical_appointment_type_id := Ip_MedicalAppointmentTypeId;
        v_appointment_record.symptom_id := Ip_SymptomId;
        v_appointment_record.medical_priority := v_priority_value;
        v_appointment_record.medical_field_id := Ip_Medical_fieldId;

        PCK_MEDICAL_APPOINTMENT.Proc_Insert_MEDICAL_APPOINTMENT(
            v_appointment_record.medical_appointment_type_id,
            v_appointment_record.symptom_id,
            v_appointment_record.medical_priority,
            v_appointment_record.medical_field_id
            );

        Op_AppointmentId := v_appointment_record.medical_appointment_id;

    EXCEPTION
        WHEN OTHERS THEN
            Op_AppointmentId := NULL;
    END Proc_Enter_Appointment_Details;

END PCK_APPOINTMENT_DETAILS;
