// To parse this JSON data, do
//
//     final ipoModel = ipoModelFromJson(jsonString);

import 'dart:convert';

List<IpoModel> ipoModelFromJson(String str) =>
    List<IpoModel>.from(json.decode(str).map((x) => IpoModel.fromJson(x)));

String ipoModelToJson(List<IpoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IpoModel {
  IpoModel({
    this.data,
    this.identifier,
  });

  Data data;
  String identifier;

  factory IpoModel.fromJson(Map<String, dynamic> json) => IpoModel(
        data: Data.fromJson(json["data"]),
        identifier: json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "identifier": identifier,
      };
}

class Data {
  Data({
    this.current,
    this.past,
    this.upcoming,
  });

  List<Current> current;
  List<Current> past;
  List<Upcoming> upcoming;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        current:
            List<Current>.from(json["current"].map((x) => Current.fromJson(x))),
        past: List<Current>.from(json["past"].map((x) => Current.fromJson(x))),
        upcoming: List<Upcoming>.from(
            json["upcoming"].map((x) => Upcoming.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current": List<dynamic>.from(current.map((x) => x.toJson())),
        "past": List<dynamic>.from(past.map((x) => x.toJson())),
        "upcoming": List<dynamic>.from(upcoming.map((x) => x.toJson())),
      };
}

class Current {
  Current({
    this.companyName,
    this.ipoSizeApprox,
    this.ipoUrl,
    this.issueClosingDate,
    this.issueOpeningDate,
    this.minLotSize,
    this.priceBand,
  });

  String companyName;
  String ipoSizeApprox;
  String ipoUrl;
  String issueClosingDate;
  String issueOpeningDate;
  String minLotSize;
  String priceBand;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        companyName: json["company_name"],
        ipoSizeApprox: json["ipo_size_approx"],
        ipoUrl: json["ipo_url"],
        issueClosingDate: json["issue_closing_date"],
        issueOpeningDate: json["issue_opening_date"],
        minLotSize: json["min_lot_size"],
        priceBand: json["price_band"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "ipo_size_approx": ipoSizeApprox,
        "ipo_url": ipoUrl,
        "issue_closing_date": issueClosingDate,
        "issue_opening_date": issueOpeningDate,
        "min_lot_size": minLotSize,
        "price_band": priceBand,
      };
}

class Upcoming {
  Upcoming({
    this.companyName,
    this.ipoSize,
    this.tentativeDates,
  });

  String companyName;
  String ipoSize;
  String tentativeDates;

  factory Upcoming.fromJson(Map<String, dynamic> json) => Upcoming(
        companyName: json["company_name"],
        ipoSize: json["ipo_size"],
        tentativeDates: json["tentative_dates"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "ipo_size": ipoSize,
        "tentative_dates": tentativeDates,
      };
}

// new models

class Ipo2 {
  int id;
  String securityName;
  String openDate;
  String closeDate;
  String issuePriceMin;
  String issuePriceMax;
  String issuePrice;
  String listingDate;
  String totalNos;
  String totalNosBidFor;
  String grandTotal;
  String status;
  String securitySlug;

  Ipo2(
      {this.id,
      this.securityName,
      this.openDate,
      this.closeDate,
      this.issuePriceMin,
      this.issuePriceMax,
      this.issuePrice,
      this.listingDate,
      this.totalNos,
      this.totalNosBidFor,
      this.grandTotal,
      this.status,
      this.securitySlug});

  Ipo2.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    securityName = json['SecurityName'].toString();
    openDate = json['OpenDate'].toString();
    closeDate = json['CloseDate'].toString();
    issuePriceMin = json['IssuePriceMin'].toString();
    issuePriceMax = json['IssuePriceMax'].toString();
    issuePrice = json['IssuePrice'].toString();
    listingDate = json['ListingDate'].toString();
    totalNos = json['Total_Nos'].toString();
    totalNosBidFor = json['Total_NosBidFor'].toString();
    grandTotal = json['GrandTotal'].toString();
    status = json['Status'].toString();
    securitySlug = json['SecuritySlug'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['SecurityName'] = this.securityName;
    data['OpenDate'] = this.openDate;
    data['CloseDate'] = this.closeDate;
    data['IssuePriceMin'] = this.issuePriceMin;
    data['IssuePriceMax'] = this.issuePriceMax;
    data['IssuePrice'] = this.issuePrice;
    data['ListingDate'] = this.listingDate;
    data['Total_Nos'] = this.totalNos;
    data['Total_NosBidFor'] = this.totalNosBidFor;
    data['GrandTotal'] = this.grandTotal;
    data['Status'] = this.status;
    data['SecuritySlug'] = this.securitySlug;
    return data;
  }
}


class UpcomingIpo2 {
  int id;
  String securityName;
  String openDate;
  String closeDate;
  String issuePriceMin;
  String issuePriceMax;
  String issueSizeMin;
  String issueSizeMax;
  String listingDate;
  String securitySlug;

  UpcomingIpo2(
      {this.id,
      this.securityName,
      this.openDate,
      this.closeDate,
      this.issuePriceMin,
      this.issuePriceMax,
      this.issueSizeMin,
      this.issueSizeMax,
      this.listingDate,
      this.securitySlug});

  UpcomingIpo2.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    securityName = json['SecurityName'].toString();
    openDate = json['OpenDate'].toString();
    closeDate = json['CloseDate'].toString();
    issuePriceMin = json['IssuePriceMin'].toString();
    issuePriceMax = json['IssuePriceMax'].toString();
    issueSizeMin = json['IssueSizeMin'].toString();
    issueSizeMax = json['IssueSizeMax'].toString();
    listingDate = json['ListingDate'].toString();
    securitySlug = json['SecuritySlug'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['SecurityName'] = this.securityName;
    data['OpenDate'] = this.openDate;
    data['CloseDate'] = this.closeDate;
    data['IssuePriceMin'] = this.issuePriceMin;
    data['IssuePriceMax'] = this.issuePriceMax;
    data['IssueSizeMin'] = this.issueSizeMin;
    data['IssueSizeMax'] = this.issueSizeMax;
    data['ListingDate'] = this.listingDate;
    data['SecuritySlug'] = this.securitySlug;
    return data;
  }
}



