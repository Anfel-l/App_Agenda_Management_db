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

CREATE OR REPLACE PACKAGE BODY MED_USER_DBA.PCK_GET_DETAILS AS

    PROCEDURE Proc_GET_USER_DETAILS(
        Ip_user_id IN NUMBER,
        Op_details OUT SYS_REFCURSOR)
    IS
    BEGIN
        OPEN Op_details /*+ INDEX(u PK_MEDICAL_USER) INDEX(dt PK_DOCUMENT_TYPE) INDEX(ct PK_CONTRACT_TYPE) INDEX(l PK_LOCATION) */ FOR
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
        OPEN Op_details /*+ INDEX(ma PK_MEDICAL_APPOINTMENT) INDEX(mat PK_MEDICAL_APPOINTMENT_TYPE) INDEX(s PK_SYMPTOM) */ FOR
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
            SELECT /*+ INDEX(mad PK_MEDICAL_APPOINTMENT_DETAIL) INDEX(u PK_MEDICAL_USER) INDEX(d PK_DOCTOR) */
            mad.detail_id, u.first_name || ' ' || u.last_name AS user_name, 
            d.first_name || ' ' || d.last_name AS doctor_name, 
            ma.medical_appointment_id, 
            af.fee_value, 
            mas.status, 
            mad.appointment_time,
            s.symptom_name
            FROM MEDICAL_APPOINTMENT_DETAIL mad
            JOIN MEDICAL_USER u ON mad.user_id = u.user_id
            JOIN DOCTOR d ON mad.doctor_id = d.doctor_id
            JOIN MEDICAL_APPOINTMENT ma ON mad.medical_appointment_id = ma.medical_appointment_id
            JOIN SYMPTOM s ON ma.symptom_id = s.symptom_id
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
            SELECT /*+ INDEX(d PK_DOCTOR) INDEX(mf PK_MEDICAL_FIELD) INDEX(mc PK_MEDICAL_CENTER) INDEX(ds PK_DOCTOR_SHIFT) */
                d.doctor_id,
                d.first_name,
                d.second_name,
                d.last_name,
                mf.medical_field_name,
                mc.medical_center_name,
                ds.start_time,
                ds.end_time
            FROM DOCTOR d
            JOIN MEDICAL_FIELD mf ON d.medical_field_id = mf.medical_field_id
            JOIN MEDICAL_CENTER mc ON d.medical_center_id = mc.medical_center_id
            JOIN DOCTOR_SHIFT ds ON d.doctor_id = ds.doctor_id
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
	        SELECT /*+ INDEX(mad PK_MEDICAL_APPOINTMENT_DETAIL) INDEX(u PK_MEDICAL_USER) INDEX(d PK_DOCTOR) INDEX(ma PK_MEDICAL_APPOINTMENT) INDEX(s PK_SYMPTOM) INDEX(af PK_APPOINTMENT_FEE) INDEX(mas PK_MEDICAL_APPOINTMENT_STATUS) */
	            mad.detail_id, 
	            u.first_name || ' ' || u.last_name AS user_name, 
	            d.first_name || ' ' || d.last_name AS doctor_name, 
	            ma.medical_appointment_id, 
	            af.fee_value, 
	            mas.status, 
	            mad.appointment_time,
	            s.symptom_name
	        FROM MEDICAL_APPOINTMENT_DETAIL mad
	        JOIN MEDICAL_USER u ON mad.user_id = u.user_id
	        JOIN DOCTOR d ON mad.doctor_id = d.doctor_id
	        JOIN MEDICAL_APPOINTMENT ma ON mad.medical_appointment_id = ma.medical_appointment_id
	        JOIN SYMPTOM s ON ma.symptom_id = s.symptom_id
	        JOIN APPOINTMENT_FEE af ON mad.appointment_fee_id = af.appointment_fee_id
	        JOIN MEDICAL_APPOINTMENT_STATUS mas ON mad.medical_appointment_status_id = mas.medical_appointment_status_id
	        WHERE d.doctor_id = Ip_doctor_id
	        AND TRUNC(mad.appointment_time) = TRUNC(SYSDATE); -- Filtrar por la fecha actual
	
	EXCEPTION
	    WHEN OTHERS THEN
	        RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
	END Proc_GET_AGENDA_DETAILS;

END PCK_GET_DETAILS;
