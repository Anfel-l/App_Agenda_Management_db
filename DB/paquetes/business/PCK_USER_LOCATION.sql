-- Definición del paquete PCK_USER_LOCATION
CREATE OR REPLACE PACKAGE PCK_USER_LOCATION IS

    -- Procedimiento para obtener centros médicos basados en la ubicación del usuario
    PROCEDURE Proc_Get_Centers_By_User_Location (
        Ip_User_Id IN NUMBER,
        Op_MEDICAL_CENTERS OUT NOCOPY PCK_MEDICAL_CENTER.tytbMEDICAL_CENTER
    );

END PCK_USER_LOCATION;
-- Cuerpo del paquete PCK_USER_LOCATION
CREATE OR REPLACE PACKAGE BODY PCK_USER_LOCATION AS

    PROCEDURE Proc_Get_Centers_By_User_Location (Ip_User_Id IN NUMBER, Op_MEDICAL_CENTERS OUT NOCOPY PCK_MEDICAL_CENTER.tytbMEDICAL_CENTER) IS
        v_user_location PCK_MEDICAL_USER.tyrcMEDICAL_USER;
    BEGIN
        -- Obtener la ubicación del usuario
        PCK_MEDICAL_USER.Proc_Get_MEDICAL_USER_ID(Ip_User_Id, v_user_location);
        
        -- Obtener centros médicos basados en la ubicación del usuario
        PCK_MEDICAL_CENTER.Proc_Get_MEDICAL_CENTER_By_Location(v_user_location.location_id, Op_MEDICAL_CENTERS);
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'Error: No results were found [PCK_USER_LOCATION.Proc_Get_Centers_By_User_Location]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_Centers_By_User_Location;

END PCK_USER_LOCATION;
