class PaytmResponse {
  Body body;
  Head head;

  PaytmResponse({this.body, this.head});

  PaytmResponse.fromJson(Map<String, dynamic> json) {
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    head = json['head'] != null ? new Head.fromJson(json['head']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    if (this.head != null) {
      data['head'] = this.head.toJson();
    }
    return data;
  }
}

class Body {
  String bankName;
  String bankTxnId;
  String gatewayName;
  String mid;
  String orderId;
  String paymentMode;
  String refundAmt;
  ResultInfo resultInfo;
  String txnAmount;
  String txnDate;
  String txnId;
  String txnType;

  Body(
      {this.bankName,
      this.bankTxnId,
      this.gatewayName,
      this.mid,
      this.orderId,
      this.paymentMode,
      this.refundAmt,
      this.resultInfo,
      this.txnAmount,
      this.txnDate,
      this.txnId,
      this.txnType});

  Body.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    bankTxnId = json['bankTxnId'];
    gatewayName = json['gatewayName'];
    mid = json['mid'];
    orderId = json['orderId'];
    paymentMode = json['paymentMode'];
    refundAmt = json['refundAmt'];
    resultInfo = json['resultInfo'] != null
        ? new ResultInfo.fromJson(json['resultInfo'])
        : null;
    txnAmount = json['txnAmount'];
    txnDate = json['txnDate'];
    txnId = json['txnId'];
    txnType = json['txnType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankName'] = this.bankName;
    data['bankTxnId'] = this.bankTxnId;
    data['gatewayName'] = this.gatewayName;
    data['mid'] = this.mid;
    data['orderId'] = this.orderId;
    data['paymentMode'] = this.paymentMode;
    data['refundAmt'] = this.refundAmt;
    if (this.resultInfo != null) {
      data['resultInfo'] = this.resultInfo.toJson();
    }
    data['txnAmount'] = this.txnAmount;
    data['txnDate'] = this.txnDate;
    data['txnId'] = this.txnId;
    data['txnType'] = this.txnType;
    return data;
  }
}

class ResultInfo {
  String resultCode;
  String resultMsg;
  String resultStatus;

  ResultInfo({this.resultCode, this.resultMsg, this.resultStatus});

  ResultInfo.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
    resultStatus = json['resultStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['resultMsg'] = this.resultMsg;
    data['resultStatus'] = this.resultStatus;
    return data;
  }
}

class Head {
  String responseTimestamp;
  String signature;
  String version;

  Head({this.responseTimestamp, this.signature, this.version});

  Head.fromJson(Map<String, dynamic> json) {
    responseTimestamp = json['responseTimestamp'];
    signature = json['signature'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseTimestamp'] = this.responseTimestamp;
    data['signature'] = this.signature;
    data['version'] = this.version;
    return data;
  }
}
