import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment_reusable/model/req_generate_card_token.dart';
import 'package:stripe_payment_reusable/model/res_generate_card_token.dart';

import '../model/stripe_error_model.dart';

const String apiGenerateCardToken = "https://api.stripe.com/v1/tokens";

class TransactionApiManager {
  Future<ResGenerateCardToken> generateToken(
      ReqGenerateCardToken request, BuildContext context) async {
    try {
      //make an api call to direct stripe to fetch card token
      final response = await ApiService().post(
        apiGenerateCardToken,
        data: request.toJson(),
      );
      return ResGenerateCardToken.fromJson(response.data);
    } on DioError catch (error) {
      debugPrint('$error');
      throw StripeErrorModel.fromJson(error.response?.data);
    }
  }
}

class ApiService {
  static final Dio mDio = Dio();

  Future<Response> post(
    String endUrl, {
    dynamic data,
  }) async {
    try {
      mDio.options.headers['authorization'] =
          "Bearer stripepubkey"; //replace your stripe public key here
      mDio.options.contentType = 'application/x-www-form-urlencoded';

      return await (mDio.post(
        endUrl,
        data: data,
      )).catchError((e) {
        debugPrint('$e');
        throw e;
      });
    } on DioError {
      debugPrint('DioError');

      rethrow;
    }
  }
}
