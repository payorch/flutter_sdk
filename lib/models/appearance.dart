import 'package:geideapay/api/request/base/base_request_body.dart';

class Appearance extends BaseRequestBody {
  bool? showEmail;
  bool? showAddress;
  bool? showPhone;
  bool? receiptPage;
  String? uiMode;
  Styles? styles;
  Merchant? merchant;

  Appearance({
    this.showEmail,
    this.showAddress,
    this.showPhone,
    this.receiptPage,
    this.uiMode,
    this.styles,
    this.merchant,
  });

  @override
  String toString() {
    return 'Appearance{showEmail: $showEmail, showAddress: $showAddress, showPhone: $showPhone, receiptPage: $receiptPage, uiMode: $uiMode, styles: $styles, merchant: $merchant}';
  }

  @override
  Map<String, Object?> paramsMap() {
    // set values will override additional params provided
    Map<String, Object?> params = {};
    params[BaseRequestBody.fieldShowEmail] = showEmail;
    params[BaseRequestBody.fieldShowAddress] = showAddress;
    params[BaseRequestBody.fieldShowPhone] = showPhone;
    params[BaseRequestBody.fieldReceiptPage] = receiptPage;
    params[BaseRequestBody.fieldUiMode] = uiMode;

    if (styles != null) {
      params[BaseRequestBody.fieldStyles] = styles!.toMap();
    }

    if (merchant != null) {
      params["merchant"] = merchant!.toMap();
    }

    return params
      ..removeWhere(
          (key, value) => value == null || (value is String && value.isEmpty));
  }

  Map<String, dynamic>? toMap() {
    Map<String, Object?> params = {};
    params[BaseRequestBody.fieldShowEmail] = showEmail;
    params[BaseRequestBody.fieldShowAddress] = showAddress;
    params[BaseRequestBody.fieldShowPhone] = showPhone;
    params[BaseRequestBody.fieldReceiptPage] = receiptPage;
    params[BaseRequestBody.fieldUiMode] = uiMode;

    if (styles != null) {
      params[BaseRequestBody.fieldStyles] = styles!.toMap();
    }

    if (merchant != null) {
      params["merchant"] = merchant!.toMap();
    }
    return params;
  }
}

class Styles {
  bool? hideGeideaLogo;
  String? headerColor;
  String? hppProfile;

  Styles(this.hideGeideaLogo, this.headerColor, this.hppProfile);

  @override
  String toString() {
    return 'Styles{hideGeideaLogo: $hideGeideaLogo}';
  }

  Map<String, dynamic>? toMap() {
    Map<String, Object?> styleParams = {};
    styleParams[BaseRequestBody.fieldHideGeideaLogo] = hideGeideaLogo;
    return styleParams;
  }
}

class Merchant {
  String? name;
  String? logoUrl;

  Merchant(
    this.name,
    this.logoUrl,
  );

  @override
  String toString() {
    return 'Merchant{name: $name, logoUrl: $logoUrl}';
  }

  Map<String, dynamic>? toMap() {
    Map<String, Object?> styleParams = {};
    styleParams["name"] = name;
    styleParams["logoUrl"] = logoUrl;
    return styleParams;
  }
}
