CREATE OR REPLACE PACKAGE PCK_MEDICAL_APPOINTMENT IS
    /*******************************************************************************
    Description: Package for data manipulation of the tableMEDICAL_APPOINTMENT
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /* Data types declaration */

    SUBTYPE tyrcMEDICAL_APPOINTMENT IS MEDICAL_APPOINTMENT%ROWTYPE;
    TYPE tytbMEDICAL_APPOINTMENT IS TABLE OF tyrcMEDICAL_APPOINTMENT INDEX BY BINARY_INTEGER;

    /* Variables declaration */

    /* Procedures and function declaration*/

    /*******************************************************************************
    Description: Procedure that inserts information in the table MEDICAL_APPOINTMENT
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT (
        IOp_MEDICAL_APPOINTMENT IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT
    );

    /*******************************************************************************
    Description: Procedure that gets all the information of the table MEDICAL_APPOINTMENT
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT (
        Op_MEDICAL_APPOINTMENT OUT NOCOPY tytbMEDICAL_APPOINTMENT
    );

    /*******************************************************************************
    Description: Procedure that gets information of the table MEDICAL_APPOINTMENT by id
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT (
        Ip_Id in NUMBER,
        Op_MEDICAL_APPOINTMENT OUT NOCOPY tyrcMEDICAL_APPOINTMENT
    );

    /*******************************************************************************
    Description: Procedure that updates information of the table MEDICAL_APPOINTMENT
    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT (
        IOp_MEDICAL_APPOINTMENT IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT
    );

END PCK_MEDICAL_APPOINTMENT;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_APPOINTMENT AS

    /* Insert Procedure */
    PROCEDURE Proc_Insert_MEDICAL_APPOINTMENT (IOp_MEDICAL_APPOINTMENT IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT) IS
        BEGIN

            /* Initialazing values */
            IOp_MEDICAL_APPOINTMENT.medical_appointment_id := SEQ_MEDICAL_APPOINTMENT.NEXTVAL;

            /* Inserting a register */
            INSERT INTO MEDICAL_APPOINTMENT VALUES /*+PCK_MEDICAL_APPOINTMENT*/ IOp_MEDICAL_APPOINTMENT;

        /* Trowing Exception */
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Error: Duplicated value on [PCK_MEDICAL_APPOINTMENT.Proc_Insert_MEDICAL_APPOINTMENT]');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_MEDICAL_APPOINTMENT;

    /* Get All Information Procedure */
    PROCEDURE Proc_Get_All_MEDICAL_APPOINTMENT (Op_MEDICAL_APPOINTMENT OUT NOCOPY tytbMEDICAL_APPOINTMENT) IS
        CURSOR cur_MEDICAL_APPOINTMENT IS
            SELECT
                medical_appointment_id,
                medical_appointment_type_id,
                symptom_id,
                medical_priority,
                medical_field_id
            FROM MEDICAL_APPOINTMENT;
                idx BINARY_INTEGER := 1;
        BEGIN
            FOR rec IN cur_MEDICAL_APPOINTMENT LOOP
                Op_MEDICAL_APPOINTMENT(idx) := rec;
                idx := idx + 1;
            END LOOP;
            

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_APPOINTMENT.Proc_Get_MEDICAL_APPOINTMENT]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);


    END Proc_Get_All_MEDICAL_APPOINTMENT;

    /* Get Information by Id Procedure */
    PROCEDURE Proc_Get_MEDICAL_APPOINTMENT (Ip_Id in NUMBER, Op_MEDICAL_APPOINTMENT OUT NOCOPY tyrcMEDICAL_APPOINTMENT) IS
        CURSOR cur_MEDICAL_APPOINTMENT IS
            SELECT
                medical_appointment_id,
                medical_appointment_type_id,
                symptom_id,
                medical_priority,
                medical_field_id
            FROM MEDICAL_APPOINTMENT
            WHERE /*+PCK_MEDICAL_APPOINTMENT.Proc_Get_MEDICAL_APPOINTMENT*/ medical_appointment_id = Ip_Id;          
        BEGIN
            OPEN cur_MEDICAL_APPOINTMENT;
            FETCH cur_MEDICAL_APPOINTMENT INTO Op_MEDICAL_APPOINTMENT;
            CLOSE cur_MEDICAL_APPOINTMENT;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
	            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_MEDICAL_APPOINTMENT.Proc_Get_MEDICAL_APPOINTMENT]');
	        WHEN OTHERS THEN
	            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);


    END Proc_Get_MEDICAL_APPOINTMENT;

    /* Update Information Procedure */
    PROCEDURE Proc_Update_MEDICAL_APPOINTMENT (IOp_MEDICAL_APPOINTMENT IN OUT NOCOPY tyrcMEDICAL_APPOINTMENT) IS
        /* Declaring variable for update */
            v_updated_record tyrcMEDICAL_APPOINTMENT;
        BEGIN
				UPDATE MEDICAL_APPOINTMENT
				SET
				    medical_appointment_type_id = IOp_MEDICAL_APPOINTMENT.medical_appointment_type_id,
				    symptom_id = IOp_MEDICAL_APPOINTMENT.symptom_id,
                    medical_priority = IOp_MEDICAL_APPOINTMENT.medical_priority,
                    medical_field_id = IOp_MEDICAL_APPOINTMENT.medical_field_id
				WHERE /*+PCK_MEDICAL_APPOINTMENT.Proc_Update_MEDICAL_APPOINTMENT*/ medical_appointment_id = IOp_MEDICAL_APPOINTMENT.medical_appointment_id;    
                Proc_Get_MEDICAL_APPOINTMENT(IOp_MEDICAL_APPOINTMENT.medical_appointment_id, v_updated_record);
                IOp_MEDICAL_APPOINTMENT := v_updated_record;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);

    END Proc_Update_MEDICAL_APPOINTMENT;

END PCK_MEDICAL_APPOINTMENT;
