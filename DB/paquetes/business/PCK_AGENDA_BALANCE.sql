CREATE OR REPLACE PACKAGE PCK_AGENDA_BALANCE AS

    PROCEDURE Get_Doctor_Agenda(
        Ip_Doctor_Ids IN SYS_REFCURSOR,
        Op_Doctor_Id OUT NUMBER,
        Op_Total_Appointments OUT NUMBER
    );

END PCK_AGENDA_BALANCE;

CREATE OR REPLACE PACKAGE BODY PCK_AGENDA_BALANCE IS

     PROCEDURE Get_Doctor_Agenda(
        Ip_Doctor_Ids IN SYS_REFCURSOR,
        Op_Doctor_Id OUT NUMBER,
        Op_Total_Appointments OUT NUMBER
    ) IS
        v_least_appointments NUMBER := NULL;
        v_doctor_id NUMBER;
        v_current_appointments NUMBER;
    BEGIN
        LOOP
            FETCH Ip_Doctor_Ids INTO v_doctor_id;
            EXIT WHEN Ip_Doctor_Ids%NOTFOUND;

            SELECT COUNT(*)
            INTO v_current_appointments
            FROM DOCTOR_AGENDA
            WHERE doctor_id = v_doctor_id;

            IF v_least_appointments IS NULL OR v_current_appointments < v_least_appointments THEN
                v_least_appointments := v_current_appointments;
                Op_Doctor_Id := v_doctor_id;
            END IF;
        END LOOP;

        CLOSE Ip_Doctor_Ids;

        Op_Total_Appointments := v_least_appointments;

        IF Op_Doctor_Id IS NULL THEN
            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCTOR_AVAILABILITY.Get_Doctor_Agenda]');
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            IF Ip_Doctor_Ids%ISOPEN THEN
                CLOSE Ip_Doctor_Ids;
            END IF;
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Get_Doctor_Agenda;

END PCK_AGENDA_BALANCE;
