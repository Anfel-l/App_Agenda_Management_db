CREATE OR REPLACE PACKAGE PCK_GET_DETAILS IS

    PROCEDURE Proc_GET_USER_DETAILS(
        Ip_user_id IN NUMBER,
        Op_details OUT SYS_REFCURSOR);

    PROCEDURE Proc_GET_APPOINTMENT_DETAILS(
        Ip_appointment_id IN NUMBER,
        Op_details OUT SYS_REFCURSOR);

    PROCEDURE Proc_GET_APPOINTMENT_DETAIL_DETAILS(
        Ip_appointment_detail_id IN NUMBER,
        Op_details OUT SYS_REFCURSOR);

    PROCEDURE Proc_GET_DOCTOR_DETAILS(
        Ip_doctor_id IN NUMBER,
        Op_details OUT SYS_REFCURSOR);

    PROCEDURE Proc_GET_AGENDA_DETAILS(
        Ip_doctor_id IN NUMBER,
        Op_agenda OUT SYS_REFCURSOR);
        

END PCK_GET_DETAILS;


CREATE OR REPLACE PACKAGE BODY PCK_GET_DETAILS AS

    PROCEDURE Proc_GET_USER_DETAILS(
        Ip_user_id IN NUMBER,
        Op_details OUT SYS_REFCURSOR)
    IS
    BEGIN
        OPEN Op_details FOR
        SELECT u.first_name, u.second_name, u.last_name, u.document, dt.description AS document_type, ct.contract_type_name, l.location_name
        FROM MEDICAL_USER u
        JOIN DOCUMENT_TYPE dt ON u.document_type_id = dt.document_type_id
        JOIN CONTRACT_TYPE ct ON u.contract_type_id = ct.contract_type_id
        JOIN LOCATION l ON u.location_id = l.location_id
        WHERE u.user_id = Ip_user_id;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_GET_USER_DETAILS;

    PROCEDURE Proc_GET_APPOINTMENT_DETAILS(
        Ip_appointment_id IN NUMBER,
        Op_details OUT SYS_REFCURSOR)
    IS
    BEGIN
        OPEN Op_details FOR
        SELECT ma.medical_appointment_id, mat.description AS appointment_type, s.symptom_name, ma.medical_priority
        FROM MEDICAL_APPOINTMENT ma
        JOIN MEDICAL_APPOINTMENT_TYPE mat ON ma.medical_appointment_type_id = mat.medical_appointment_type_id
        JOIN SYMPTOM s ON ma.symptom_id = s.symptom_id
        WHERE ma.medical_appointment_id = Ip_appointment_id;
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_GET_APPOINTMENT_DETAILS;



    PROCEDURE Proc_GET_APPOINTMENT_DETAIL_DETAILS(
        Ip_appointment_detail_id IN NUMBER,
        Op_details OUT SYS_REFCURSOR)
    IS
    BEGIN
        OPEN Op_details FOR
            SELECT mad.detail_id, u.first_name || ' ' || u.last_name AS user_name, d.first_name || ' ' || d.last_name AS doctor_name, ma.medical_appointment_id, af.fee_value, mas.status, mad.appointment_time
            FROM MEDICAL_APPOINTMENT_DETAIL mad
            JOIN MEDICAL_USER u ON mad.user_id = u.user_id
            JOIN DOCTOR d ON mad.doctor_id = d.doctor_id
            JOIN MEDICAL_APPOINTMENT ma ON mad.medical_appointment_id = ma.medical_appointment_id
            JOIN APPOINTMENT_FEE af ON mad.appointment_fee_id = af.appointment_fee_id
            JOIN MEDICAL_APPOINTMENT_STATUS mas ON mad.medical_appointment_status_id = mas.medical_appointment_status_id
        WHERE mad.detail_id = Ip_appointment_detail_id;
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_GET_APPOINTMENT_DETAIL_DETAILS;


    PROCEDURE Proc_GET_DOCTOR_DETAILS(
        Ip_doctor_id IN NUMBER,
        Op_details OUT SYS_REFCURSOR)
    IS
    BEGIN
        OPEN Op_details FOR
            SELECT d.first_name, d.last_name, mf.medical_field_name, mc.medical_center_name
            FROM DOCTOR d
            JOIN MEDICAL_FIELD mf ON d.medical_field_id = mf.medical_field_id
            JOIN MEDICAL_CENTER mc ON d.medical_center_id = mc.medical_center_id
        WHERE d.doctor_id = Ip_doctor_id;
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_GET_DOCTOR_DETAILS;

    PROCEDURE Proc_GET_AGENDA_DETAILS(
        Ip_doctor_id IN NUMBER,
        Op_agenda OUT SYS_REFCURSOR)
    IS
    BEGIN
        OPEN Op_agenda FOR
            SELECT mad.detail_id, u.first_name || ' ' || u.last_name AS user_name, d.first_name || ' ' || d.last_name AS doctor_name, ma.medical_appointment_id, af.fee_value, mas.status, mad.appointment_time
            FROM MEDICAL_APPOINTMENT_DETAIL mad
            JOIN MEDICAL_USER u ON mad.user_id = u.user_id
            JOIN DOCTOR d ON mad.doctor_id = d.doctor_id
            JOIN MEDICAL_APPOINTMENT ma ON mad.medical_appointment_id = ma.medical_appointment_id
            JOIN APPOINTMENT_FEE af ON mad.appointment_fee_id = af.appointment_fee_id
            JOIN MEDICAL_APPOINTMENT_STATUS mas ON mad.medical_appointment_status_id = mas.medical_appointment_status_id
        WHERE mad.doctor_id = Ip_doctor_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_GET_AGENDA_DETAILS;

END PCK_GET_DETAILS;
