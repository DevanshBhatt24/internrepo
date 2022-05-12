class AllStockResponse {
  String change;
  String changePercentage;
  String name;
  String lastPrice;
  String sortedBy;
  String stockCode;
  String marketCap;
  String isin;

  AllStockResponse(
      {this.change,
      this.changePercentage,
      this.name,
      this.lastPrice,
      this.sortedBy,
      this.stockCode,
      this.marketCap = "",
      this.isin = null});

  AllStockResponse.fromJson(Map<String, dynamic> json) {
    change = json['chg'] ?? "";
    changePercentage = json['chg_percent'] ?? "";
    name = json['company_name'] ?? "";
    lastPrice = json['price'] ?? "";
    sortedBy = json['market_cap'] ?? "";
    stockCode = json['stock_code'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chg'] = this.change;
    data['chg_percent'] = this.changePercentage;
    data['company_name'] = this.name;
    data['price'] = this.lastPrice;
    data['sorted_by'] = this.sortedBy;
    data['stock_code'] = this.stockCode;
    return data;
  }
}
