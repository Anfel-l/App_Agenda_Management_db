/*******************************************************************************
Description: Creation script for the type TIME_RANGE_TYPE
which is used to represent a time range.

Author: Andrés Felipe Lugo Rodríguez
Date: 17/10/2023
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE OR REPLACE TYPE TIME_RANGE_TYPE AS OBJECT (
    start_time TIMESTAMP,
    end_time TIMESTAMP
);