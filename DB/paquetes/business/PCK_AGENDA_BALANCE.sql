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
        v_least_appointments NUMBER := 10;
        v_current_appointments NUMBER;
    BEGIN
        FOR i IN 1..Ip_Doctor_Ids.COUNT LOOP
            SELECT COUNT(*)
            INTO v_current_appointments
            FROM DOCTOR_AGENDA
            WHERE doctor_id = Ip_Doctor_Ids(i).doctor_id;

            IF v_current_appointments < v_least_appointments THEN
                v_least_appointments := v_current_appointments;
                Op_Doctor_Id := Ip_Doctor_Ids(i).doctor_id;
            END IF;
        END LOOP;

        Op_Total_Appointments := v_least_appointments;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_DOCTOR_AVAILABILITY.Get_Doctor_Agenda]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Get_Doctor_Agenda;

END PCK_AGENDA_BALANCE;
