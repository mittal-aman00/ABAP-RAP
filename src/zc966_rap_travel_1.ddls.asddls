@EndUserText.label: 'Travel BO projection model'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC966_RAP_Travel_1
  provider contract transactional_query
  as projection on ZI966_RAP_Travel_1 as Travel
{
  key TravelUUID,
      @Search.defaultSearchElement: true
      TravelID,
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity : { name : '/DMO/I_Agency', element: 'AgencyID' } }]
      @ObjectModel.text.element: ['AgencyName']
      AgencyID,
      _Agency.Name       as AgencyName,
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity : { name : '/DMO/I_Customer', element : 'CustomerID'  } }]
      @ObjectModel.text.element: ['CustomerName']
      CustomerID,
      _Customer.LastName as CustomerName,
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      @Consumption.valueHelpDefinition: [{ entity : { name : 'I_Currency', element : 'Currency' } }]
      CurrencyCode,
      Description,
      TravelStatus,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZC966_RAP_Booking_1,
      _Currency,
      _Customer
}
