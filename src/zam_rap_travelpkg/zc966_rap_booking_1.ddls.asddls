@EndUserText.label: 'Booking BO projection model'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC966_RAP_Booking_1
  as projection on ZI966_RAP_Booking_1
{
  key BookingUUID,
      TravelUUID,
      @Search.defaultSearchElement: true
      BookingID,
      BookingDate,
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity : {name : '/DMO/I_Customer', element : 'CustomrID' } }]
      @ObjectModel.text.element: ['CustomerName']
      CustomerID,
      _Customer.LastName as CustomerName,
      @Consumption.valueHelpDefinition: [{ entity : { name : '/DMO/I_Carrier', element : 'CarrierID' } }]
      @ObjectModel.text.element: ['CarrierName']
      CarrierID,
      _Carrier.Name      as CarrierName,
      @Consumption.valueHelpDefinition: [{ entity : { name : '/DMO/I_Flight', element : 'ConnectionID' },
                                                    additionalBinding: [ { localElement : 'CarrierID', element : 'AirlineID' },
                                                                         { localElement : 'Flightdate', element : 'FlightDate', usage: #RESULT },
                                                                         { localElement : 'FlightPrice', element : 'Price', usage: #RESULT },
                                                                         { localElement : 'CurrencyCode', element : 'CurrencyCode', usage: #RESULT} ]
                                                    }]
      ConnectionID,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      @Consumption.valueHelpDefinition: [{ entity : {name : 'I_Currency', element: 'Currency'} }]
      CurrencyCode,
      CreatedBy,
      LastChangedBy,
      LocalLastChnagedAt,
      /* Associations */
      _Carrier,
      _Customer,
      _Travel : redirected to parent ZC966_RAP_Travel_1
}
