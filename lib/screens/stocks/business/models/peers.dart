class Peers {
  String oneYrPerform;
  String debtToEquity;
  String mCapCr;
  String netProfit;
  String netSales;
  String pB;
  String rOE;
  String tTMPE;
  String chgPercent;
  String companyName;
  String price;
  String stockCode;

  Peers(
      {this.oneYrPerform,
      this.debtToEquity,
      this.mCapCr,
      this.netProfit,
      this.netSales,
      this.pB,
      this.rOE,
      this.tTMPE,
      this.chgPercent,
      this.companyName,
      this.price,
      this.stockCode});

  Peers.fromJson(Map<String, dynamic> json) {
    oneYrPerform = json['1_Yr_Perform'];
    debtToEquity = json['Debt_to_Equity'];
    mCapCr = json['MCap(Cr)'];
    netProfit = json['Net_Profit'];
    netSales = json['Net_Sales'];
    pB = json['P/B'];
    rOE = json['ROE'];
    tTMPE = json['TTM_PE'];
    chgPercent = json['chg_percent'];
    companyName = json['company_name'];
    price = json['price'];
    stockCode = json['stock_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1_Yr_Perform'] = this.oneYrPerform;
    data['Debt_to_Equity'] = this.debtToEquity;
    data['MCap(Cr)'] = this.mCapCr;
    data['Net_Profit'] = this.netProfit;
    data['Net_Sales'] = this.netSales;
    data['P/B'] = this.pB;
    data['ROE'] = this.rOE;
    data['TTM_PE'] = this.tTMPE;
    data['chg_percent'] = this.chgPercent;
    data['company_name'] = this.companyName;
    data['price'] = this.price;
    data['stock_code'] = this.stockCode;
    return data;
  }
}
