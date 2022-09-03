@EndUserText.label: 'Travel BO projection model - Unmanaged'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC966U_RAP_Travel_1
 as projection on ZI966U_RAP_Travel_1 {
    key TravelID,
    @Consumption.valueHelpDefinition: [ { entity: { name: '/DMO/I_Agency', element: 'AgencyID' } } ]
    @Search.defaultSearchElement: true
    AgencyID,
    @Consumption.valueHelpDefinition: [ { entity: { name: '/DMO/I_Customer', element: 'CustomerID' } } ]
    @Search.defaultSearchElement: true
    CustomerID,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Currency', element: 'Currency' } } ]
    CurrencyCode,
    Description,
    Status,
    Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    /* Associations */
    _Agency,
    _Booking : redirected to composition child ZC966U_RAP_BOOKING_2,
    _Currency,
    _Customer
}
