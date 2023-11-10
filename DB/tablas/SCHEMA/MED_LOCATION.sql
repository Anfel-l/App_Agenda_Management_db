/*******************************************************************************
Description: Creation script for the table LOCATION
Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE MED_USER_DBA.LOCATION(
    location_id NUMBER(4) NOT NULL,
    location_name VARCHAR2(40) NOT NULL
)TABLESPACE MED_TS_MANAGER;

/** COMMENTS ON OBJECTS */

/** TABLE */
COMMENT ON TABLE MED_USER_DBA.LOCATION IS 'Location table';

/** COLUMNS */
COMMENT ON COLUMN MED_USER_DBA.LOCATION.LOCATION_ID IS 'Location identifier';
COMMENT ON COLUMN MED_USER_DBA.LOCATION.LOCATION_NAME IS 'Location name';