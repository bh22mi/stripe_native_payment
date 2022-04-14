class ReqGenerateCardToken {
  String? cardNumber;
  String? cardExpMonth;
  String? cardExpYear;
  String? cardCvc;
  String? cardName;

  ReqGenerateCardToken(
      {this.cardNumber,
      this.cardExpMonth,
      this.cardExpYear,
      this.cardCvc,
      this.cardName});

  Map<String?, dynamic> toJson() {
    final data = <String?, dynamic>{};
    data['card[number]'] = cardNumber;
    data['card[exp_month]'] = cardExpMonth;
    data['card[exp_year]'] = cardExpYear;
    data['card[cvc]'] = cardCvc;
    data['card[name]'] = cardName;
    return data;
  }
}
