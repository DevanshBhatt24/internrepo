// To parse this JSON data, do
//
//     final etfExploreModel = etfExploreModelFromJson(jsonString);

import 'dart:convert';

EtfExploreModel etfExploreModelFromJson(String str) =>
    EtfExploreModel.fromJson(json.decode(str));

String etfExploreModelToJson(EtfExploreModel data) =>
    json.encode(data.toJson());

class EtfExploreModel {
  EtfExploreModel({
    this.mutualFund,
  });

  List<MutualFund> mutualFund;

  factory EtfExploreModel.fromJson(Map<String, dynamic> json) =>
      EtfExploreModel(
        mutualFund: List<MutualFund>.from(
            json["mutual fund"].map((x) => MutualFund.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mutual fund": List<dynamic>.from(mutualFund.map((x) => x.toJson())),
      };
}

MutualFund mutualAndEtfDetails(String str) =>
    MutualFund.fromJson(json.decode(str));

String mutualAndEtfDetailsToJson(MutualFund data) => json.encode(data.toJson());

MutualPriceDetails mutualAndEtfPriceDetails(String str) =>
    MutualPriceDetails.fromJson(json.decode(str)[0]);

String mutualAndEtfPriceDetailsToJson(MutualPriceDetails data) =>
    json.encode(data.toJson());

class MutualPriceDetails {
  MutualPriceDetails({this.price, this.chng, this.chngPercentage});

  String price, chng, chngPercentage;

  factory MutualPriceDetails.fromJson(Map<String, dynamic> json) =>
      MutualPriceDetails(
          price: json["price"],
          chng: json["chg"],
          chngPercentage: json["chg_percent"]);

  Map<String, dynamic> toJson() =>
      {"price": price, "chg": chng, "chg_percent": chngPercentage};
}

class MutualFund {
  MutualFund({
    this.peerComparison,
    this.about,
    this.summary,
  });

  About about;
  MSummary summary;
  Fundvspeer peerComparison;

  factory MutualFund.fromJson(Map<String, dynamic> json) => MutualFund(
        summary:
            json["summary"] == null ? null : MSummary.fromJson(json["summary"]),
        peerComparison: json["peer_comparison"] == null
            ? null
            : Fundvspeer.fromJson(json["peer_comparison"]),
        about: json["about"] == null ? null : About.fromJson(json["about"]),
      );

  Map<String, dynamic> toJson() => {
        "summary": summary == null ? null : summary.toJson(),
        "fund_vs_peers":
            peerComparison == null ? null : peerComparison.toJson(),
        "basic_attributes": about == null ? null : about.toJson(),
      };
}

class MSummary {
  MSummary(
      {this.assetAllocation, this.overView, this.riskometer, this.top5Peers});

  AssetAllocation assetAllocation;
  Riskometer riskometer;
  List<Top5Peers> top5Peers;
  List<BasicAttributeValues> overView;

  factory MSummary.fromJson(Map<String, dynamic> json) => MSummary(
      assetAllocation: AssetAllocation.fromJson(json["asset_allocataion"]),
      riskometer: Riskometer.fromJson(json["riskometer"]),
      top5Peers: List<Top5Peers>.from(
          json["top_5_peers"].map((x) => Top5Peers.fromJson(x))),
      overView: List<BasicAttributeValues>.from(
          json["overview"].map((x) => BasicAttributeValues.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "overview": List<dynamic>.from(overView.map((e) => e.toJson())),
        "asset_allocataion": assetAllocation.toJson(),
        "riskometer": riskometer.toJson(),
        "top_5_peers": List<dynamic>.from(top5Peers.map((e) => e.toJson()))
      };
}

class AssetAllocation {
  AssetAllocation({this.other, this.cash, this.debt, this.equity});

  String cash;
  String debt;
  String equity;
  String other;

  factory AssetAllocation.fromJson(Map<String, dynamic> json) =>
      AssetAllocation(
          cash: json != null
              ? json["cash"] == null
                  ? '-'
                  : json["cash"]
              : '',
          debt: json != null ? json["debt"] : '',
          other: json != null
              ? json["other"] == null
                  ? '-'
                  : json["other"]
              : '',
          equity: json != null ? json["equity"] : '');

  Map<String, dynamic> toJson() =>
      {"cash": cash, "debt": debt, "equity": equity, "other": other};
}

class Riskometer {
  Riskometer(
      {this.annualizedReturn,
      this.averageTimeTaken,
      this.meter,
      this.suggestedInvestment,
      this.text});
  AnnualizedReturn annualizedReturn;
  List<AverageTimeTaken> averageTimeTaken;
  String meter;
  SuggestedInvestment suggestedInvestment;
  String text;

  factory Riskometer.fromJson(Map<String, dynamic> json) => Riskometer(
      annualizedReturn: AnnualizedReturn.fromJson(json["annualized_return"]),
      averageTimeTaken: List<AverageTimeTaken>.from(
          json["average_time_taken"].map((x) => AverageTimeTaken.fromJson(x))),
      meter: json["meter"],
      suggestedInvestment:
          SuggestedInvestment.fromJson(json["suggested_investment"]),
      text: json["text"]);

  Map<String, dynamic> toJson() => {
        "annualized_return": annualizedReturn.toJson(),
        "average_time_taken":
            List<dynamic>.from(averageTimeTaken.map((e) => e.toJson())),
        "meter": meter,
        "suggested_investment": suggestedInvestment.toJson(),
        "text": text
      };
}

class Top5Peers {
  String oneYearReturn;
  String threeYearReturn;
  String fundName;
  Top5Peers({this.oneYearReturn, this.threeYearReturn, this.fundName});

  factory Top5Peers.fromJson(Map<String, dynamic> json) => Top5Peers(
      fundName: json["fund_name"],
      oneYearReturn: json["1 Year Return"],
      threeYearReturn: json["3 Years Return"]);

  Map<String, dynamic> toJson() => {
        "1 Year Return": oneYearReturn,
        "3 Years Return": threeYearReturn,
        "fund_name": fundName
      };
}

class About {
  About({
    this.basicAttribute,
    this.fundManager,
    this.concentrationAnalysis,
  });

  List<BasicAttribute> basicAttribute;
  List<BasicFundManager> fundManager;
  List<ConcentrationAnalysis> concentrationAnalysis;

  factory About.fromJson(Map<String, dynamic> json) => About(
      basicAttribute: List<BasicAttribute>.from(
          json["basic_attributes"].map((x) => BasicAttribute.fromJson(x))),
      fundManager: List<BasicFundManager>.from(
          json["fund_manager"].map((x) => BasicFundManager.fromJson(x))),
      concentrationAnalysis: List<ConcentrationAnalysis>.from(
          json["concentration_analysis"]
              .map((x) => ConcentrationAnalysis.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "basic_attributes":
            List<dynamic>.from(basicAttribute.map((x) => x.toJson())),
        "fund_manager": List<dynamic>.from(fundManager.map((x) => x.toJson())),
        "concentration_analysis":
            List<dynamic>.from(concentrationAnalysis.map((x) => x.toJson()))
      };
}

class BasicFundManager {
  BasicFundManager(
      {this.amc,
      this.averageTenure,
      this.numberOfFundManager,
      this.longestTenure,
      this.managers});

  String amc;
  String averageTenure;
  String numberOfFundManager;
  String longestTenure;
  List<Managers> managers;

  factory BasicFundManager.fromJson(Map<String, dynamic> json) =>
      BasicFundManager(
          amc: json["amc"],
          averageTenure: json["average_tenure"],
          longestTenure: json["longest_tenure"],
          numberOfFundManager: json["number_of_fund_manager"],
          managers: List<Managers>.from(
              json["managers"].map((x) => Managers.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "amc": amc,
        "average_tenure": averageTenure,
        "longest_tenure": longestTenure,
        "number_of_fund_manager": numberOfFundManager,
        "managers": List<dynamic>.from(managers.map((e) => e.toJson()))
      };
}

class Managers {
  Managers({this.duration, this.name});

  String duration;
  String name;

  factory Managers.fromJson(Map<String, dynamic> json) =>
      Managers(duration: json["duration"], name: json["name"]);

  Map<String, dynamic> toJson() => {"duration": duration, "name": name};
}

class AnnualizedReturn {
  String text;
  String value;

  AnnualizedReturn({this.text, this.value});

  factory AnnualizedReturn.fromJson(Map<String, dynamic> json) =>
      AnnualizedReturn(text: json["text"], value: json["value"]);

  Map<String, dynamic> toJson() => {"text": text, "value": value};
}

class AverageTimeTaken {
  String text;
  String value;

  AverageTimeTaken({this.text, this.value});

  factory AverageTimeTaken.fromJson(Map<String, dynamic> json) =>
      AverageTimeTaken(text: json["text"], value: json["value"]);

  Map<String, dynamic> toJson() => {"text": text, "value": value};
}

class SuggestedInvestment {
  String text;
  String value;
  SuggestedInvestment({this.text, this.value});

  factory SuggestedInvestment.fromJson(Map<String, dynamic> json) =>
      SuggestedInvestment(text: json["text"], value: json["value"]);

  Map<String, dynamic> toJson() => {"text": text, "value": value};
}

class BasicAttribute {
  BasicAttribute({this.text, this.value});

  String text;
  String value;

  factory BasicAttribute.fromJson(Map<String, dynamic> json) =>
      BasicAttribute(text: json["text"], value: json["value"]);

  Map<String, dynamic> toJson() => {"text": text, "value": value};
}

class ConcentrationAnalysis {
  ConcentrationAnalysis({this.title, this.value});

  String title;
  String value;
  factory ConcentrationAnalysis.fromJson(Map<String, dynamic> json) =>
      ConcentrationAnalysis(title: json["title"], value: json["value"]);

  Map<String, dynamic> toJson() => {"title": title, "value": value};
}

class BasicAttributeSystematic {
  BasicAttributeSystematic({
    this.systematicInvestmentPlan,
    this.systematicTransferPlan,
    this.systematicWithdrawalPlan,
    this.minimumInitialInvestment,
    this.minimumSubsequentInvestment,
  });

  String systematicInvestmentPlan;
  String systematicTransferPlan;
  String systematicWithdrawalPlan;
  String minimumInitialInvestment;
  String minimumSubsequentInvestment;

  factory BasicAttributeSystematic.fromJson(Map<String, dynamic> json) =>
      BasicAttributeSystematic(
        systematicInvestmentPlan: json["Systematic Investment Plan"] == null
            ? null
            : json["Systematic Investment Plan"],
        systematicTransferPlan: json["Systematic Transfer Plan"] == null
            ? null
            : json["Systematic Transfer Plan"],
        systematicWithdrawalPlan: json["Systematic Withdrawal Plan"] == null
            ? null
            : json["Systematic Withdrawal Plan"],
        minimumInitialInvestment: json["Minimum initial Investment"] == null
            ? null
            : json["Minimum initial Investment"],
        minimumSubsequentInvestment:
            json["Minimum Subsequent Investment"] == null
                ? null
                : json["Minimum Subsequent Investment"],
      );

  Map<String, dynamic> toJson() => {
        "Systematic Investment Plan":
            systematicInvestmentPlan == null ? null : systematicInvestmentPlan,
        "Systematic Transfer Plan":
            systematicTransferPlan == null ? null : systematicTransferPlan,
        "Systematic Withdrawal Plan":
            systematicWithdrawalPlan == null ? null : systematicWithdrawalPlan,
        "Minimum initial Investment":
            minimumInitialInvestment == null ? null : minimumInitialInvestment,
        "Minimum Subsequent Investment": minimumSubsequentInvestment == null
            ? null
            : minimumSubsequentInvestment,
      };
}

class Factsheet {
  Factsheet(
      {this.assetAllocation,
      this.fundManagers,
      this.basicAttributes,
      this.creditRating,
      this.returnsPercent,
      this.topHoldings,
      this.overview});

  AssetAllocation assetAllocation;
  FactsheetBasicAttributes basicAttributes;
  List<CreditRating> creditRating;
  FundManagers fundManagers;
  OverView overview;
  List<ReturnsPercent> returnsPercent;
  List<TopHolding> topHoldings;

  // String assetUnderManagment;
  // String benchmark;
  // String category;
  // List<dynamic> creditRating;
  // String expenseRatio;
  // String fundManager;
  // List<dynamic> instruments;
  // List<MarketcapDatum> marketcapData;
  // List<dynamic> portfolioAttributes;
  // List<QuaterlyReturn> quaterlyReturns;
  // List<ReturnDatum> returnData;
  // List<SectorsDatum> sectorsData;

  factory Factsheet.fromJson(Map<String, dynamic> json) => Factsheet(
      assetAllocation: AssetAllocation.fromJson(json["asset_allocation"]),
      basicAttributes:
          FactsheetBasicAttributes.fromjson(json["basic_attributes"]),
      creditRating: List<CreditRating>.from(
          json["credit_rating"].map((x) => CreditRating.fromJson(x))),
      fundManagers: FundManagers.fromJson(json["fund_managers"]),
      returnsPercent: List<ReturnsPercent>.from(
          json["returns_percent"].map((x) => ReturnsPercent.fromJson(x))));

  Map<String, dynamic> toJson() => {
        // "asset_under_managment": assetUnderManagment,
        // "benchmark": benchmark,
        // "category": category,
        // "credit_rating": List<dynamic>.from(creditRating.map((x) => x)),
        // "expense_ratio": expenseRatio,
        // "fund_manager": fundManager,
        // "instruments": List<dynamic>.from(instruments.map((x) => x)),
        // "marketcap_data":
        //     List<dynamic>.from(marketcapData.map((x) => x.toJson())),
        // "portfolio_attributes":
        //     List<dynamic>.from(portfolioAttributes.map((x) => x)),
        // "quaterly_returns":
        //     List<dynamic>.from(quaterlyReturns.map((x) => x.toJson())),
        // "return_data": List<dynamic>.from(returnData.map((x) => x.toJson())),
        // "sectors_data": List<dynamic>.from(sectorsData.map((x) => x.toJson())),
        // "top_holdings": List<dynamic>.from(topHoldings.map((x) => x.toJson())),
      };
}

class FactsheetBasicAttributes {
  FactsheetBasicAttributes({this.basicAttributeValues, this.headOffice});

  List<BasicAttributeValues> basicAttributeValues;
  String headOffice;

  factory FactsheetBasicAttributes.fromjson(Map<String, dynamic> json) =>
      FactsheetBasicAttributes();

  Map<String, dynamic> toJson() => {};
}

class FundManagers {
  FundManagers({this.fundManagersValues, this.managersName});
  List<BasicAttributeValues> fundManagersValues;
  List<String> managersName;

  factory FundManagers.fromJson(Map<String, dynamic> json) => FundManagers(
      fundManagersValues: List<BasicAttributeValues>.from(
          json["fund_managers_values"]
              .map((x) => BasicAttributeValues.fromJson(x))),
      managersName:
          List<String>.from(json["managers_name"].map((x) => x["name"])));
}

class OverView {
  OverView({this.overviews});

  List<BasicAttributeValues> overviews;

  factory OverView.fromJson(Map<String, dynamic> json) => OverView(
      overviews: List<BasicAttributeValues>.from(
          json["overview"].map((x) => BasicAttributeValues.fromJson(x))));

  Map<String, dynamic> toJson() =>
      {"overview": List<dynamic>.from(overviews.map((e) => e.toJson()))};
}

class ReturnsPercent {
  ReturnsPercent(
      {this.month, this.rankReturn, this.slipReturn, this.trailingReturn});
  String month;
  Return rankReturn;
  Return slipReturn;
  TrailingReturn trailingReturn;

  factory ReturnsPercent.fromJson(Map<String, dynamic> json) => ReturnsPercent(
      month: json["month"],
      rankReturn: Return.fromJson(json["rank"]),
      slipReturn: Return.fromJson(json["sip_return"]),
      trailingReturn: TrailingReturn.fromJson(json["trailing_return"]));

  Map<String, dynamic> toJson() => {};
}

class Return {
  Return({this.returnvalue});
  String returnvalue;

  factory Return.fromJson(Map<String, dynamic> json) =>
      Return(returnvalue: json["return"]);

  Map<String, dynamic> toJson() => {"return": returnvalue};
}

class TrailingReturn {
  TrailingReturn({this.category, this.fund});

  String category;
  String fund;

  factory TrailingReturn.fromJson(Map<String, dynamic> json) =>
      TrailingReturn(category: json["category"], fund: json["fund"]);

  Map<String, dynamic> toJson() => {"category": category, "fund": fund};
}

class BasicAttributeValues {
  BasicAttributeValues({this.title, this.value});

  String title;
  String value;

  factory BasicAttributeValues.fromJson(Map<String, dynamic> json) =>
      BasicAttributeValues(title: json["title"], value: json["value"]);

  Map<String, dynamic> toJson() => {"title": title, "value": value};
}

class CreditRating {
  String debtShortTerm;
  String growth;
  String rating;

  CreditRating({this.debtShortTerm, this.growth, this.rating});

  factory CreditRating.fromJson(Map<String, dynamic> json) => CreditRating(
      debtShortTerm: json["debt_short_term"],
      growth: json["growth"],
      rating: json["rating"]);

  Map<String, dynamic> toJson() =>
      {"debt_short_term": debtShortTerm, "growth": growth, "rating": rating};
}

class MarketcapDatum {
  MarketcapDatum({
    this.category,
    this.fund,
    this.mktCap,
  });

  String category;
  String fund;
  String mktCap;

  factory MarketcapDatum.fromJson(Map<String, dynamic> json) => MarketcapDatum(
        category: json["category"],
        fund: json["fund"],
        mktCap: json["mkt_cap"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "fund": fund,
        "mkt_cap": mktCap,
      };
}

class QuaterlyReturn {
  QuaterlyReturn({
    this.q1,
    this.q2,
    this.q3,
    this.q4,
    this.year,
  });

  String q1;
  String q2;
  String q3;
  String q4;
  String year;

  factory QuaterlyReturn.fromJson(Map<String, dynamic> json) => QuaterlyReturn(
        q1: json["Q1"],
        q2: json["Q2"],
        q3: json["Q3"],
        q4: json["Q4"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "Q1": q1,
        "Q2": q2,
        "Q3": q3,
        "Q4": q4,
        "year": year,
      };
}

class ReturnDatum {
  ReturnDatum({
    this.date,
    this.rankCategory,
    this.sipReturn,
    this.trailingCategory,
    this.trailingFund,
  });

  String date;
  String rankCategory;
  String sipReturn;
  String trailingCategory;
  String trailingFund;

  factory ReturnDatum.fromJson(Map<String, dynamic> json) => ReturnDatum(
        date: json["date"],
        rankCategory: json["rank_category"],
        sipReturn: json["sip_return"],
        trailingCategory: json["trailing_category"],
        trailingFund: json["trailing_fund"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "rank_category": rankCategory,
        "sip_return": sipReturn,
        "trailing_category": trailingCategory,
        "trailing_fund": trailingFund,
      };
}

class SectorsDatum {
  SectorsDatum({
    this.assestsPer,
    this.monChangesPer,
    this.sectors,
  });

  String assestsPer;
  String monChangesPer;
  String sectors;

  factory SectorsDatum.fromJson(Map<String, dynamic> json) => SectorsDatum(
        assestsPer: json["assests_per"],
        monChangesPer: json["mon_changes_per"],
        sectors: json["sectors"],
      );

  Map<String, dynamic> toJson() => {
        "assests_per": assestsPer,
        "mon_changes_per": monChangesPer,
        "sectors": sectors,
      };
}

class TopHolding {
  TopHolding({
    this.assetPercent,
    this.company,
    this.epsTtm,
    this.sector,
    this.oneYearReturn,
    this.pe,
  });

  String assetPercent;
  String company;
  String epsTtm;
  String sector;
  String oneYearReturn;
  String pe;

  factory TopHolding.fromJson(Map<String, dynamic> json) => TopHolding(
        assetPercent: json["%_asset"],
        company: json["company"],
        epsTtm: json["eps-ttm"],
        sector: json["sector"],
        oneYearReturn: json["1_yr_return"],
        pe: json["pe"],
      );

  Map<String, dynamic> toJson() => {
        "%_asset": assetPercent,
        "company": company,
        "eps-ttm": epsTtm,
        "sector": sector,
        "1_yr_return": oneYearReturn,
        "pe": pe,
      };
}

class Fundvspeer {
  Fundvspeer({
    this.peersComparison,
    this.riskReturnMatrix,
  });

  PeersComparison peersComparison;
  List<RiskReturnMatrix> riskReturnMatrix;

  factory Fundvspeer.fromJson(Map<String, dynamic> json) => Fundvspeer(
        peersComparison: PeersComparison.fromJson(json["peers_comparison"]),
        riskReturnMatrix: List<RiskReturnMatrix>.from(json["risk_return_matrix"]
            .map((x) => RiskReturnMatrix.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "peers_comparison": peersComparison.toJson(),
        "risk_return_matrix":
            List<dynamic>.from(riskReturnMatrix.map((x) => x.toJson())),
      };
}

class PeersComparison {
  PeersComparison({this.cumulative, this.discreteYearly, this.sipReturn});

  List<Cumulative> cumulative;
  List<DiscreteYearly> discreteYearly;
  List<Cumulative> sipReturn;

  factory PeersComparison.fromJson(Map<String, dynamic> json) =>
      PeersComparison(
          cumulative: List<Cumulative>.from(
              json["cumulative"].map((x) => Cumulative.fromJson(x))),
          discreteYearly: List<DiscreteYearly>.from(
              json["discrete_yearly"].map((x) => DiscreteYearly.fromJson(x))),
          sipReturn: List<Cumulative>.from(
              json["sip_return"].map((x) => Cumulative.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "cumulative": List<dynamic>.from(cumulative.map((x) => x.toJson())),
        "discrete_yearly":
            List<dynamic>.from(discreteYearly.map((x) => x.toJson())),
        "sip_return": List<dynamic>.from(sipReturn.map((x) => x.toJson()))
      };
}

class Cumulative {
  Cumulative(
      {this.oneMonth,
      this.oneYr,
      this.threeYr,
      this.fiveYr,
      this.name,
      this.aum,
      this.nav});

  String oneMonth;
  String oneYr;
  String threeYr;
  String fiveYr;
  String name;
  String aum;
  String nav;

  factory Cumulative.fromJson(Map<String, dynamic> json) => Cumulative(
      aum: json["aum"],
      oneMonth: json["1m"],
      oneYr: json["1yr"],
      threeYr: json["3yr"],
      fiveYr: json["5yr"],
      name: json["Name"],
      nav: json["nav"]);

  Map<String, dynamic> toJson() => {
        "aum": aum,
        "1m": oneMonth,
        "1yr": oneYr,
        "3yr": threeYr,
        "5yr": fiveYr,
        "Name": name,
        "nav": nav
      };
}

class DiscreteYearly {
  DiscreteYearly({this.name, this.values, this.years});

  String name;
  List<String> values, years;

  factory DiscreteYearly.fromJson(Map<String, dynamic> json) => DiscreteYearly(
        name: json["name"],
        values: List<String>.from(json["values"].map((x) => x)),
        years: List<String>.from(json["years"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "values": List<dynamic>.from(values.map((x) => x)),
        "years": List<dynamic>.from(years.map((x) => x))
      };
}

class FundVsPeer {
  FundVsPeer({
    this.aum,
    this.fiveYear,
    this.name,
    this.nav,
    this.oneMonth,
    this.oneYear,
    this.threeYear,
  });

  String aum;
  String fiveYear;
  String name;
  String nav;
  String oneMonth;
  String oneYear;
  String threeYear;

  factory FundVsPeer.fromJson(Map<String, dynamic> json) => FundVsPeer(
        aum: json["aum"],
        fiveYear: json["five_year"],
        name: json["name"],
        nav: json["nav"],
        oneMonth: json["one_month"],
        oneYear: json["one_year"],
        threeYear: json["three_year"],
      );

  Map<String, dynamic> toJson() => {
        "aum": aum,
        "five_year": fiveYear,
        "name": name,
        "nav": nav,
        "one_month": oneMonth,
        "one_year": oneYear,
        "three_year": threeYear,
      };
}

class RiskReturnMatrix {
  RiskReturnMatrix({
    this.returnPercent,
    this.riskPercent,
    this.schemeName,
  });

  String returnPercent;
  String riskPercent;
  String schemeName;

  factory RiskReturnMatrix.fromJson(Map<String, dynamic> json) =>
      RiskReturnMatrix(
        returnPercent: json["return"],
        riskPercent: json["risk"],
        schemeName: json["scheme_name"],
      );

  Map<String, dynamic> toJson() => {
        "return": returnPercent,
        "risk": riskPercent,
        "scheme_name": schemeName,
      };
}

class History {
  History({
    this.concentrationAnalysis,
    this.styleAnalysis,
  });

  HistoryConcentrationAnalysis concentrationAnalysis;
  List<StyleAnalysis> styleAnalysis;

  factory History.fromJson(Map<String, dynamic> json) => History(
        concentrationAnalysis: HistoryConcentrationAnalysis.fromJson(
            json["concentration_analysis"]),
        styleAnalysis: List<StyleAnalysis>.from(
            json["style_analysis"].map((x) => StyleAnalysis.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "concentration_analysis": concentrationAnalysis.toJson(),
        "style_analysis":
            List<dynamic>.from(styleAnalysis.map((x) => x.toJson())),
      };
}

class HistoryConcentrationAnalysis {
  HistoryConcentrationAnalysis({this.tableData, this.tableHeadings});

  List<HistoryTableData> tableData;
  List<String> tableHeadings;

  factory HistoryConcentrationAnalysis.fromJson(Map<dynamic, dynamic> json) =>
      HistoryConcentrationAnalysis(
          tableData: List<HistoryTableData>.from(
              json["table_data"].map((x) => HistoryTableData.fromJson(x))),
          tableHeadings:
              List<String>.from(json["table_headings"].map((x) => x)));

  Map<String, dynamic> toJson() => {
        "table_data": List<dynamic>.from(tableData.map((e) => e.toJson())),
        "table_headings": List<dynamic>.from(tableHeadings.map((x) => x))
      };
}

class HistoryTableData {
  HistoryTableData({this.name, this.values});

  String name;
  List<String> values;

  factory HistoryTableData.fromJson(Map<String, dynamic> json) =>
      HistoryTableData(
          name: json["name"],
          values: List<String>.from(json["values"].map((x) => x)));

  Map<String, dynamic> toJson() =>
      {"name": name, "values": List<dynamic>.from(values.map((x) => x))};
}

class StyleAnalysis {
  StyleAnalysis({
    this.marketCaptalization,
    this.month,
    this.valuation,
  });

  String marketCaptalization;
  String month;
  String valuation;

  factory StyleAnalysis.fromJson(Map<String, dynamic> json) => StyleAnalysis(
        marketCaptalization: json["market_captalization"],
        month: json["month"],
        valuation: json["valuation"],
      );

  Map<String, dynamic> toJson() => {
        "market_captalization": marketCaptalization,
        "month": month,
        "valuation": valuation,
      };
}

class Standalone {
  Standalone({
    this.concentrationAnalysis,
    // this.protfolioAttributes,
  });

  List<BasicAttributeValues> concentrationAnalysis;
  List<dynamic> protfolioAttributes;

  factory Standalone.fromJson(Map<String, dynamic> json) => Standalone(
        concentrationAnalysis: List<BasicAttributeValues>.from(
            json["concentration_analysis"]
                .map((x) => BasicAttributeValues.fromJson(x))),
        // protfolioAttributes: List<FundAssetAllocation>.from(
        //     json["fund_asset_allocation"]
        //         .map((x) => FundAssetAllocation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "concentration_analysis":
            List<dynamic>.from(concentrationAnalysis.map((x) => x.toJson())),
        // "fund_asset_allocation":
        //     List<dynamic>.from(fundAssetAllocation.map((x) => x.toJson())),
      };
}

class FundAssetAllocation {
  FundAssetAllocation({
    this.assetClass,
    this.cash,
    this.debt,
    this.equity,
  });

  String assetClass;
  String cash;
  String debt;
  String equity;

  factory FundAssetAllocation.fromJson(Map<String, dynamic> json) =>
      FundAssetAllocation(
        assetClass: json["asset_class"],
        cash: json["cash"],
        debt: json["debt"],
        equity: json["equity"],
      );

  Map<String, dynamic> toJson() => {
        "asset_class": assetClass,
        "cash": cash,
        "debt": debt,
        "equity": equity,
      };
}

FundWatchModel watchlistFundFromJson(String str) =>
    FundWatchModel.fromJson(json.decode(str)[0]);

class FundWatchModel {
  FundWatchModel({this.name, this.price, this.chng, this.chngPercent});

  String name, price, chng, chngPercent;

  factory FundWatchModel.fromJson(Map<String, dynamic> json) => FundWatchModel(
      name: json["name"] == null ? "" : json["name"],
      chng: json["chg"] == null ? "" : json["chg"],
      chngPercent: json["chg_percent"] == null ? "" : json["chg_percent"],
      price: json["price"] == null ? "" : json["price"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "chg": chng, "chg_percent": chngPercent, "price": price};
}
