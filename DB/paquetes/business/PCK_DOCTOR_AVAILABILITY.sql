CREATE OR REPLACE PACKAGE PCK_DOCTOR_AVAILABILITY IS
    PROCEDURE Proc_Get_Doctor_Agenda(
        Ip_Doctor_Ids IN SYS_REFCURSOR,
        Op_Doctor_Id OUT NUMBER
    );
   	
    PROCEDURE Proc_Get_Doctors_By_Appointment(
        Ip_medical_appointment_id IN NUMBER,
        Ip_user_id IN NUMBER,
        Op_doctor OUT SYS_REFCURSOR
    );

END PCK_DOCTOR_AVAILABILITY;

CREATE OR REPLACE PACKAGE BODY PCK_DOCTOR_AVAILABILITY AS

	PROCEDURE Proc_Get_Doctor_Agenda(
	    Ip_Doctor_Ids IN SYS_REFCURSOR,
	    Op_Doctor_Id OUT NUMBER
	) IS
	    v_least_appointments NUMBER := NULL;
	    v_doctor_record MED_USER_DBA.DOCTOR%ROWTYPE;
	    v_current_appointments NUMBER;
	BEGIN
	    LOOP
	        FETCH Ip_Doctor_Ids INTO v_doctor_record;
	        EXIT WHEN Ip_Doctor_Ids%NOTFOUND;
	
	        SELECT COUNT(*)
	        INTO v_current_appointments
	        FROM DOCTOR_AGENDA
	        WHERE doctor_id = v_doctor_record.doctor_id;
	
	        IF v_least_appointments IS NULL OR v_current_appointments < v_least_appointments THEN
	            v_least_appointments := v_current_appointments;
	            Op_Doctor_Id := v_doctor_record.doctor_id;
	        END IF;
	    END LOOP;
	
	    CLOSE Ip_Doctor_Ids;
	
	    IF Op_Doctor_Id IS NULL THEN
	        RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCTOR_AVAILABILITY.Get_Doctor_Agenda]');
	    END IF;
	    
	EXCEPTION
	    WHEN OTHERS THEN
	        IF Ip_Doctor_Ids%ISOPEN THEN
	            CLOSE Ip_Doctor_Ids;
	        END IF;
	        RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
	END Proc_Get_Doctor_Agenda;
   

    PROCEDURE Proc_Get_Doctors_By_Appointment(
        Ip_medical_appointment_id IN NUMBER,
        Ip_user_id IN NUMBER,
        Op_doctor OUT SYS_REFCURSOR
    ) IS
        v_medical_field_id NUMBER;
        v_centers_cursor SYS_REFCURSOR;
        v_center_ids NUMBER_TABLE_TYPE := NUMBER_TABLE_TYPE();
        v_center_record MED_USER_DBA.MEDICAL_CENTER%ROWTYPE;
       
        v_aux_cursor SYS_REFCURSOR;
        v_aux_id NUMBER;

        v_final_cursor SYS_REFCURSOR;
    BEGIN
        SELECT medical_field_id INTO v_medical_field_id
        FROM MED_USER_DBA.MEDICAL_APPOINTMENT
        WHERE medical_appointment_id = Ip_medical_appointment_id;

        MED_USER_DBA.PCK_USER_LOCATION.Proc_Get_Centers_By_User_Location(
            Ip_User_Id => Ip_user_id,
            Op_MEDICAL_CENTERS => v_centers_cursor
        );

        LOOP
            FETCH v_centers_cursor INTO v_center_record;
            EXIT WHEN v_centers_cursor%NOTFOUND;
            
            v_center_ids.EXTEND;
            v_center_ids(v_center_ids.LAST) := v_center_record.medical_center_id;
        END LOOP;

        CLOSE v_centers_cursor;
        
        OPEN v_aux_cursor FOR
            SELECT D.* FROM MED_USER_DBA.DOCTOR D
            WHERE D.medical_field_id = v_medical_field_id
            AND D.medical_center_id MEMBER OF v_center_ids;
           
        Proc_Get_Doctor_Agenda(v_aux_cursor, v_aux_id);

        PCK_DOCTOR.Proc_Get_DOCTOR_BY_ID(
            Ip_doctor_id => v_aux_id,
            Op_doctor => v_final_cursor
        );

    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'No doctors found for the given appointment ID and user ID.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_Doctors_By_Appointment;

END PCK_DOCTOR_AVAILABILITY;




