CLASS zcl966_rap_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl966_rap_eml IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**********************************************************************
*  "read with certain fields only
*  READ ENTITIES OF ZI966_RAP_Travel_1
*  ENTITY Travel
*  FIELDS ( TravelID AgencyID CurrencyCode CustomerID TravelStatus )
*  WITH VALUE #( ( TravelUUID = 'DD0A43F08477E922180044A6B2D31E65' ) )
*  RESULT DATA(lt_travels).
*  out->write( lt_travels ).
**********************************************************************

**********************************************************************
*  "read with All fields Like Select *
*  READ ENTITIES OF ZI966_RAP_Travel_1 "Behavior Definition
*  ENTITY Travel
*  ALL FIELDS
*  WITH VALUE #( ( TravelUUID = 'DD0A43F08477E922180044A6B2D31E65' ) )
*  RESULT DATA(lt_travels1).
*  out->write( lt_travels ).
**********************************************************************

**********************************************************************
*  "read with no fields Like Select Count(*) - Check existence
*  "This will only fetch the TravelUUID value
*  READ ENTITIES OF ZI966_RAP_Travel_1 "Behavior Definition
*  ENTITY Travel
*  FROM VALUE #( ( TravelUUID = 'DD0A43F08477E922180044A6B2D31E65' ) )
*  RESULT DATA(lt_travels2).
*  out->write( lt_travels2 ).
**********************************************************************

**********************************************************************
*  READ ENTITIES OF ZI966_RAP_Travel_1
*  ENTITY Travel BY \_Booking
*  ALL FIELDS
*  WITH VALUE #( ( TravelUUID = 'DD0A43F08477E922180044A6B2D31E65' ) )
*  RESULT DATA(lt_booking).
*  out->write( lt_booking ).
**********************************************************************

**********************************************************************
*  "CAse when travel UUID is not found in the DB table
*  "Catch data in FAILED DATA table
*  "Failed is used to convey unsuccessful operations.
*  "Reported is optionally used to provide related T100 messages.
*  READ ENTITIES OF ZI966_RAP_Travel_1
*  ENTITY Travel
*  ALL FIELDS
*  WITH VALUE #( ( TravelUUID = '0000000000000000' ) )
*  RESULT DATA(lt_travel4)
*  FAILED DATA(lt_failed)
*  REPORTED DATA(lt_reported).
*
*  out->write( lt_travel4 ).
*  out->write( lt_failed ).      " complex structures not supported by the console output
*  out->write( lt_reported ).    " complex structures not supported by the console output
                                 " Check the complex structures in the debug mode
**********************************************************************

**********************************************************************
*    "Modify-Update the existing data
*    MODIFY ENTITIES OF ZI966_RAP_Travel_1
*    ENTITY Travel
*    UPDATE
*    SET FIELDS
*    WITH VALUE #( ( TravelUUID = 'DD0A43F08477E922180044A6B2D31E65'
*                    Description = 'Updated using RAP' ) )
*    FAILED DATA(lt_failed)
*    REPORTED DATA(lt_reported).
*    "Both Commit Work and Commit Entities work.
*    "If you want to see the Failed and Reported tables then use COMMIT ENTITIES
*    COMMIT WORK .
*    "OR
*    COMMIT ENTITIES
*       RESPONSE OF ZI966_RAP_Travel_1
*       FAILED     DATA(lt_failed_commit)
*       REPORTED   DATA(lt_reported_commit).
*
*    out->write( 'Value Updated' ).
**********************************************************************

**********************************************************************
*    "Modify-Create new data
*    MODIFY ENTITIES OF ZI966_RAP_Travel_1
*    ENTITY Travel
*    CREATE
*    SET FIELDS WITH VALUE #( ( %cid = 'MyContentID_2'
*                               AgencyID    = '70012'
*                               CustomerID  = '14'
*                               BeginDate   = cl_abap_context_info=>get_system_date( )
*                               EndDate     = cl_abap_context_info=>get_system_date( ) + 10
*                               Description = 'Newly Created AM2' ) )
*    MAPPED DATA(lt_mapped)
*    FAILED DATA(lt_failed1)
*    REPORTED DATA(lt_reported).
*
*    out->write( 'Create Mapping Done' ).
*    out->write( lt_mapped-travel ).
*
*    COMMIT ENTITIES
*        RESPONSE OF ZI966_RAP_Travel_1
*        FAILED DATA(lt_failed_commit)
*        REPORTED DATA(lt_reported_commit).
*
*     out->write( 'Create Commit Done' ).
**********************************************************************

**********************************************************************
    "Modify-Delete data using TravelUUid
    MODIFY ENTITIES OF ZI966_RAP_Travel_1
    ENTITY Travel
    DELETE
    FROM VALUE #( ( TravelUUID = '1234CCCC2C7B1EDD89C6C550948D205C' ) )
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).

    COMMIT ENTITIES
        RESPONSE OF ZI966_RAP_Travel_1
        FAILED DATA(lt_failed_commit)
        REPORTED DATA(lt_reported_commit).

    out->write(  'Data Deleted').
**********************************************************************

  ENDMETHOD.
ENDCLASS.
