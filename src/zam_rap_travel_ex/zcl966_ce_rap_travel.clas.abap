CLASS zcl966_ce_rap_travel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    "In order to be able to use our class as a query implementation class of our custom
    "entity our class must implement the interface if_rap_query_provider. We will thus
    "add this interface to it.

    "The interface if_rap_query_provider only offers one method which is called select.
    "Within this select method we will call the public method get_agencies( ) method.
    "The select method also expects that the incoming requests provide certain OData
    "specific query parameters. These we will set in our coding as well.
    INTERFACES if_rap_query_provider.

    "t_agency_range is used to provide filter conditions for Agenciess in form of
    "SELECT-OPTIONS to the method get_agencies( ). The second type t_business_data
    "is used to retrieve the business data returned by our remote OData service.
    "Both types are based on the abstract entity zrap_966z_travel_agency_es5 that
    "has been generated when you have generated the service consumption model.
    TYPES t_agency_range TYPE RANGE OF zrap_966z_travel_agency_es5-agencyid.
    TYPES t_business_data TYPE TABLE OF zrap_966z_travel_agency_es5.

    "The get_agencies( ) method takes filter conditions in form of SELECT-OPTIONS
    "via the importing parameter it_filter_cond. In addition it is possible to provide
    "values for top and skip to leverage client side paging.
    "Using the parameters is_data_requested and is_count_requested we tell the OData
    "client proxy whether data shall be requested from the backend or not and we can
    "specify whether in addition to the business data the total number of records of
    "this entity shall be requested as well.
    METHODS get_agencies
      IMPORTING
        filter_cond        TYPE if_rap_query_filter=>tt_name_range_pairs   OPTIONAL
        top                TYPE i OPTIONAL
        skip               TYPE i OPTIONAL
        is_data_requested  TYPE abap_bool
        is_count_requested TYPE abap_bool
      EXPORTING
        business_data      TYPE t_business_data
        count              TYPE int8
      RAISING
        /iwbep/cx_cp_remote
        /iwbep/cx_gateway
        cx_web_http_client_error
        cx_http_dest_provider_error
      .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl966_ce_rap_travel IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA business_data TYPE t_business_data.
    DATA count TYPE int8.
    DATA filter_conditions  TYPE if_rap_query_filter=>tt_name_range_pairs .
    DATA ranges_table TYPE if_rap_query_filter=>tt_range_option .
    ranges_table = VALUE #( (  sign = 'I' option = 'GE' low = '070015' ) ).
    filter_conditions = VALUE #( ( name = 'AGENCYID'  range = ranges_table ) ).

    TRY.
        get_agencies(
          EXPORTING
            filter_cond        = filter_conditions
            top                = 3
            skip               = 1
            is_count_requested = abap_true
            is_data_requested  = abap_true
          IMPORTING
            business_data  = business_data
            count          = count
          ) .
        out->write( |Total number of records = { count }| ) .
        out->write( business_data ).
      CATCH cx_root INTO DATA(exception).
        out->write( cl_message_helper=>get_latest_t100_exception( exception )->if_message~get_longtext( ) ).
    ENDTRY.

  ENDMETHOD.

  METHOD get_agencies.
    "The public method get_agencies( ) is used to retrieve the data from the remote
    "OData service. Since it is not possible to leverage the destination service in
    "the trial systems, we will use the method cl_http_destination_provider=>create_by_url
    "which allows to create a http destination object based on the target URL. As the target
    "URL we choose the root URL https://sapes5.sapdevcenter.com of the ES5 system since the
    "relative URL that points to the OData service will be added when creating the OData
    "client proxy.

    "Within the get_agencies( ) method we are creating an OData client proxy object
    "odata_client_proxy and this object creates an request object read_list_request
    "for the read operation. The read_list_request object gets all the parameters such
    "as the filter and the information whether business data and whether the total
    "number of entries is requested from the client. The read_list_requestobject returns
    "the total number of entries via the variable count and the business data via the internal
    "tablebusiness_data. If the call was successful the total number of entries and the business
    "data is written to the console. if an exception was raised the error message is retrieved
    "and written to the console.

    "In a non-Trial SAP Cloud Platform, ABAP Environment system one would leverage the destination
    "service of the underlying Cloud Foundry Environment and one would use the statement
    "cl_http_destination_provider=>create_by_cloud_destination to generate a http destination
    "in the ABAP Environment system based on these settings.
    "Since it is not possible to leverage the destination service in the trial systems,
    "we will use the method create_by_http_destination which allows to create a http client
    "object based on the target URL.
    "Here we take the root URL https://sapes5.sapdevcenter.com of the ES5 system since the
    "relative URL will be added when creating the OData client proxy.

    DATA: filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          filter_node      TYPE REF TO /iwbep/if_cp_filter_node,
          root_filter_node TYPE REF TO /iwbep/if_cp_filter_node.

    DATA: http_client        TYPE REF TO if_web_http_client,
          odata_client_proxy TYPE REF TO /iwbep/if_cp_client_proxy,
          read_list_request  TYPE REF TO /iwbep/if_cp_request_read_list,
          read_list_response TYPE REF TO /iwbep/if_cp_response_read_lst.

    DATA service_consumption_name TYPE cl_web_odata_client_factory=>ty_service_definition_name.

    DATA(http_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://sapes5.sapdevcenter.com' ).
    http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = http_destination ).

    service_consumption_name = to_upper( 'ZSC966_RAP_AGENCY' ).

    odata_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
      EXPORTING
        iv_service_definition_name = service_consumption_name
        io_http_client             = http_client
        iv_relative_service_root   = '/sap/opu/odata/sap/ZAGENCYCDS_SRV/' ).

    " Navigate to the resource and create a request for the read operation
    read_list_request = odata_client_proxy->create_resource_for_entity_set( 'Z_TRAVEL_AGENCY_ES5' )->create_request_for_read( ).

    " Create the filter tree
    filter_factory = read_list_request->create_filter_factory( ).
    LOOP AT  filter_cond  INTO DATA(filter_condition).
      filter_node  = filter_factory->create_by_range( iv_property_path     = filter_condition-name
                                                              it_range     = filter_condition-range ).
      IF root_filter_node IS INITIAL.
        root_filter_node = filter_node.
      ELSE.
        root_filter_node = root_filter_node->and( filter_node ).
      ENDIF.
    ENDLOOP.

    IF root_filter_node IS NOT INITIAL.
      read_list_request->set_filter( root_filter_node ).
    ENDIF.

    IF is_data_requested = abap_true.
      read_list_request->set_skip( skip ).
      IF top > 0 .
        read_list_request->set_top( top ).
      ENDIF.
    ENDIF.

    IF is_count_requested = abap_true.
      read_list_request->request_count(  ).
    ENDIF.

    IF is_data_requested = abap_false.
      read_list_request->request_no_business_data(  ).
    ENDIF.

    " Execute the request and retrieve the business data and count if requested
    read_list_response = read_list_request->execute( ).
    IF is_data_requested = abap_true.
      read_list_response->get_business_data( IMPORTING et_business_data = business_data ).
    ENDIF.
    IF is_count_requested = abap_true.
      count = read_list_response->get_count(  ).
    ENDIF.

  ENDMETHOD.

  METHOD if_rap_query_provider~select.

    "Within the select() method we can retrieve the details of the incoming OData call
    "using the object io_request.

    "Using the method get_paging() we can find out whether client side paging was requested
    "with the incoming OData call. Using the method get_filter() we can retrieve the filter
    "that was used by the incoming OData request and by calling the method ->get_as_ranges( )
    "provided by the filter object we can retrieve the filter as ranges.

    "Using the methods is_data_requested( ) and is_total_numb_of_rec_requested( ) we are able
    "to find out whether the incoming request requests that business data is returned and whether
    "the request contains a $count.

    "This comes in handy so we can provide this data when calling the method get_agencies()

    "If business data is requested it is mandatory to add the retrieved data via the method
    "set_data() .
    "If in addition the number of of all entries of an entity is requested the number of
    "entities being returned must be set via the method set_total_number_of_records().

    DATA business_data TYPE t_business_data.
    DATA(top)     = io_request->get_paging( )->get_page_size( ).
    DATA(skip)    = io_request->get_paging( )->get_offset( ).
    DATA(requested_fields)  = io_request->get_requested_elements( ).
    DATA(sort_order)    = io_request->get_sort_elements( ).
    DATA count TYPE int8.
    TRY.
        DATA(filter_condition) = io_request->get_filter( )->get_as_ranges( ).

        get_agencies(
                 EXPORTING
                   filter_cond        = filter_condition
                   top                = CONV i( top )
                   skip               = CONV i( skip )
                   is_data_requested  = io_request->is_data_requested( )
                   is_count_requested = io_request->is_total_numb_of_rec_requested(  )
                 IMPORTING
                   business_data  = business_data
                   count     = count
                 ) .

        IF io_request->is_total_numb_of_rec_requested(  ).
          io_response->set_total_number_of_records( count ).
        ENDIF.
        IF io_request->is_data_requested(  ).
          io_response->set_data( business_data ).
        ENDIF.

      CATCH cx_root INTO DATA(exception).
        DATA(exception_message) = cl_message_helper=>get_latest_t100_exception( exception )->if_message~get_longtext( ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
