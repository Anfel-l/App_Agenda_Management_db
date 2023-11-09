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
        Ip_priority IN DECIMAL,
        Op_slot_time OUT NOCOPY TIMESTAMP 
    );

    PROCEDURE Proc_Assign_Appointment(
        Ip_user_id IN NUMBER,
        Ip_medical_appointment_id IN NUMBER,
        Ip_doctor_id IN NUMBER,
        Op_detail_id OUT NUMBER
    );

   
END PCK_DETAIL_ASSIGNMENT;

CREATE OR REPLACE PACKAGE BODY PCK_DETAIL_ASSIGNMENT AS




	    PROCEDURE Proc_Calculate_Cuota(
	        Ip_user_id IN NUMBER,
	        Op_apppointment_fee_id OUT NOCOPY NUMBER
	    ) IS
	        v_user_cursor SYS_REFCURSOR;
	        v_user_record MEDICAL_USER%ROWTYPE;
	
	        v_contract_type_cursor SYS_REFCURSOR;
	        v_contract_type_record CONTRACT_TYPE%ROWTYPE;
	
	        v_appointment_fee SYS_REFCURSOR;
	        v_appointment_fee_record APPOINTMENT_FEE%ROWTYPE;
	
	    BEGIN
	
	        PCK_MEDICAL_USER.Proc_Get_MEDICAL_USER_BY_ID (Ip_user_id, v_user_cursor);
	        FETCH v_user_cursor INTO v_user_record;
	
	        PCK_CONTRACT_TYPE.Proc_Get_CONTRACT_TYPE_BY_ID(v_user_record.contract_type_id, v_contract_type_cursor);
	        FETCH v_contract_type_cursor INTO v_contract_type_record;
	
	        PCK_APPOINTMENT_FEE.Proc_Get_APPOINTMENT_FEE_BY_CONTRACT_TYPE_ID(v_contract_type_record.contract_type_id, v_appointment_fee);    
	        FETCH v_appointment_fee INTO v_appointment_fee_record;
	
	        Op_apppointment_fee_id := v_appointment_fee_record.appointment_fee_id;
	
	    EXCEPTION WHEN NO_DATA_FOUND THEN
	        Op_apppointment_fee_id := NULL; 
	    END Proc_Calculate_Cuota;
   
       PROCEDURE Proc_Validate_Priority(
	        Ip_medical_appointment_id IN NUMBER,
	        Op_priority_value OUT NOCOPY DECIMAL
	    ) IS
	        v_medical_appointment_cursor SYS_REFCURSOR;
	        v_medical_appointment_record MEDICAL_APPOINTMENT%ROWTYPE;
	    BEGIN
	        PCK_MEDICAL_APPOINTMENT.Proc_Get_MEDICAL_APPOINTMENT_BY_ID(Ip_medical_appointment_id, v_medical_appointment_cursor);
	        FETCH v_medical_appointment_cursor INTO v_medical_appointment_record;
	
	        Op_priority_value := v_medical_appointment_record.medical_priority;
	
	    EXCEPTION WHEN NO_DATA_FOUND THEN
	        Op_priority_value := NULL;
    	END Proc_Validate_Priority;
   
	PROCEDURE Proc_Validate_Slot(
	    Ip_doctor_id IN NUMBER,
	    Ip_priority IN DECIMAL,
	    Op_slot_time OUT NOCOPY TIMESTAMP
	) IS
	
	    TYPE time_range_type IS RECORD (
	        start_time TIMESTAMP,
	        end_time TIMESTAMP
	    );
	    v_time_range time_range_type;
	
	    v_found_slot_count NUMBER := 0;
	
	    v_appointment_count NUMBER;
	
	    v_slot_time TIMESTAMP;
	  
	BEGIN
		
	    Op_slot_time := NULL;
	
	    FOR v_time_range IN (
	        SELECT start_time, end_time
	        FROM MED_USER_DBA.DOCTOR_SHIFT
	        WHERE doctor_id = Ip_doctor_id
	          AND TRUNC(shift_date) = TRUNC(SYSDATE)
	          AND start_time > CURRENT_TIMESTAMP 
	        ORDER BY start_time
	    ) LOOP
	
	        v_slot_time := v_time_range.start_time;
	        WHILE v_slot_time < v_time_range.end_time LOOP
	
	            SELECT COUNT(*)
	            INTO v_appointment_count
	            FROM MED_USER_DBA.DOCTOR_AGENDA da
	            JOIN MED_USER_DBA.MEDICAL_APPOINTMENT_DETAIL mad
	              ON da.detail_id = mad.detail_id
	            WHERE da.doctor_id = Ip_doctor_id
	              AND mad.appointment_time = v_slot_time;
	
	            IF v_appointment_count = 0 THEN
	                v_found_slot_count := v_found_slot_count + 1;
	
					IF (Ip_priority > 2 AND Ip_priority <= 3 AND v_found_slot_count = 1) OR
					   (Ip_priority > 1.5 AND Ip_priority <= 2 AND v_found_slot_count = 2) OR
					   (Ip_priority >= 1 AND Ip_priority <= 1.5 AND v_found_slot_count = 3) THEN
					    Op_slot_time := v_slot_time;
					    EXIT;
					END IF;
	            END IF;
	            v_slot_time := v_slot_time + INTERVAL '30' MINUTE;
	        END LOOP;
	        IF Op_slot_time IS NOT NULL THEN
	            EXIT;
	        END IF;
	
	    END LOOP;
	
	    IF Op_slot_time IS NULL THEN
	        RAISE_APPLICATION_ERROR(-20002, 'No hay slots disponibles para la prioridad dada.');
	    END IF;
	END Proc_Validate_Slot;


    PROCEDURE Proc_Assign_Appointment(
        Ip_user_id IN NUMBER,
        Ip_medical_appointment_id IN NUMBER,
        Ip_doctor_id IN NUMBER,
        Op_detail_id OUT NUMBER
    ) IS
        v_detail_record MEDICAL_APPOINTMENT_DETAIL%ROWTYPE;
        v_agenda_record DOCTOR_AGENDA%ROWTYPE;
       
        v_slot_time TIMESTAMP;
        v_priority DECIMAL;
        v_fee NUMBER;

    BEGIN
		Proc_Validate_Priority(Ip_medical_appointment_id, v_priority);
		Proc_Calculate_Cuota(Ip_user_id, v_fee);
	    Proc_Validate_Slot(Ip_doctor_id, v_priority, v_slot_time);
	   
        v_detail_record.user_id := Ip_user_id;
        v_detail_record.medical_appointment_id := Ip_medical_appointment_id;
        v_detail_record.appointment_fee_id := v_fee;
        v_detail_record.medical_appointment_status_id := 1; 
        v_detail_record.doctor_id := Ip_doctor_id;
        
        PCK_MEDICAL_APPOINTMENT_DETAIL.Proc_Insert_MEDICAL_APPOINTENT_DETAIL(
            v_detail_record.user_id,
            v_detail_record.medical_appointment_id,
            v_detail_record.appointment_fee_id,
            v_detail_record.medical_appointment_status_id,
            v_detail_record.doctor_id,
            v_slot_time,
            Op_detail_id
        ); 
        
        v_agenda_record.doctor_id := Ip_doctor_id;
        v_agenda_record.detail_id := Op_detail_id;

        PCK_DOCTOR_AGENDA.Proc_Insert_Doctor_Agenda(
            v_agenda_record.doctor_id,
            v_agenda_record.detail_id
        ); 
    EXCEPTION WHEN OTHERS THEN
        Op_detail_id := NULL;
    END Proc_Assign_Appointment;
END PCK_DETAIL_ASSIGNMENT;
