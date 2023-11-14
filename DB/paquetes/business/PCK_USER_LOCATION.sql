/*******************************************************************************
Description: Creation script for the package PCK_USER_LOCATION declaration
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE OR REPLACE PACKAGE PCK_USER_LOCATION IS

    /*******************************************************************************
    Description: Creation script for the procedure Proc_Get_Centers_By_User_Location
    which returns the medical centers associated to a user location

    Author: Andrés Felipe Lugo Rodríguez
    Date: 17/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_Centers_By_User_Location(
        Ip_User_Id IN NUMBER,
        Op_MEDICAL_CENTERS OUT SYS_REFCURSOR
    );

END PCK_USER_LOCATION;
CREATE OR REPLACE PACKAGE BODY PCK_USER_LOCATION AS

    PROCEDURE Proc_Get_Centers_By_User_Location (
        Ip_User_Id IN NUMBER, 
        Op_MEDICAL_CENTERS OUT SYS_REFCURSOR
    ) IS
        v_user_location SYS_REFCURSOR;
        v_user_record MEDICAL_USER%ROWTYPE; 
        v_location_id NUMBER;
    BEGIN
        
        PCK_MEDICAL_USER.Proc_Get_MEDICAL_USER_BY_ID(Ip_User_Id, v_user_location);
        
        
        FETCH v_user_location INTO v_user_record;
        CLOSE v_user_location;
        IF v_user_record.location_id IS NOT NULL THEN
            v_location_id := v_user_record.location_id;
            PCK_MEDICAL_CENTER.Proc_Get_MEDICAL_CENTER_BY_LOCATION(v_location_id, Op_MEDICAL_CENTERS);
        ELSE
            RAISE_APPLICATION_ERROR(-20150, 'Error: No user location found [PCK_USER_LOCATION.Proc_Get_Centers_By_User_Location]');
        END IF;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_USER_LOCATION.Proc_Get_Centers_By_User_Location]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_Centers_By_User_Location;
END PCK_USER_LOCATION;
