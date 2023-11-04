CREATE OR REPLACE PACKAGE PCK_DETAIL_ASSIGNMENT IS

    PROCEDURE Proc_Calculate_Cuota(
        Ip_user_id IN NUMBER,
        Op_apppointment_fee_id OUT NOCOPY NUMBER
    );

    PROCEDURE Proc_Validate_Priority(
        Ip_medical_appointment_id IN NUMBER,
        Op_priority_value OUT NOCOPY DECIMAL
    );

    PROCEDURE Proc_Validate_Slot(
        Ip_doctor_id IN NUMBER,
        Ip_priority IN DECIMAL, -- Cambiado a DECIMAL para manejar valores fraccionarios
        Op_slot_time OUT NOCOPY TIMESTAMP
    );

    PROCEDURE Proc_Assign_Appointment(
        Ip_user_id IN NUMBER,
        Ip_medical_appointment_id IN NUMBER,
        Ip_appointment_fee_id IN NUMBER,
        Ip_slot_time IN TIMESTAMP,
        Ip_doctor_id IN NUMBER,
        Op_detail OUT PCK_MEDICAL_APPOINTMENT_DETAIL.tyrcMEDICAL_APPOINTMENT_DETAIL
    );

   
END PCK_DETAIL_ASSIGNMENT;

CREATE OR REPLACE PACKAGE BODY PCK_DETAIL_ASSIGNMENT AS

    -- Check if the user has a contract type
    PROCEDURE Proc_Calculate_Cuota(
        Ip_user_id IN NUMBER,
        Op_apppointment_fee_id OUT NOCOPY NUMBER
    ) IS
        v_user_record PCK_MEDICAL_USER.tyrcMEDICAL_USER;
        v_contract_type_record PCK_CONTRACT_TYPE.tyrcCONTRACT_TYPE;
        v_appointment_fee PCK_APPOINTMENT_FEE.tyrcAPPOINTMENT_FEE;
    BEGIN

        PCK_MEDICAL_USER.Proc_Get_MEDICAL_USER_ID (Ip_user_id, v_user_record);
        PCK_CONTRACT_TYPE.Proc_Get_CONTRACT_TYPE(v_user_record.contract_type_id, v_contract_type_record);
        PCK_APPOINTMENT_FEE.Proc_Get_APPOINTMENT_FEE (v_contract_type_record.contract_type_id, v_appointment_fee);    
        
        Op_apppointment_fee_id := v_appointment_fee.appointment_fee_id;

    EXCEPTION WHEN NO_DATA_FOUND THEN
        Op_apppointment_fee_id := NULL; 
    END Proc_Calculate_Cuota;


    -- Check if the user has a contract type
    PROCEDURE Proc_Validate_Priority(
        Ip_medical_appointment_id IN NUMBER,
        Op_priority_value OUT NOCOPY DECIMAL
    ) IS
        v_medical_appointment_record PCK_MEDICAL_APPOINTMENT.tyrcMEDICAL_APPOINTMENT;
    BEGIN
        PCK_MEDICAL_APPOINTMENT.Proc_Get_Medical_Appointment(Ip_medical_appointment_id, v_medical_appointment_record);  
        Op_priority_value := v_medical_appointment_record.medical_priority;

    EXCEPTION WHEN NO_DATA_FOUND THEN
        Op_priority_value := NULL;
    END Proc_Validate_Priority;



    PROCEDURE Proc_Validate_Slot(
        Ip_doctor_id IN NUMBER,
        Ip_priority IN DECIMAL, -- Cambiado a DECIMAL para manejar valores fraccionarios
        Op_slot_time OUT NOCOPY TIMESTAMP
    ) IS
        -- Variable para almacenar el número de slots a saltar basado en la prioridad.
        v_priority_slots_offset NUMBER;
    BEGIN
        -- Determinar el offset basado en el rango de prioridad.
        IF Ip_priority BETWEEN 3 AND 2 THEN -- Prioridad Alta
            v_priority_slots_offset := 0; -- No saltar ningún slot, tomar el primero
        ELSIF Ip_priority < 2 AND Ip_priority >= 1.5 THEN -- Prioridad Media
            v_priority_slots_offset := 1; -- Saltar 1 slot
        ELSIF Ip_priority < 1.5 AND Ip_priority >= 1 THEN -- Prioridad Baja
            v_priority_slots_offset := 2; -- Saltar 2 slots
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Valor de prioridad no está dentro de los rangos válidos.');
        END IF;

        -- Consultar el slot basado en la prioridad.
        SELECT MIN(start_time)
        INTO Op_slot_time
        FROM (
            SELECT start_time, ROW_NUMBER() OVER (ORDER BY start_time) AS slot_order
            FROM (
                
                SELECT (ds.START_TIME  + (level - 1) * INTERVAL '30' MINUTE) AS start_time
                FROM MED_USER_DBA.DOCTOR_SHIFT ds
                WHERE ds.doctor_id = Ip_doctor_id
                AND ds.shift_date = TRUNC(SYSDATE)
                CONNECT BY (ds.start_time + (level - 1) * INTERVAL '30' MINUTE) < ds.end_time
            )
			WHERE start_time NOT IN (
			    -- Subconsulta que se une con MEDICAL_APPOINTMENT_DETAIL para obtener los horarios de las citas
			    SELECT mad.appointment_time
			    FROM MED_USER_DBA.DOCTOR_AGENDA da
			    JOIN MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL mad ON da.detail_id = mad.detail_id
			    WHERE da.doctor_id = Ip_doctor_id
			    AND TRUNC(mad.appointment_time) = TRUNC(SYSDATE)
			)
        )
        WHERE slot_order = v_priority_slots_offset + 1; 

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            Op_slot_time := NULL; 
    END Proc_Validate_Slot;



    PROCEDURE Proc_Assign_Appointment(
        Ip_user_id IN NUMBER,
        Ip_medical_appointment_id IN NUMBER,
        Ip_appointment_fee_id IN NUMBER,
        Ip_slot_time IN TIMESTAMP,
        Ip_doctor_id IN NUMBER,
        Op_detail OUT PCK_MEDICAL_APPOINTMENT_DETAIL.tyrcMEDICAL_APPOINTMENT_DETAIL
    ) IS
        v_detail PCK_MEDICAL_APPOINTMENT_DETAIL.tyrcMEDICAL_APPOINTMENT_DETAIL;
        v_agenda PCK_DOCTOR_AGENDA.tyrcDOCTOR_AGENDA;
    BEGIN
        v_detail.user_id := Ip_user_id;
        v_detail.medical_appointment_id := Ip_medical_appointment_id;
        v_detail.appointment_fee_id := Ip_appointment_fee_id;
        v_detail.medical_appointment_status_id := 1; -- Confirmado de una vez para efectos prácticos
        v_detail.appointment_time := Ip_slot_time;
        v_detail.doctor_id := Ip_doctor_id;

        -- Saving medical appointment information
        PCK_MEDICAL_APPOINTMENT_DETAIL.Proc_Insert_Medical_Appointment_Detail(v_detail); 

        v_agenda.doctor_id := Ip_doctor_id;
        v_agenda.detail_id := Op_detail.detail_id;

        PCK_DOCTOR_AGENDA.Proc_Insert_Doctor_Agenda(v_agenda); 
    EXCEPTION WHEN OTHERS THEN
        Op_detail := NULL;
    END Proc_Assign_Appointment;

END PCK_DETAIL_ASSIGNMENT;
