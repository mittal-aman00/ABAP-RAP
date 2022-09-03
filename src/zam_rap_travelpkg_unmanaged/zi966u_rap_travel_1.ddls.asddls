@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel View - Interface View - Unmanaged'
define root view entity ZI966U_RAP_Travel_1 
as select from /dmo/travel as Travel
composition [0..*] of ZI966U_RAP_BOOKING_2 as _Booking
association [0..1] to /dmo/agency as _Agency on $projection.AgencyID = _Agency.agency_id
association [0..1] to /dmo/customer as _Customer on $projection.CustomerID = _Customer.customer_id
association [0..1] to I_Currency      as _Currency on $projection.CurrencyCode = _Currency.Currency
{
    key travel_id as TravelID,
    agency_id as AgencyID,
    customer_id as CustomerID,
    begin_date as BeginDate,
    end_date as EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    booking_fee as BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    total_price as TotalPrice,
    currency_code as CurrencyCode,
    description as Description,
    status as Status,
    @Semantics.user.createdBy: true
    createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    createdat as Createdat,
    @Semantics.user.lastChangedBy: true
    lastchangedby as Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    lastchangedat as Lastchangedat,
//    association
    _Booking,
    _Agency,
    _Customer, 
    _Currency
    
}
