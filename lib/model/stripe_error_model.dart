class StripeErrorModel {

	Error? error;

  StripeErrorModel({this.error});

	StripeErrorModel.fromJson(Map<String, dynamic> map): 
		error = Error.fromJson(map["error"]);

	Map<String, dynamic> toJson() {
		final data = <String, dynamic>{};
		data['error'] = error == null ? null : error?.toJson();
		return data;
	}
}


class Error {

	String code;
	String docUrl;
	String message;
	String param;
	String type;

	Error.fromJson(Map<String, dynamic> map):
				code = map["code"],
				docUrl = map["doc_url"],
				message = map["message"],
				param = map["param"],
				type = map["type"];

	Map<String, dynamic> toJson() {
		final data = <String, dynamic>{};
		data['code'] = code;
		data['doc_url'] = docUrl;
		data['message'] = message;
		data['param'] = param;
		data['type'] = type;
		return data;
	}
}
