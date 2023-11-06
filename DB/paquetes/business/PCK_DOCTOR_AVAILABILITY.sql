CREATE OR REPLACE PACKAGE PCK_DOCTOR_AVAILABILITY IS

    PROCEDURE Proc_Get_Doctors_By_Appointment(
        Ip_medical_appointment_id IN NUMBER,
        Ip_user_id IN NUMBER,
        Op_DOCTORS OUT SYS_REFCURSOR
    );

END PCK_DOCTOR_AVAILABILITY;

CREATE OR REPLACE PACKAGE BODY PCK_DOCTOR_AVAILABILITY AS

    PROCEDURE Proc_Get_Doctors_By_Appointment(
        Ip_medical_appointment_id IN NUMBER,
        Ip_user_id IN NUMBER,
        Op_DOCTORS OUT SYS_REFCURSOR
    ) IS
        v_medical_field_id NUMBER;
        v_medical_center_id_table t_medical_center_id_table := t_medical_center_id_table();
        v_medical_center_id NUMBER;
        v_temp_cursor SYS_REFCURSOR;
    BEGIN
        SELECT medical_field_id INTO v_medical_field_id 
        FROM MEDICAL_APPOINTMENT 
        WHERE medical_appointment_id = Ip_medical_appointment_id;

        PCK_USER_LOCATION.Proc_Get_Centers_By_User_Location(Ip_user_id, v_temp_cursor);

        LOOP
            FETCH v_temp_cursor INTO v_medical_center_id;
            EXIT WHEN v_temp_cursor%NOTFOUND;
            v_medical_center_id_table.EXTEND;
            v_medical_center_id_table(v_medical_center_id_table.LAST) := v_medical_center_id;
        END LOOP;
        CLOSE v_temp_cursor;

        OPEN Op_DOCTORS FOR
            SELECT
                doctor_id,
                first_name,
                second_name,
                last_name,
                medical_field_id,
                medical_center_id
            FROM DOCTOR
            WHERE medical_field_id = v_medical_field_id
            AND medical_center_id MEMBER OF v_medical_center_id_table;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, 'Unexpected error: ' || SQLERRM);
    END Proc_Get_Doctors_By_Appointment;
    
END PCK_DOCTOR_AVAILABILITY;



