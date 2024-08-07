import 'package:geideapay/api/response/api_response.dart';
import 'package:geideapay/api/response/other_response.dart';
import 'package:geideapay/api/response/payment_notification_api_response.dart';
import 'package:geideapay/common/my_strings.dart';
import 'package:geideapay/models/order.dart';

class OrderApiResponse extends ApiResponse {
  Order? order;
  PaymentNotificationApiResponse? paymentNotificationApiResponse;
  OtherResponse? otherResponse;

  OrderApiResponse.unknownServerResponse() {
    responseCode = '100';
    detailedResponseMessage = 'Unknown server response';
  }

  OrderApiResponse.fromMap(Map<String, dynamic> map) {
    order = map["order"] == null ? null : Order.fromMap(map["order"]);
    otherResponse = OtherResponse.fromMap(map);
    fromMap(map);
  }

  OrderApiResponse({
    responseCode,
    detailedResponseCode,
    responseMessage,
    detailedResponseMessage,
    language,
    this.order,
    this.paymentNotificationApiResponse,
    this.otherResponse,
  }) : super(
          responseCode: responseCode,
          detailedResponseCode: detailedResponseCode,
          responseMessage: responseMessage,
          detailedResponseMessage: detailedResponseMessage,
          language: language,
        );

  @override
  String toString() {
    return 'OrderApiResponse${otherResponse?.title != null ? otherResponse?.toJson() : toMap()}';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "order": order?.toMap(),
      "paymentNotificationApiResponse":
          paymentNotificationApiResponse?.toJson(),
      "responseCode": responseCode,
      "detailedResponseCode": detailedResponseCode,
      "responseMessage": responseMessage,
      "detailedResponseMessage": detailedResponseMessage,
      "language": language
    };
  }

  OrderApiResponse.defaults() {
    detailedResponseMessage = Strings.userTerminated;
  }
}
