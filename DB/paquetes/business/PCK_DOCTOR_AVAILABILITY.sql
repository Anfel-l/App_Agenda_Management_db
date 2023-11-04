CREATE OR REPLACE PACKAGE PCK_DOCTOR_AVAILABILITY IS
    PROCEDURE Proc_Get_Doctors_By_Appointment(
        Ip_medical_appointment_id IN NUMBER,
        Ip_user_id IN NUMBER,
        Op_DOCTORS OUT NOCOPY PCK_DOCTOR.tytbDOCTOR
    );
END PCK_DOCTOR_AVAILABILITY;

CREATE OR REPLACE PACKAGE BODY PCK_DOCTOR_AVAILABILITY AS

    PROCEDURE Proc_Get_Doctors_By_Appointment(
        Ip_medical_appointment_id IN NUMBER,
        Ip_user_id IN NUMBER,
        Op_DOCTORS OUT NOCOPY PCK_DOCTOR.tytbDOCTOR
    ) IS
        v_medical_field_id NUMBER;
        v_medical_center_ids PCK_MEDICAL_CENTER.tytbMEDICAL_CENTER;
        idx BINARY_INTEGER := 1;
        
        CURSOR cur_DOCTORS(v_field_id NUMBER) IS
            SELECT
                doctor_id,
                first_name,
                second_name,
                last_name,
                medical_field_id,
                medical_center_id
            FROM DOCTOR  
            WHERE medical_field_id = v_field_id 
            AND medical_center_id IN (SELECT medical_center_id FROM TABLE(v_medical_center_ids));

    BEGIN
        -- Obtener el medical_field_id basado en el medical_appointment_id
        SELECT medical_field_id INTO v_medical_field_id 
        FROM MEDICAL_APPOINTMENT 
        WHERE medical_appointment_id = Ip_medical_appointment_id;

        -- Llenar la tabla de IDs de centros médicos basados en la ubicación del usuario
        PCK_USER_LOCATION.Proc_Get_Centers_By_User_Location(Ip_user_id, v_medical_center_ids);
        
        -- Buscar doctores basados en el medical_field_id y centros médicos
        FOR rec IN cur_DOCTORS(v_medical_field_id) LOOP
            Op_DOCTORS(idx).doctor_id := rec.doctor_id;
            Op_DOCTORS(idx).first_name := rec.first_name;
            Op_DOCTORS(idx).second_name := rec.second_name;
            Op_DOCTORS(idx).last_name := rec.last_name;
            Op_DOCTORS(idx).medical_field_id := rec.medical_field_id;
            Op_DOCTORS(idx).medical_center_id := rec.medical_center_id;
            idx := idx + 1;
        END LOOP;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCTOR_AVAILABILITY.Proc_Get_Doctors_By_Appointment]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_Doctors_By_Appointment;
    
END PCK_DOCTOR_AVAILABILITY;



