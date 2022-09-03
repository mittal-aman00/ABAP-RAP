/********** GENERATED on 09/02/2022 at 22:02:24 by CB9980011115**************/
 @OData.entitySet.name: 'Z_TRAVEL_AGENCY_ES5' 
 @OData.entityType.name: 'Z_TRAVEL_AGENCY_ES5Type' 
 define root abstract entity ZRAP_966Z_TRAVEL_AGENCY_ES5 { 
 key AgencyId : abap.numc( 6 ) ; 
 @Odata.property.valueControl: 'Name_vc' 
 Name : abap.char( 31 ) ; 
 Name_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Street_vc' 
 Street : abap.char( 30 ) ; 
 Street_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PostalCode_vc' 
 PostalCode : abap.char( 10 ) ; 
 PostalCode_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'City_vc' 
 City : abap.char( 25 ) ; 
 City_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Country_vc' 
 Country : abap.char( 3 ) ; 
 Country_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PhoneNumber_vc' 
 PhoneNumber : abap.char( 30 ) ; 
 PhoneNumber_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'WebAddress_vc' 
 WebAddress : abap.char( 255 ) ; 
 WebAddress_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
