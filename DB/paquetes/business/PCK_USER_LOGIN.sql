CREATE OR REPLACE PACKAGE PCK_USER_LOGIN IS

    PROCEDURE Proc_User_Login(
        Ip_Document IN VARCHAR2,
        Ip_Password IN VARCHAR2,
        Op_UserId OUT NUMBER
    );

END PCK_USER_LOGIN;

CREATE OR REPLACE PACKAGE BODY PCK_USER_LOGIN IS

    PROCEDURE Proc_User_Login(
        Ip_Document IN VARCHAR2, 
        Ip_Password IN VARCHAR2, 
        Op_UserId OUT NUMBER
    )IS
        v_cursor SYS_REFCURSOR;
        v_user_record MEDICAL_USER%ROWTYPE;    
    BEGIN
        PCK_MEDICAL_USER.Proc_Get_MEDICAL_USER_BY_DOCUMENT(Ip_Document, v_cursor);

        FETCH v_cursor INTO v_user_record;
            IF v_user_record.password = Ip_Password THEN
                Op_UserId := v_user_record.user_id;
            ELSE
                Op_UserId := NULL;
            END IF;
        CLOSE v_cursor;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            Op_UserId := NULL;
        WHEN OTHERS THEN
            Op_UserId := NULL;
    END Proc_User_Login;
END PCK_USER_LOGIN;

