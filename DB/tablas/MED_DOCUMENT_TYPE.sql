/*******************************************************************************
Description: Creation script for the table DOCUMENT_TYPE
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/
CREATE TABLE MED_USER_DBA.DOCUMENT_TYPE(
    document_type_id NUMBER(10) NOT NULL,
    document_type_abbreviation VARCHAR2(10) NOT NULL,
    description VARCHAR2(100) NOT NULL
) TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.DOCUMENT_TYPE IS 'Document different types';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.DOCUMENT_TYPE.document_type_id IS 'Document type id';
COMMENT ON COLUMN MED_USER_DBA.DOCUMENT_TYPE.document_type_abbreviation IS 'Document type abbreviation';
COMMENT ON COLUMN MED_USER_DBA.DOCUMENT_TYPE.description IS 'Document type description';