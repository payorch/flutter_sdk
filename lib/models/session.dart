import 'package:geideapay/api/request/base/base_request_body.dart';
import 'package:geideapay/models/appearance.dart';
import 'package:geideapay/models/paymentMethod.dart';

class Session extends BaseRequestBody {
  String? id;
  String? amount;
  String? currency;
  String? callbackUrl;
  String? returnUrl;
  String? expiryDate;
  String? status;
  String? merchantId;
  String? merchantPublicKey;
  String? language;
  String? merchantReferenceId;
  String? paymentIntentId;
  String? paymentOperation;
  bool? cardOnFile;
  String? initiatedBy;
  String? tokenId;
  String? customer;
  String? paymentOptions;
  String? recurrence;
  String? order;
  String? items;
  String? subscription;
  Appearance? appearance;
  PaymentMethod? paymentMethod;
  Platform? platform;
  CofAgreement? cofAgreement;
  Metadata? metadata;

  Session(
    this.id,
    this.amount,
    this.currency,
    this.callbackUrl,
    this.returnUrl,
    this.expiryDate,
    this.status,
    this.merchantId,
    this.merchantPublicKey,
    this.language,
    this.merchantReferenceId,
    this.paymentIntentId,
    this.paymentOperation,
    this.cardOnFile,
    this.initiatedBy,
    this.tokenId,
    this.customer,
    this.paymentOptions,
    this.recurrence,
    this.order,
    this.items,
    this.subscription,
    this.appearance,
    this.paymentMethod,
    this.platform,
    this.cofAgreement,
    this.metadata,
  );

  @override
  String toString() {
    return 'Session{id: $id, amount: $amount, currency: $currency, callbackUrl: $callbackUrl, returnUrl: $returnUrl, expiryDate: $expiryDate, status: $status, merchantId: $merchantId, merchantPublicKey: $merchantPublicKey, paymentIntentId: $paymentIntentId, paymentOperation: $paymentOperation, cardOnFile: $cardOnFile, initiatedBy: $initiatedBy, tokenId: $tokenId, customer: $customer, paymentOptions: $paymentOptions, recurrence: $recurrence, order: $order, items: $items, subscription: $subscription, appearance: $appearance, paymentMethod: $paymentMethod, platform: $platform, cofAgreement: $cofAgreement, metadata: $metadata}';
  }

  @override
  Map<String, Object?> paramsMap() {
    // set values will override additional params provided
    Map<String, Object?> params = {};
    params[BaseRequestBody.fieldShowEmail] = id;
    params[BaseRequestBody.fieldShowAddress] = amount;
    params[BaseRequestBody.fieldShowPhone] = currency;
    params[BaseRequestBody.fieldReceiptPage] = callbackUrl;
    params[BaseRequestBody.fieldUiMode] = returnUrl;
    params[BaseRequestBody.fieldUiMode] = expiryDate;
    params[BaseRequestBody.fieldUiMode] = status;
    params[BaseRequestBody.fieldUiMode] = merchantId;
    params[BaseRequestBody.fieldUiMode] = merchantPublicKey;
    params[BaseRequestBody.fieldUiMode] = language;
    params[BaseRequestBody.fieldUiMode] = merchantReferenceId;
    params[BaseRequestBody.fieldUiMode] = paymentIntentId;
    params[BaseRequestBody.fieldUiMode] = paymentOperation;
    params[BaseRequestBody.fieldUiMode] = cardOnFile;
    params[BaseRequestBody.fieldUiMode] = initiatedBy;
    params[BaseRequestBody.fieldUiMode] = tokenId;
    params[BaseRequestBody.fieldUiMode] = customer;
    params[BaseRequestBody.fieldUiMode] = paymentOptions;
    params[BaseRequestBody.fieldUiMode] = recurrence;
    params[BaseRequestBody.fieldUiMode] = order;
    params[BaseRequestBody.fieldUiMode] = items;
    params[BaseRequestBody.fieldUiMode] = subscription;

    if (appearance != null) {
      params["appearance"] = appearance!.toMap();
    }

    if (paymentMethod != null) {
      params[BaseRequestBody.fieldPaymentMethod] = paymentMethod!.toMap();
    }

    if (platform != null) {
      params["platform"] = platform!.toMap();
    }

    if (cofAgreement != null) {
      params["cofAgreement"] = cofAgreement!.toMap();
    }

    if (metadata != null) {
      params["metadata"] = metadata!.toMap();
    }

    return params
      ..removeWhere(
          (key, value) => value == null || (value is String && value.isEmpty));
  }
}

class Platform {
  String? name;
  String? version;
  String? pluginVersion;
  String? partnerId;

  Platform(this.name, this.version, this.pluginVersion, this.partnerId);

  @override
  String toString() {
    return 'Platform{name: $name, version: $version, pluginVersion: $pluginVersion, partnerId: $partnerId}';
  }

  Map<String, dynamic>? toMap() {
    Map<String, Object?> styleParams = {};
    styleParams["name"] = name;
    styleParams["version"] = version;
    styleParams["pluginVersion"] = pluginVersion;
    styleParams["partnerId"] = partnerId;
    return styleParams;
  }
}

class CofAgreement {
  String? id;
  String? type;

  CofAgreement(this.id, this.type);

  @override
  String toString() {
    return 'CofAgreement{id: $id, type: $type}';
  }

  Map<String, dynamic>? toMap() {
    Map<String, Object?> styleParams = {};
    styleParams["id"] = id;
    styleParams["type"] = type;
    return styleParams;
  }
}

class Metadata {
  String? custom;

  Metadata(this.custom);

  @override
  String toString() {
    return 'Metadata{custom: $custom}';
  }

  Map<String, dynamic>? toMap() {
    Map<String, Object?> styleParams = {};
    styleParams["custom"] = custom;
    return styleParams;
  }
}
