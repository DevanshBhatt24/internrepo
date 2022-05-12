class BuyerSeller {
  BuyerSeller({
    this.chg,
    this.bidQty,
    // this.change,
    this.companyName,
    this.price,
    this.sector,
    this.stockCode,
  });

  String chg;
  String bidQty;
  // String change;
  String companyName;
  String price;
  String sector;
  String stockCode;

  factory BuyerSeller.fromJson(Map<String, dynamic> json) => BuyerSeller(
        chg: json["% Chg"],
        bidQty: json["Bid Qty"],
        // change: json["Change"],
        companyName: json["Company Name"],
        price: json["Price"],
        sector: json["Sector"] == null ? null : json["Sector"],
        stockCode: json["stock_code"],
      );

  Map<String, dynamic> toJson() => {
        "% Chg": chg,
        "Bid Qty": bidQty,
        // "Change": change,
        "Company Name": companyName,
        "Price": price,
        "Sector": sector == null ? null : sector,
        "stock_code": stockCode,
      };
}
