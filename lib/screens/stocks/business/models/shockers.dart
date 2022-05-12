class PriceShocker {
  PriceShocker({
    this.chg,
    // this.change,
    this.companyName,
    this.previousPrice,
    this.price,
    this.sector,
    this.stockCode,
  });

  String chg;
  // String change;
  String companyName;
  String previousPrice;
  String price;
  String sector;
  String stockCode;

  factory PriceShocker.fromJson(Map<String, dynamic> json, bool a) =>
      PriceShocker(
        chg: json["% Chg"],
        // change: json["Change"],
        companyName: json["Company Name"],
        previousPrice: a ? json["Previous Price"] : json["Average Volume"],
        price: json["Price"],
        sector: json["Sector"] == null ? 'null' : json["Sector"],
        stockCode: json["stock_code"],
      );

  Map<String, dynamic> toJson() => {
        "% Chg": chg,
        // "Change": change,
        "Company Name": companyName,
        "Previous Price": previousPrice,
        "Price": price,
        "Sector": sector == null ? null : sector,
        "stock_code": stockCode,
      };
}
