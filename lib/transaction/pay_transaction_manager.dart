import 'dart:async';

import 'package:geideapay/api/request/cancel_request_body.dart';
import 'package:geideapay/api/request/capture_request_body.dart';
import 'package:geideapay/api/request/pay_direct_request_body.dart';
import 'package:geideapay/api/request/pay_token_request_body.dart';
import 'package:geideapay/api/request/refund_request_body.dart';
import 'package:geideapay/api/request/request_to_pay_request_body.dart';
import 'package:geideapay/api/service/contracts/pay_service_contract.dart';
import 'package:geideapay/common/exceptions.dart';
import 'package:geideapay/common/my_strings.dart';
import 'package:geideapay/api/response/order_api_response.dart';
import 'package:geideapay/transaction/base_transaction_manager.dart';

import '../api/response/request_pay_api_response.dart';

class PayTransactionManager extends BaseTransactionManager {
  PayDirectRequestBody? payDirectRequestBody;
  PayTokenRequestBody? payTokenRequestBody;
  final PayServiceContract service;
  RefundRequestBody? refundRequestBody;
  CancelRequestBody? cancelRequestBody;
  CaptureRequestBody? captureRequestBody;
  RequestToPayRequestBody? requestToPayRequestBody;
  String? merchantPublicKey;
  String? orderId;
  PayTransactionManager(
      {required this.service,
      this.payDirectRequestBody,
      this.payTokenRequestBody,
      this.refundRequestBody,
      this.captureRequestBody,
      this.cancelRequestBody,
      this.requestToPayRequestBody,
      this.merchantPublicKey,
      this.orderId,
      required String publicKey,
      required String apiPassword,
      required String baseUrl})
      : super(publicKey: publicKey, apiPassword: apiPassword, baseUrl: baseUrl);

  @override
  postInitiate() {}

  Future<OrderApiResponse> payDirect() async {
    try {
      await initiate();
      return sendPayDirectOnServer();
    } catch (e) {
      if (e is! ProcessingException) {
        setProcessingOff();
      }
      return OrderApiResponse(
          detailedResponseMessage: e.toString(), responseCode: "-1");
    }
  }

  Future<OrderApiResponse> sendPayDirectOnServer() {
    Future<OrderApiResponse> future = service.directPay(
        payDirectRequestBody?.paramsMap(), publicKey, apiPassword, baseUrl);
    return handlePayDirectApiServerResponse(future);
  }

  Future<OrderApiResponse> handlePayDirectApiServerResponse(
      Future<OrderApiResponse> future) async {
    try {
      final apiResponse = await future;
      return _initApiResponse(apiResponse);
    } catch (e) {
      return notifyPayProcessingError(e);
    }
  }

  Future<OrderApiResponse> refund() async {
    try {
      await initiate();
      return sendRefundOnServer();
    } catch (e) {
      if (e is! ProcessingException) {
        setProcessingOff();
      }
      return OrderApiResponse(
          detailedResponseMessage: e.toString(), responseCode: "-1");
    }
  }

  Future<OrderApiResponse> sendRefundOnServer() {
    Future<OrderApiResponse> future = service.refund(
        refundRequestBody?.paramsMap(), publicKey, apiPassword, baseUrl);
    return handlePostPayOperationApiServerResponse(future);
  }

  Future<OrderApiResponse> cancel() async {
    try {
      await initiate();
      return sendCancelOnServer();
    } catch (e) {
      if (e is! ProcessingException) {
        setProcessingOff();
      }
      return OrderApiResponse(
          detailedResponseMessage: e.toString(), responseCode: "-1");
    }
  }

  Future<OrderApiResponse> sendCancelOnServer() {
    Future<OrderApiResponse> future = service.cancel(
        cancelRequestBody?.paramsMap(), publicKey, apiPassword, baseUrl);
    return handlePostPayOperationApiServerResponse(future);
  }

  Future<OrderApiResponse> voidOperation() async {
    try {
      await initiate();
      return sendVoidOnServer();
    } catch (e) {
      if (e is! ProcessingException) {
        setProcessingOff();
      }
      return OrderApiResponse(
          detailedResponseMessage: e.toString(), responseCode: "-1");
    }
  }

