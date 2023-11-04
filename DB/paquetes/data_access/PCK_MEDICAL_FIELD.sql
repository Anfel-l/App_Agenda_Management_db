CREATE OR REPLACE PACKAGE PCK_MEDICAL_FIELD IS
    
    PROCEDURE Proc_Insert_MEDICAL_FIELD(
        Ip_medical_field_name IN VARCHAR2,
        Ip_description IN VARCHAR2
    );

    PROCEDURE Proc_Update_MEDICAL_FIELD(
        Ip_medical_field_id IN NUMBER,
        Ip_medical_field_name IN VARCHAR2,
        Ip_description IN VARCHAR2
    );

    PROCEDURE Proc_Get_All_MEDICAL_FIELD(
        Op_medical_field OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_MEDICAL_FIELD_BY_ID(
        Ip_medical_field_id IN NUMBER,
        Op_medical_field OUT SYS_REFCURSOR
    );

END PCK_MEDICAL_FIELD;

CREATE OR REPLACE PACKAGE BODY PCK_MEDICAL_FIELD AS


END PCK_MEDICAL_FIELD;
