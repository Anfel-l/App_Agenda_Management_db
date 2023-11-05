CREATE OR REPLACE PACKAGE PCK_APPOINTMENT_DETAILS IS

    PROCEDURE Proc_Enter_Appointment_Details(
        -- Medical Appointment
        Ip_User_Id IN NUMBER,
        Ip_MedicalAppointmentTypeId IN NUMBER,
        Ip_Medical_fieldId IN NUMBER,
        Ip_SymptomId IN NUMBER,
        Op_AppointmentId OUT NUMBER,
        Op_Result OUT VARCHAR2
    );

    PROCEDURE Proc_Calculate_Priority(
        Ip_ContractTypeId IN NUMBER,
        Ip_SymptomId IN NUMBER,
        Op_Priority OUT NUMBER
    );

END PCK_APPOINTMENT_DETAILS;


CREATE OR REPLACE PACKAGE BODY PCK_APPOINTMENT_DETAILS IS

    PROCEDURE Proc_Calculate_Priority(
        Ip_ContractTypeId IN NUMBER,
        Ip_SymptomId IN NUMBER,
        Op_Priority OUT NUMBER
    ) IS
        v_contract_type_record SYS_REFCURSOR;
        v_symptom_record SYS_REFCURSOR;
    BEGIN
        -- Get the contract type details
        PCK_CONTRACT_TYPE.Proc_Get_CONTRACT_TYPE(Ip_ContractTypeId, v_contract_type_record);

        -- Get the symptom details
        PCK_SYMPTOM.Proc_Get_SYMPTOM(Ip_SymptomId, v_symptom_record);

        -- Calculate the priority
        Op_Priority := (0.6 * v_symptom_record.SYMPTOM_priority) + (0.4 * v_contract_type_record.contract_type_priority);

    EXCEPTION
        WHEN OTHERS THEN
            Op_Priority := NULL;
    END Proc_Calculate_Priority;


    PROCEDURE Proc_Enter_Appointment_Details(
        -- Medical Appointment
        Ip_User_Id IN NUMBER,
        Ip_MedicalAppointmentTypeId IN NUMBER,
        Ip_Medical_fieldId IN NUMBER,
        Ip_SymptomId IN NUMBER,
        Op_AppointmentId OUT NUMBER,
        Op_Result OUT VARCHAR2
    ) IS
        v_appointment_record PCK_MEDICAL_APPOINTMENT.tyrcMEDICAL_APPOINTMENT;
        v_contract_type_record PCK_CONTRACT_TYPE.tyrcCONTRACT_TYPE;
        v_user_record PCK_MEDICAL_USER.tyrcMEDICAL_USER;

        v_priority_value DECIMAL;
    BEGIN

        -- Get the user details
        PCK_MEDICAL_USER.Proc_Get_MEDICAL_USER_ID(Ip_User_Id, v_user_record);

        -- Calculate the priority
        Proc_Calculate_Priority(v_user_record.contract_type_id, Ip_SymptomId, v_priority_value);

        -- Initialize the appointment details
        v_appointment_record.medical_appointment_type_id := Ip_MedicalAppointmentTypeId;
        v_appointment_record.symptom_id := Ip_SymptomId;
        v_appointment_record.medical_priority := v_priority_value;
        v_appointment_record.medical_field_id := Ip_Medical_fieldId;

        -- Insert the appointment details using the PCK_MEDICAL_APPOINTMENT package
        PCK_MEDICAL_APPOINTMENT.Proc_Insert_MEDICAL_APPOINTMENT(v_appointment_record);

        -- Return the generated appointment ID and result message
        Op_AppointmentId := v_appointment_record.medical_appointment_id;
        Op_Result := 'Appointment Details Entered Successfully';

    EXCEPTION
        WHEN OTHERS THEN
            Op_Result := 'Error during entering appointment details';
            Op_AppointmentId := NULL;
    END Proc_Enter_Appointment_Details;

END PCK_APPOINTMENT_DETAILS;