  Future<OrderApiResponse> sendVoidOnServer() {
    Future<OrderApiResponse> future = service.voidOperation(
        refundRequestBody?.paramsMap(), publicKey, apiPassword, baseUrl);
    return handlePostPayOperationApiServerResponse(future);
  }

  Future<OrderApiResponse> capture() async {
    try {
      await initiate();
      return sendCaptureOnServer();
    } catch (e) {
      if (e is! ProcessingException) {
        setProcessingOff();
      }
      return OrderApiResponse(
          detailedResponseMessage: e.toString(), responseCode: "-1");
    }
  }

  Future<OrderApiResponse> sendCaptureOnServer() {
    Future<OrderApiResponse> future = service.capture(
        captureRequestBody?.paramsMap(), publicKey, apiPassword, baseUrl);
    return handlePostPayOperationApiServerResponse(future);
  }

  Future<RequestPayApiResponse> requestToPay() async {
    try {
      await initiate();
      return sendRequestToPayOnServer();
    } catch (e) {
      if (e is! ProcessingException) {
        setProcessingOff();
      }
      return RequestPayApiResponse(
          detailedResponseMessage: e.toString(), responseCode: "-1");
    }
  }

  Future<RequestPayApiResponse> sendRequestToPayOnServer() {
    Future<RequestPayApiResponse> future = service.requestToPay(
        requestToPayRequestBody?.paramsMap(), publicKey, apiPassword, baseUrl);
    return handleRequestToPayApiServerResponse(future);
  }

  Future<OrderApiResponse> getOrderDetail() async {
    try {
      await initiate();
      return sendOrderDetailOnServer();
    } catch (e) {
      if (e is! ProcessingException) {
        setProcessingOff();
      }
      return OrderApiResponse(
          detailedResponseMessage: e.toString(), responseCode: "-1");
    }
  }

  Future<OrderApiResponse> sendOrderDetailOnServer() {
    Future<OrderApiResponse> future = service.orderDetail(
        merchantPublicKey!, orderId!, publicKey, apiPassword, baseUrl);
    return handlePostPayOperationApiServerResponse(future);
  }

  Future<OrderApiResponse> handlePostPayOperationApiServerResponse(
      Future<OrderApiResponse> future) async {
    try {
      final apiResponse = await future;
      return _initApiResponse(apiResponse);
    } catch (e) {
      return notifyPayProcessingError(e);
    }
  }

  Future<OrderApiResponse> _initApiResponse(OrderApiResponse? apiResponse) {
    apiResponse ??= OrderApiResponse.unknownServerResponse();

    return handleOrderApiResponse(apiResponse);
  }

  Future<OrderApiResponse> handleOrderApiResponse(
      OrderApiResponse apiResponse) async {
    var status = apiResponse.responseMessage?.toLowerCase();
    var code = apiResponse.responseCode?.toLowerCase();
    if (code == '000') {
      setProcessingOff();
      return onPaySuccess(apiResponse);
    }

    if (code != '000') {
      if (apiResponse.otherResponse != null) {
        setProcessingOff();
        return onPaySuccess(apiResponse);
      } else {
        return notifyPayProcessingError(
            AuthenticationException(apiResponse.detailedResponseMessage!));
      }
    }

    return notifyPayProcessingError(GeideaException(Strings.unKnownResponse));
  }

  Future<RequestPayApiResponse> handleRequestToPayApiServerResponse(
      Future<RequestPayApiResponse> future) async {
    try {
      final apiResponse = await future;
      return _initRequestToPayApiResponse(apiResponse);
    } catch (e) {
      return notifyRequestPayProcessingError(e);
    }
  }

  Future<RequestPayApiResponse> _initRequestToPayApiResponse(
      RequestPayApiResponse? apiResponse) {
    apiResponse ??= RequestPayApiResponse.unknownServerResponse();
    return handleRequestToPayApiResponse(apiResponse);
  }

  Future<RequestPayApiResponse> handleRequestToPayApiResponse(
      RequestPayApiResponse apiResponse) async {
    var code = apiResponse.responseCode?.toLowerCase();

    if (code == '00000') {
      setProcessingOff();
      return onRequestPaySuccess(apiResponse);
    }

    if (code != '00000') {
      return notifyRequestPayProcessingError(
          AuthenticationException(apiResponse.responseDescription.toString()));
    }

    return notifyRequestPayProcessingError(
        GeideaException(Strings.unKnownResponse));
  }
}
