CLASS zcl966_rap_generate_dummy_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl966_rap_generate_dummy_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*DELETE FROM zt966_rap_bookin.

*  INSERT zt966_rap_travel FROM (
*  SELECT FROM /dmo/travel
*  FIELDS uuid(  ) as travel_uuid,
*  travel_id as travel_id,
*  agency_id as agency_id,
*  customer_id as customer_id,
*  begin_date as begin_date,
*  end_date as end_date,
*  booking_fee as booking_fee,
*  total_price as total_price,
*  currency_code as currency_code,
*  description as description,
*  CASE status
*  WHEN 'B' THEN 'A'
*  WHEN 'X' THEN 'X'
*  ELSE 'O' END AS overall_status,
*  createdby as created_by,
*  createdat as created_at,
*  lastchangedby as last_chnaged_by,
*  lastchangedat as last_changed_at
*  ORDER BY travel_id UP TO 300 Rows
*  ).
*  commit WORK.
*

    INSERT zt966_rap_bookin FROM (
  SELECT FROM /dmo/booking as a
  INNER JOIN zt966_rap_travel as b
    ON a~travel_id eq b~travel_id
  FIELDS uuid(  ) as booking_uuid,
  b~travel_uuid as travel_uuid,
  a~booking_id as booking_id,
  a~booking_date as booking_date,
  a~customer_id as customer_id,
  a~carrier_id as carrier_id,
  a~connection_id as connection_id,
  a~flight_date as flight_date,
  a~flight_price as flight_price,
  a~currency_code as currency_code,
  b~created_by as created_by,
  b~last_changed_by as last_change_by,
  b~last_changed_at as local_last_changed_by
  ).
  commit WORK.

  out->write( 'data created' ).



  ENDMETHOD.
ENDCLASS.
