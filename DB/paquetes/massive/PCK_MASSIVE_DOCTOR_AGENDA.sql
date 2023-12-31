/*******************************************************************************
Description: Creation script for the package PCK_MASSIVE_DOCTOR_AGENDA
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE OR REPLACE PACKAGE PCK_MASSIVE_DOCTOR_AGENDA AS

    /*******************************************************************************
    Description: Creation script for the procedure Proc_GET_DOCTOR_IDS
    which returns the doctor ids

    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_GET_DOCTOR_IDS(
        Ip_doctors IN SYS_REFCURSOR,
        Op_doctor_agenda OUT SYS_REFCURSOR
    );

    /*******************************************************************************
    Description: Creation script for the procedure Proc_GET_AGENDA
    which returns the agenda of all doctors
    
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
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
        v_symptom VARCHAR2(100);

        v_agenda_details_table AGENDA_DETAIL_TABLE_TYPE := AGENDA_DETAIL_TABLE_TYPE();
       
    BEGIN
        LOOP
            FETCH Ip_doctors INTO v_doctor_id;
            EXIT WHEN Ip_doctors%NOTFOUND;

            PCK_GET_DETAILS.Proc_GET_AGENDA_DETAILS(v_doctor_id, v_agenda_details);

            LOOP
                FETCH v_agenda_details INTO v_detail_id, v_user_name, v_doctor_name, v_medical_appointment_id, v_fee_value, v_status, v_appointment_time, v_symptom;
                EXIT WHEN v_agenda_details%NOTFOUND;

                v_agenda_details_table.EXTEND;
                v_agenda_details_table(v_agenda_details_table.LAST) := AGENDA_DETAIL_TYPE(v_detail_id, v_user_name, v_doctor_name, v_medical_appointment_id, v_fee_value, v_status, v_appointment_time, v_symptom);
            END LOOP;

            CLOSE v_agenda_details;
        END LOOP;

        CLOSE Ip_doctors;

        OPEN Op_doctor_agenda FOR SELECT * FROM TABLE(CAST(v_agenda_details_table AS AGENDA_DETAIL_TABLE_TYPE));
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

