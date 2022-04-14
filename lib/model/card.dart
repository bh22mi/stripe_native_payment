class CardDetails {

  String? id;
  String? object;
	String? addressCity;
	String? addressCountry;
	String? addressLine1;
	String? addressline1Check;
	String? addressLine2;
	String? addressState;
	String? addressZip;
	String? addressZipCheck;
  String? brand;
  String? country;
  String? cvcCheck;
	String? dynamicLast4;
  int? expMonth;
  int? expYear;
  String? funding;
  String? last4;
  Metadata? metadata;
	String? name;
	String? tokenizationMethod;

	CardDetails.fromJson(Map<String, dynamic> map): 
		id = map["id"];
		// object = map["object"],
		// addressCity = map["address_city"],
		// addressCountry = map["address_country"],
		// addressLine1 = map["address_line1"],
		// addressline1Check = map["address_line1_check"],
		// addressLine2 = map["address_line2"],
		// addressState = map["address_state"],
		// addressZip = map["address_zip"],
		// addressZipCheck = map["address_zip_check"],
		// brand = map["brand"],
		// country = map["country"],
		// cvcCheck = map["cvc_check"],
		// dynamicLast4 = map["dynamic_last4"],
		// expMonth = map["exp_month"],
		// expYear = map["exp_year"],
		// funding = map["funding"],
		// last4 = map["last4"],
		// metadata = Metadata.fromJson(map["metadata"]),
		// name = map["name"],
		// tokenizationMethod = map["tokenization_method"];
}

class Metadata {
	Metadata();

	Metadata.fromJson(Map<String, dynamic> json);
}