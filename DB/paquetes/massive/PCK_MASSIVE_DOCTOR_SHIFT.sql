/*******************************************************************************
Description: Creation script for the procedure Proc_Insert_Bulk_DOCTOR_SHIFT
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE OR REPLACE PACKAGE PCK_MASSIVE_DOCTOR_SHIFT IS


    /*******************************************************************************
    Description: Creation script for the procedure Proc_Insert_Bulk_DOCTOR_SHIFT
    which inserts a list of DOCTOR_SHIFT records into the database.
    
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_Bulk_DOCTOR_SHIFT(
        Ip_doctor_shifts IN T_DOCTOR_SHIFT_TAB
    );
END PCK_MASSIVE_DOCTOR_SHIFT;


CREATE OR REPLACE PACKAGE BODY PCK_MASSIVE_DOCTOR_SHIFT AS

    PROCEDURE Proc_Insert_Bulk_DOCTOR_SHIFT(
        Ip_doctor_shifts IN T_DOCTOR_SHIFT_TAB
    ) IS
    BEGIN
        FOR i IN 1..Ip_doctor_shifts.COUNT LOOP
            INSERT INTO DOCTOR_SHIFT (
                doctor_shift_id,
                doctor_id,
                shift_date,
                start_time,
                end_time
            ) VALUES (
                SEQ_DOCTOR_SHIFT.NEXTVAL,
                Ip_doctor_shifts(i).doctor_id,
                Ip_doctor_shifts(i).shift_date,
                Ip_doctor_shifts(i).start_time,
                Ip_doctor_shifts(i).end_time
            );
        END LOOP;
    END Proc_Insert_Bulk_DOCTOR_SHIFT;
END PCK_MASSIVE_DOCTOR_SHIFT;