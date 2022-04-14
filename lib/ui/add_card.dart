import 'package:flutter/material.dart';
import 'package:stripe_payment_reusable/apis/transaction_api_manager.dart';
import 'package:stripe_payment_reusable/utils/masked_text_formatter.dart';
import 'package:stripe_payment_reusable/utils/month_text_formatter.dart';

import '../model/req_generate_card_token.dart';
import '../model/res_generate_card_token.dart';
import '../model/stripe_error_model.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final FocusNode _cardNumberFocus = FocusNode();
  final FocusNode _cardNameFocus = FocusNode();
  final FocusNode _cardExpiryMonthFocus = FocusNode();
  final FocusNode _cardExpiryYearFocus = FocusNode();
  final FocusNode _cardCvvNumberFocus = FocusNode();
  TextEditingController myController = TextEditingController();

  String? _cardNumber;
  String? _cardName;
  String? _cardExpiryMonth;
  String? _cardExpiryYear;
  String? _cardCvvNumber;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        autovalidate: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                _getCardNumberTextInput(),
                SizedBox(
                  height: 10,
                ),
                _getNameOnCardTextInput(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _getExpiryMonthTextInput(),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: _getExpiryYearTextInput(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                _getCvvNumberTextInput(),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: _getSaveButton(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getCardNumberTextInput() => TextField(
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.start,
        focusNode: _cardNumberFocus,
        onChanged: (value) {
          _cardNumber = value;
          setState(() {});
        },
        onSubmitted: (value) {
          _cardNumber = value;
          _cardNumberFocus.unfocus();
          FocusScope.of(context).requestFocus(_cardNameFocus);
          setState(() {});
        },
        inputFormatters: [
          MaskedTextInputFormatter(mask: 'xxxx xxxx xxxx xxxx', separator: ' ')
        ],
        keyboardType: TextInputType.phone,
      );

  Widget _getNameOnCardTextInput() => TextField(
        textAlign: TextAlign.start,
        // maxLength: maxLengthName,
        textInputAction: TextInputAction.next,
        focusNode: _cardNameFocus,
        keyboardType: TextInputType.text,
        onSubmitted: (value) {
          _cardName = value;
          _cardNameFocus.unfocus();
          FocusScope.of(context).requestFocus(_cardExpiryMonthFocus);
          setState(() {});
        },
        onChanged: (value) {
          _cardName = value;
          setState(() {});
        },
      );

  Widget _getExpiryMonthTextInput() => TextField(
        textAlign: TextAlign.start,
        maxLength: 2,
        textInputAction: TextInputAction.next,
        focusNode: _cardExpiryMonthFocus,
        keyboardType: TextInputType.phone,
        onSubmitted: (value) {
          _cardExpiryMonth = value;
          _cardExpiryMonthFocus.unfocus();
          FocusScope.of(context).requestFocus(_cardExpiryYearFocus);
          setState(() {});
        },
        onChanged: (value) {
          _cardExpiryMonth = value;
          setState(() {});
        },
        inputFormatters: [
          MonthTextInputFormatter(),
        ],
      );

  Widget _getExpiryYearTextInput() => TextField(
        textAlign: TextAlign.start,
        maxLength: 2,
        textInputAction: TextInputAction.next,
        focusNode: _cardExpiryYearFocus,
        keyboardType: TextInputType.phone,
        onSubmitted: (value) {
          _cardExpiryYear = value;
          _cardExpiryYearFocus.unfocus();
          FocusScope.of(context).requestFocus(_cardCvvNumberFocus);
          setState(() {});
        },
        onChanged: (value) {
          _cardExpiryYear = value;
          setState(() {});
        },
      );

  Widget _getCvvNumberTextInput() => TextField(
        textAlign: TextAlign.start,
        maxLength: 4,
        textInputAction: TextInputAction.next,
        focusNode: _cardCvvNumberFocus,
        keyboardType: TextInputType.phone,
        obscureText: true,
        onSubmitted: (value) {
          _cardCvvNumber = value;
          _cardCvvNumberFocus.unfocus();
          setState(() {});
        },
        onChanged: (value) {
          _cardCvvNumber = value;
        },
      );

  Widget _getSaveButton(BuildContext context) => TextButton(
        child: Text('Save'),
        onPressed: () {
          _savePressed(context);
        },
      );

  void _savePressed(BuildContext context) async {
    FocusScope.of(context).unfocus();
    _generateTokenApiCall(context);
  }

  void _generateTokenApiCall(BuildContext context) {

    TransactionApiManager()
        .generateToken(
            ReqGenerateCardToken(
                cardCvc: '111',
                cardExpMonth: '12',
                cardExpYear: '24',
                cardName: 'my test',
                cardNumber: '4242 4242 4242 4242'),
            context)
        .then((value) {
      debugPrint('valueres $value');
      //add card api call
    }).catchError((dynamic e) {
      debugPrint(e.toString());
    });
  }
}
