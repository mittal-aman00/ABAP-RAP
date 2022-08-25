CLASS zcl966_rap_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl966_rap_1 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( | HELLO WORLD ({ cl_abap_context_info=>get_system_date( ) }) | ).
  ENDMETHOD.

ENDCLASS.
