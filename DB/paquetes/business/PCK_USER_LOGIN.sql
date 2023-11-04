CREATE OR REPLACE PACKAGE PCK_USER_LOGIN IS
    /*******************************************************************************
    Description: Package for data manipulation of the table APPOINMENT_FEE
    Author: Andrés Felipe Lugo Rodríguez
    Date: 23/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/

    /*******************************************************************************
    Description: Procedure to validate the user credentials
    Author: Andrés Felipe Lugo Rodríguez
    Date: 23/10/2023
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_User_Login(
        Ip_Document IN VARCHAR2,
        Ip_Password IN VARCHAR2,
        Op_UserId OUT NUMBER,
        Op_Result OUT VARCHAR2
    );

END PCK_USER_LOGIN;

CREATE OR REPLACE PACKAGE BODY PCK_USER_LOGIN IS

    PROCEDURE Proc_User_Login(Ip_Document IN VARCHAR2, Ip_Password IN VARCHAR2, Op_UserId OUT NUMBER, Op_Result OUT VARCHAR2) IS
        v_user_record PCK_MEDICAL_USER.tyrcMEDICAL_USER;
    BEGIN
        -- Use the PCK_MEDICAL_USER package to get the user details by document number
        PCK_MEDICAL_USER.Proc_Get_MEDICAL_USER_DOCUMENT(Ip_Document, v_user_record);

        -- Validate the provided password against the retrieved user details
        IF v_user_record.password = Ip_Password THEN
            Op_UserId := v_user_record.user_id;
            Op_Result := 'Login Successful';
        ELSE
            Op_Result := 'Invalid Credentials';
            Op_UserId := NULL;
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            Op_Result := 'User not found';
            Op_UserId := NULL;
        WHEN OTHERS THEN
            Op_Result := 'Error during login';
            Op_UserId := NULL;
    END Proc_User_Login;

END PCK_USER_LOGIN;

