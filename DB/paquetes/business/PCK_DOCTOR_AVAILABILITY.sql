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
        v_centers_cursor SYS_REFCURSOR;
        v_center_ids NUMBER_TABLE_TYPE := NUMBER_TABLE_TYPE(); -- Utiliza el tipo de colección creado
        v_center_record MED_USER_DBA.MEDICAL_CENTER%ROWTYPE;
    BEGIN
        SELECT medical_field_id INTO v_medical_field_id
        FROM MED_USER_DBA.MEDICAL_APPOINTMENT
        WHERE medical_appointment_id = Ip_medical_appointment_id;

        MED_USER_DBA.PCK_USER_LOCATION.Proc_Get_Centers_By_User_Location(
            Ip_User_Id => Ip_user_id,
            Op_MEDICAL_CENTERS => v_centers_cursor
        );

        -- Fetch cada centro médico del cursor y agrega el ID a la colección
        LOOP
            FETCH v_centers_cursor INTO v_center_record;
            EXIT WHEN v_centers_cursor%NOTFOUND;
            
            v_center_ids.EXTEND;
            v_center_ids(v_center_ids.LAST) := v_center_record.medical_center_id;
        END LOOP;

        -- Cierra el cursor después de su uso
        CLOSE v_centers_cursor;
        
        -- Ahora usa la colección de IDs para filtrar los doctores
        OPEN Op_DOCTORS FOR
            SELECT D.* FROM MED_USER_DBA.DOCTOR D
            WHERE D.medical_field_id = v_medical_field_id
            AND D.medical_center_id MEMBER OF v_center_ids;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'No doctors found for the given appointment ID and user ID.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_Doctors_By_Appointment;

END PCK_DOCTOR_AVAILABILITY;




