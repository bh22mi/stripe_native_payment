
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';

//stripe keys
const String stripeMerchantKey = "your merchant id";

class StripePay {
  late String tokenId;

  void registerForStripe() async {
    StripePayment.setOptions(StripeOptions(
      publishableKey: 'stripePubKey',
      merchantId: stripeMerchantKey,
      androidPayMode: 'test', //production for live
    ));
  }

  void checkIfNativePayReady(
    BuildContext context,
    String amount,
    Function(bool, String) onPaymentCompleted,  [String? transferAmt,String? athletevueAmt,String? val]
  ) async {
    registerForStripe();
     await StripePayment.deviceSupportsNativePay().then((value) {
      if(value??false)
        {

          payThroughNativePay(context, amount, onPaymentCompleted,transferAmt??'0',athletevueAmt??'0',val??'0');
        }
      else{
        debugPrint("Not supported");

      }
    }).timeout(const Duration (seconds:5),onTimeout : (){
       debugPrint('Timeout occurred. please try again');

    }).catchError((onError){
       debugPrint(onError?.toString());
    });

  }

  void payThroughNativePay(
    BuildContext context,
    String amount,
    Function(bool, String) onPaymentCompleted, String transferAmt, String athletevueAmt, String val,
  ) async {
    var items = <ApplePayItem>[];

    //OPTONAL LINE ITEM YOU CAN ADD TO APPLE PAY SHEET
    // if(transferAmt != null)
    //   {
    //     items.add(ApplePayItem(
    //       label: "Attendance Fee to $val",
    //       amount: "$transferAmt",
    //     ));
    //
    //     items.add(ApplePayItem(
    //       label: "XYZ Service Fee (non-refundable)",
    //       amount: "$athletevueAmt",
    //     ));
    //   }
    // else
    //   {
    //     items.add(ApplePayItem(
    //       label: "XYZ Promotion ($val Days)",
    //       amount: "$amount",
    //     ));
    //   }

    items.add(ApplePayItem(
      label: "XYZ LLC",
      amount: "$amount",
    ));

    if (Platform.isIOS) {
      await StripePayment.cancelNativePayRequest();
    }

    await StripePayment.paymentRequestWithNativePay(
      androidPayOptions: AndroidPayPaymentRequest(
        currencyCode: "USD",
        totalPrice: "$amount",
      ),
      applePayOptions: ApplePayPaymentOptions(
        countryCode: 'US',
        currencyCode: 'USD',
        items: items,
      ),
    ).then((token) async {
      tokenId = token.tokenId!;
      await onPaymentCompleted(true, tokenId);
      completeNativePayment();
    }).catchError((error) async{
      cancelPaymentRequest();
      if (error is PlatformException){
        debugPrint('${error.message}.please try again');
      }else{
        debugPrint(error.toString());
      }
      await onPaymentCompleted(false, null!);
    });
  }
}

void completeNativePayment() {
  StripePayment.completeNativePayRequest().then((_) {}).catchError(print);
}

void cancelPaymentRequest() {
  StripePayment.cancelNativePayRequest().then((_) {}).catchError(print);
}
