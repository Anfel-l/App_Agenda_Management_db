CREATE OR REPLACE PACKAGE PCK_MASSIVE_DOCTOR_AGENDA AS

    PROCEDURE Proc_GET_DOCTOR_IDS(
        Ip_doctors IN SYS_REFCURSOR,
        Op_doctor_agenda OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_GET_AGENDA(
        Op_agenda OUT SYS_REFCURSOR
    );

END PCK_MASSIVE_DOCTOR_AGENDA;


CREATE OR REPLACE PACKAGE BODY PCK_MASSIVE_DOCTOR_AGENDA IS

    PROCEDURE Proc_GET_DOCTOR_IDS(
        Ip_doctors IN SYS_REFCURSOR,
        Op_doctor_agenda OUT SYS_REFCURSOR
    ) IS
        v_doctor_id NUMBER;
        v_agenda_details SYS_REFCURSOR;
       
        v_detail_id NUMBER;
        v_user_name VARCHAR2(100);
        v_doctor_name VARCHAR2(100);
        v_medical_appointment_id NUMBER;
        v_fee_value NUMBER;
        v_status VARCHAR2(100);
        v_appointment_time TIMESTAMP;
       
    BEGIN
        LOOP
            FETCH Ip_doctors INTO v_doctor_id;
            EXIT WHEN Ip_doctors%NOTFOUND;

            PCK_GET_DETAILS.Proc_GET_AGENDA_DETAILS(v_doctor_id, v_agenda_details);

            LOOP
                FETCH v_agenda_details INTO v_detail_id, v_user_name, v_doctor_name, v_medical_appointment_id, v_fee_value, v_status, v_appointment_time;
                EXIT WHEN v_agenda_details%NOTFOUND;

                INSERT INTO temp_agenda_details VALUES (v_detail_id, v_user_name, v_doctor_name, v_medical_appointment_id, v_fee_value, v_status, v_appointment_time);
            END LOOP;

            CLOSE v_agenda_details;
        END LOOP;

        CLOSE Ip_doctors;

        OPEN Op_doctor_agenda FOR SELECT * FROM temp_agenda_details;
    END Proc_GET_DOCTOR_IDS;

    PROCEDURE Proc_GET_AGENDA(
        Op_agenda OUT SYS_REFCURSOR
    ) IS
        v_all_doctors SYS_REFCURSOR;
        v_doctor_ids NUMBER_TABLE_TYPE := NUMBER_TABLE_TYPE();
        v_doctor_record MED_USER_DBA.DOCTOR%ROWTYPE;

        v_aux_cursor SYS_REFCURSOR;

    BEGIN
        PCK_DOCTOR.Proc_Get_All_DOCTOR(v_all_doctors);

        LOOP
            FETCH v_all_doctors INTO v_doctor_record;
            EXIT WHEN v_all_doctors%NOTFOUND;

            v_doctor_ids.EXTEND;
            v_doctor_ids(v_doctor_ids.LAST) := v_doctor_record.doctor_id;
        END LOOP;

        CLOSE v_all_doctors;

        OPEN v_aux_cursor FOR
            SELECT * FROM TABLE(v_doctor_ids);

        Proc_GET_DOCTOR_IDS(v_aux_cursor, Op_agenda);
        
    END Proc_GET_AGENDA;

END PCK_MASSIVE_DOCTOR_AGENDA;
