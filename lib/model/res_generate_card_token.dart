
import 'package:stripe_payment_reusable/model/card.dart';
import 'package:stripe_payment_reusable/model/stripe_error_model.dart';

class ResGenerateCardToken extends StripeErrorModel {
  String? id;
  String? object;
  CardDetails? card;
  String? clientIp;
  int? created;
  bool? livemode;
  String? type;
  bool? used;

  ResGenerateCardToken(
      {this.id,
      this.object,
      this.card,
      this.clientIp,
      this.created,
      this.livemode,
      this.type,
      this.used});

  ResGenerateCardToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    card = json['card'] != null ? CardDetails.fromJson(json['card']) : null;
    clientIp = json['client_ip'];
    created = json['created'];
    livemode = json['livemode'];
    type = json['type'];
    used = json['used'] != null;
  }
}
