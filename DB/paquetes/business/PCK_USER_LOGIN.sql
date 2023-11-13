CREATE OR REPLACE PACKAGE PCK_USER_LOGIN AS
    
    PROCEDURE Proc_User_Login(
        Ip_document_type_id IN NUMBER,
        Ip_Document IN VARCHAR2,
        Ip_Password IN VARCHAR2,
        Op_UserId OUT NUMBER,
        Op_Result OUT VARCHAR2
    );

END PCK_USER_LOGIN;

CREATE OR REPLACE PACKAGE BODY PCK_USER_LOGIN IS

    PROCEDURE Proc_User_Login(
        Ip_document_type_id IN NUMBER,
        Ip_Document IN VARCHAR2,
        Ip_Password IN VARCHAR2,
        Op_UserId OUT NUMBER,
        Op_Result OUT VARCHAR2
    ) IS
        v_user_cursor SYS_REFCURSOR;
        v_user_record MEDICAL_USER%ROWTYPE;
    BEGIN
        PCK_MEDICAL_USER.Proc_Get_MEDICAL_USER_BY_DOCUMENT(Ip_Document, v_user_cursor);

        FETCH v_user_cursor INTO v_user_record;

        IF v_user_cursor%FOUND THEN
            IF v_user_record.password = Ip_Password AND v_user_record.document_type_id = Ip_document_type_id THEN
                Op_UserId := v_user_record.user_id;
                Op_Result := 'Login successful';
            ELSE
                Op_UserId := NULL;
                Op_Result := 'Invalid password';
            END IF;
        ELSE
            Op_UserId := NULL;
            Op_Result := 'User not found';
        END IF;
        CLOSE v_user_cursor;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            Op_UserId := NULL;
            Op_Result := 'User not found';
        WHEN OTHERS THEN
            IF v_user_cursor%ISOPEN THEN
                CLOSE v_user_cursor;
            END IF;
            Op_Result := 'Error during login: ' || SQLERRM; -- Proporciona información del error
            Op_UserId := NULL;
    END Proc_User_Login;

END PCK_USER_LOGIN;

