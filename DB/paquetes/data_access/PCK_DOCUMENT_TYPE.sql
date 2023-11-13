CREATE OR REPLACE PACKAGE PCK_DOCUMENT_TYPE IS
    PROCEDURE Proc_Insert_DOCUMENT_TYPE(
        ip_document_type_abbreviation IN VARCHAR2,
        ip_description IN VARCHAR2
    );

    PROCEDURE Proc_Update_DOCUMENT_TYPE(
        ip_document_type_id IN NUMBER, 
        ip_document_type_abbreviation IN VARCHAR2,
        ip_description IN VARCHAR2
    );

    PROCEDURE Proc_Get_All_DOCUMENT_TYPE(
        Op_document_type OUT SYS_REFCURSOR
    );

    PROCEDURE Proc_Get_DOCUMENT_TYPE_BY_ID(
        ip_document_type_id IN NUMBER,
        Op_document_type OUT SYS_REFCURSOR
    );
END PCK_DOCUMENT_TYPE;

CREATE OR REPLACE PACKAGE BODY PCK_DOCUMENT_TYPE AS
    PROCEDURE Proc_Insert_DOCUMENT_TYPE(
        ip_document_type_abbreviation IN VARCHAR2,
        ip_description IN VARCHAR2
    ) IS
    v_document_type_id NUMBER; 
    BEGIN
    v_document_type_id := SEQ_DOCUMENT_TYPE.NEXTVAL;
    INSERT INTO DOCUMENT_TYPE(
        document_type_id,
        document_type_abbreviation,
        description
    ) VALUES (
        v_document_type_id,
        ip_document_type_abbreviation,
        ip_description
    );
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'A document type with abbreviation '||ip_document_type_abbreviation||' already exists.');
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Insert_DOCUMENT_TYPE;

    PROCEDURE Proc_Update_DOCUMENT_TYPE(
        ip_document_type_id IN NUMBER, 
        ip_document_type_abbreviation IN VARCHAR2,
        ip_description IN VARCHAR2
    ) IS
    BEGIN
    UPDATE DOCUMENT_TYPE SET
        document_type_abbreviation = ip_document_type_abbreviation,
        description = ip_description
    WHERE document_type_id = ip_document_type_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered -'||SQLCODE||'-ERROR-' ||SQLERRM);
    END Proc_Update_DOCUMENT_TYPE;

    PROCEDURE Proc_Get_All_DOCUMENT_TYPE(
        Op_document_type OUT SYS_REFCURSOR
    ) IS
    BEGIN
    OPEN Op_document_type FOR
        SELECT
            document_type_id,
            document_type_abbreviation,
            description
        FROM DOCUMENT_TYPE;
    EXCEPTION
        WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Foreign key constraint violation.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error was encountered - ' || SQLCODE || ' - ERROR - ' || SQLERRM);
        END IF;
    END Proc_Get_All_DOCUMENT_TYPE;

    PROCEDURE Proc_Get_DOCUMENT_TYPE_BY_ID(
        ip_document_type_id IN NUMBER,
        Op_document_type OUT SYS_REFCURSOR
    ) IS
    BEGIN
    OPEN Op_document_type FOR
        SELECT /*+ INDEX(dt PK_DOCUMENT_TYPE) */
            document_type_id,
            document_type_abbreviation,
            description
        FROM DOCUMENT_TYPE dt
        WHERE dt.document_type_id = ip_document_type_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An error was encountered -'||SQLCODE||'-ERROR-' ||SQLERRM);
    END Proc_Get_DOCUMENT_TYPE_BY_ID;
END PCK_DOCUMENT_TYPE;
