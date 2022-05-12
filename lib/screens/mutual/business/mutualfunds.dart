// To parse this JSON data, do
//
//     final mutualFundsModel = mutualFundsModelFromJson(jsonString);

import 'dart:convert';

// List<MutualFundsModel> mutualFundsModelFromJson(String str) =>
//     List<MutualFundsModel>.from(
//         json.decode(str).map((x) => MutualFundsModel.fromJson(x)));

List<Fund> fundsModelFromJson(String str) =>
    List<Fund>.from(json.decode(str)[0]["funds"].map((x) => Fund.fromJson(x)));

// String mutualFundsModelToJson(List<MutualFundsModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class MutualFundsModel {
//   MutualFundsModel({
//     this.funds,
//   });

//   List<Fund> funds;

//   factory MutualFundsModel.fromJson(Map<String, dynamic> json) =>
//       MutualFundsModel(
//         funds: List<Fund>.from(json["funds"].map((x) => Fund.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "funds": List<dynamic>.from(funds.map((x) => x.toJson())),
//       };
// }

class Fund {
  Fund({
    this.expenseRatio,
    this.id,
    this.latestNav,
    this.name,
    this.rating,
    this.return1Month,
    this.return1Year,
    this.return3Month,
    this.return3Year,
    this.return5Year,
    this.return6Month,
    this.riskRating,
    this.size,
  });

  double expenseRatio;
  String id;
  double latestNav;
  String name;
  String rating;
  dynamic return1Month;
  dynamic return1Year;
  dynamic return3Month;
  dynamic return3Year;
  dynamic return5Year;
  dynamic return6Month;
  String riskRating;
  String size;

  factory Fund.fromJson(Map<String, dynamic> json) => Fund(
        expenseRatio: json["expense_ratio"].toDouble(),
        id: json["id"],
        latestNav: json["latest_nav"].toDouble(),
        name: json["name"],
        rating: json["rating"],
        return1Month: json["return_1month"],
        return1Year: json["return_1year"],
        return3Month: json["return_3month"],
        return3Year: json["return_3year"],
        return5Year: json["return_5year"],
        return6Month: json["return_6month"],
        riskRating: json["risk_rating"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "expense_ratio": expenseRatio,
        "id": id,
        "latest_nav": latestNav,
        "name": name,
        "rating": rating,
        "return_1month": return1Month,
        "return_1year": return1Year,
        "return_3month": return3Month,
        "return_3year": return3Year,
        "return_5year": return5Year,
        "return_6month": return6Month,
        "risk_rating": riskRating,
        "size": size,
      };
}

class MutualWatchlistModel {
  String title, id;
  MutualWatchlistModel({this.title, this.id});

  factory MutualWatchlistModel.fromJson(Map<String, dynamic> json) =>
      MutualWatchlistModel( title: json["title"], id: json["id"]);

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id
  };
}
