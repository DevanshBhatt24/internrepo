// To parse this JSON data, do
//
//     final stockDetail = stockDetailFromJson(jsonString);

import 'dart:convert';

import 'package:technical_ind/screens/commodity/business/commodity_overview_model.dart';

StockDetail stockDetailFromJson(String str) =>
    StockDetail.fromJson(json.decode(str));

String stockDetailToJson(StockDetail data) => json.encode(data.toJson());

Volatility stockVolatilityFromJson(String str) =>
    Volatility.fromJson(json.decode(str)["volatility_data"]);

class StockDetail {
  StockDetail({
    this.about,
    this.broadcast,
    this.crucialChecklist,
    this.deals,
    // this.delivery,
    this.esg,
    this.financialsBalancesheet,
    this.financialsCashflow,
    this.financialsDividends,
    this.financialsEarnings,
    this.financialsIncomeStatement,
    this.financialsProfitLoss,
    this.financialsRatios,
    this.financialsRiskProfile,
    this.financialsSolvency,
    this.isin,
    this.quality,
    this.quickSummary,
    this.returns,
    this.scrutiny,
    this.shareholding,
    this.swot,
    this.topSummaryFinancials,
    this.valuation,
  });

  About about;
  Broadcast broadcast;
  CrucialChecklist crucialChecklist;
  Deals deals;
  // Delivery delivery;
  Esg esg;
  FinancialsBalancesheet financialsBalancesheet;
  FinancialsCashflow financialsCashflow;
  FinancialsDividends financialsDividends;
  FinancialsEarnings financialsEarnings;
  FinancialsIncomeStatement financialsIncomeStatement;
  FinancialsProfitLoss financialsProfitLoss;
  FinancialsRatios financialsRatios;
  FinancialsRiskProfile financialsRiskProfile;
  FinancialsSolvency financialsSolvency;
  FutureAndOptions futureAndOptions;
  // HistoricalData historicalData;
  String isin;
  Quality quality;
  QuickSummary quickSummary;
  // Quotes quotes;
  ReturnsClass returns;
  Scrutiny scrutiny;
  Shareholding shareholding;
  Swot swot;
  Technical technical;
  TopSummaryFinancials topSummaryFinancials;
  Valuation valuation;
  // Volatility volatility;

  factory StockDetail.fromJson(Map<String, dynamic> json) => StockDetail(
        about: About.fromJson(json["about"]),
        broadcast: Broadcast.fromJson(json["broadcast"]),
        crucialChecklist: CrucialChecklist.fromJson(json["crucial_checklist"]),
        deals: Deals.fromJson(json["deals"]),
        // delivery: Delivery.fromJson(json["delivery"]),
        esg: Esg.fromJson(json["esg"]),
        financialsBalancesheet:
            FinancialsBalancesheet.fromJson(json["financials_balancesheet"]),
        financialsCashflow:
            FinancialsCashflow.fromJson(json["financials_cashflow"]),
        financialsDividends:
            FinancialsDividends.fromJson(json["financials_dividends"]),
        financialsEarnings:
            FinancialsEarnings.fromJson(json["financials_earnings"]),
        financialsIncomeStatement: FinancialsIncomeStatement.fromJson(
            json["financials_income_statement"]),
        financialsProfitLoss:
            FinancialsProfitLoss.fromJson(json["financials_profit_loss"]),
        financialsRatios: FinancialsRatios.fromJson(json["financials_ratios"]),
        financialsRiskProfile:
            FinancialsRiskProfile.fromJson(json["financials_risk_profile"]),
        financialsSolvency:
            FinancialsSolvency.fromJson(json["financials_solvency"]),
        // futureAndOptions: json != null
        //     ? FutureAndOptions.fromJson(json["future_and_options"])
        //     : null,
        // historicalData: HistoricalData.fromJson(json["historical_data"]),
        isin: json["isin"],
        quality: Quality.fromJson(json["quality"]),
        quickSummary: QuickSummary.fromJson(json["quick_summary"]),
        // quotes: Quotes.fromJson(json["quotes"]),
        returns: ReturnsClass.fromJson(json["returns"]),
        scrutiny: Scrutiny.fromJson(json["scrutiny"]),
        shareholding: Shareholding.fromJson(json["shareholding"]),
        swot: Swot.fromJson(json["swot"]),
        // technical: Technical.fromJson(json["technical"]),
        topSummaryFinancials:
            TopSummaryFinancials.fromJson(json["top_summary_financials"]),
        valuation: Valuation.fromJson(json["valuation"]),
        // volatility: Volatility.fromJson(json["volatility"]),
      );

  Map<String, dynamic> toJson() => {
        "about": about.toJson(),
        "broadcast": broadcast.toJson(),
        "crucial_checklist": crucialChecklist.toJson(),
        "deals": deals.toJson(),
        // "delivery": delivery.toJson(),
        "esg": esg.toJson(),
        "financials_balancesheet": financialsBalancesheet.toJson(),
        "financials_cashflow": financialsCashflow.toJson(),
        "financials_dividends": financialsDividends.toJson(),
        "financials_earnings": financialsEarnings.toJson(),
        "financials_income_statement": financialsIncomeStatement.toJson(),
        "financials_profit_loss": financialsProfitLoss.toJson(),
        "financials_ratios": financialsRatios.toJson(),
        "financials_risk_profile": financialsRiskProfile.toJson(),
        "financials_solvency": financialsSolvency.toJson(),
        // "future_and_options": futureAndOptions.toJson(),
        // "historical_data": historicalData.toJson(),
        "isin": isin,
        "quality": quality.toJson(),
        // "quick_summary": quickSummary.toJson(),
        // "quotes": quotes.toJson(),
        "returns": returns.toJson(),
        "scrutiny": scrutiny.toJson(),
        "shareholding": shareholding.toJson(),
        "swot": swot.toJson(),
        // "technical": technical.toJson(),
        "top_summary_financials": topSummaryFinancials.toJson(),
        "valuation": valuation.toJson(),
        // "volatility": volatility.toJson(),
      };
}

class About {
  About({
    this.details,
    this.includedIn,
    this.management,
    this.registeredOffice,
    this.registrars,
  });

  Details details;
  IncludedIn includedIn;
  List<Management> management;
  Regist registeredOffice;
  Regist registrars;

  factory About.fromJson(Map<String, dynamic> json) => About(
        details: Details.fromJson(json["details"]),
        includedIn: IncludedIn.fromJson(json["included_in"]),
        management: List<Management>.from(
            json["management"].map((x) => Management.fromJson(x))),
        registeredOffice: Regist.fromJson(json["registered_office"]),
        registrars: Regist.fromJson(json["registrars"]),
      );

  Map<String, dynamic> toJson() => {
        "details": details.toJson(),
        "included_in": includedIn.toJson(),
        "management": List<dynamic>.from(management.map((x) => x.toJson())),
        "registered_office": registeredOffice.toJson(),
        "registrars": registrars.toJson(),
      };
}

class Details {
  Details({
    this.bse,
    this.isin,
    this.nse,
    this.series,
  });

  String bse;
  String isin;
  String nse;
  String series;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        bse: json["bse"],
        isin: json["isin"],
        nse: json["nse"],
        series: json["series"],
      );

  Map<String, dynamic> toJson() => {
        "bse": bse,
        "isin": isin,
        "nse": nse,
        "series": series,
      };
}

class IncludedIn {
  IncludedIn({
    this.bse100,
    this.bse200,
    this.bse500,
    this.cnxMidcap200,
    this.nifty50,
    this.sensex,
  });

  String bse100;
  String bse200;
  String bse500;
  String cnxMidcap200;
  String nifty50;
  String sensex;

  factory IncludedIn.fromJson(Map<String, dynamic> json) => IncludedIn(
        bse100: json["bse100"],
        bse200: json["bse_200"],
        bse500: json["bse_500"],
        cnxMidcap200: json["cnx_midcap_200"],
        nifty50: json["nifty_50"],
        sensex: json["sensex"],
      );

  Map<String, dynamic> toJson() => {
        "bse100": bse100,
        "bse_200": bse200,
        "bse_500": bse500,
        "cnx_midcap_200": cnxMidcap200,
        "nifty_50": nifty50,
        "sensex": sensex,
      };
}

class Management {
  Management({
    this.name,
    this.position,
  });

  String name;
  String position;

  factory Management.fromJson(Map<String, dynamic> json) => Management(
        name: json["name"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "position": position,
      };
}

class Regist {
  Regist({
    this.address,
    this.city,
    this.email,
    this.faxNo,
    this.internet,
    this.pinCode,
    this.state,
    this.telNo,
  });

  String address;
  String city;
  String email;
  String faxNo;
  String internet;
  String pinCode;
  String state;
  String telNo;

  factory Regist.fromJson(Map<String, dynamic> json) => Regist(
        address: json["address"],
        city: json["city"],
        email: json["email"],
        faxNo: json["fax_no"],
        internet: json["internet"],
        pinCode: json["pin_code"] == null ? null : json["pin_code"],
        state: json["state"],
        telNo: json["tel_no"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "email": email,
        "fax_no": faxNo,
        "internet": internet,
        "pin_code": pinCode == null ? null : pinCode,
        "state": state,
        "tel_no": telNo,
      };
}

class Broadcast {
  Broadcast({
    this.corporateAction,
    this.corporateAnnouncement,
  });

  CorporateAction corporateAction;
  List<CorporateAnnouncement> corporateAnnouncement;

  factory Broadcast.fromJson(Map<String, dynamic> json) => Broadcast(
        corporateAction: CorporateAction.fromJson(json["corporate_action"]),
        corporateAnnouncement: List<CorporateAnnouncement>.from(
            json["corporate_announcement"]
                .map((x) => CorporateAnnouncement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "corporate_action": corporateAction.toJson(),
        "corporate_announcement":
            List<dynamic>.from(corporateAnnouncement.map((x) => x.toJson())),
      };
}

class CorporateAction {
  CorporateAction({
    this.agmEgm,
    this.boardMeetings,
    this.bonus,
    this.dividends,
    this.rights,
    this.splits,
  });

  List<AgmEgm> agmEgm;
  List<AgmEgm> boardMeetings;
  List<Bonus> bonus;
  List<Dividend> dividends;
  List<Right> rights;
  List<Split> splits;

  factory CorporateAction.fromJson(Map<String, dynamic> json) =>
      CorporateAction(
        agmEgm:
            List<AgmEgm>.from(json["agm_egm"].map((x) => AgmEgm.fromJson(x))),
        boardMeetings: List<AgmEgm>.from(
            json["board_meetings"].map((x) => AgmEgm.fromJson(x))),
        bonus: List<Bonus>.from(json["bonus"].map((x) => Bonus.fromJson(x))),
        dividends: List<Dividend>.from(
            json["dividends"].map((x) => Dividend.fromJson(x))),
        rights: List<Right>.from(json["rights"].map((x) => Right.fromJson(x))),
        splits: List<Split>.from(json["splits"].map((x) => Split.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "agm_egm": List<dynamic>.from(agmEgm.map((x) => x.toJson())),
        "board_meetings":
            List<dynamic>.from(boardMeetings.map((x) => x.toJson())),
        "bonus": List<dynamic>.from(bonus.map((x) => x.toJson())),
        "dividends": List<dynamic>.from(dividends.map((x) => x.toJson())),
        "rights": List<dynamic>.from(rights.map((x) => x.toJson())),
        "splits": List<dynamic>.from(splits.map((x) => x.toJson())),
      };
}

class AgmEgm {
  AgmEgm({
    this.agenda,
    this.date,
  });

  String agenda;
  String date;

  factory AgmEgm.fromJson(Map<String, dynamic> json) => AgmEgm(
        agenda: json["agenda"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "agenda": agenda,
        "date": date,
      };
}

class Bonus {
  Bonus({
    this.announcementDate,
    this.exBonusDate,
    this.ratio,
  });

  String announcementDate;
  String exBonusDate;
  String ratio;

  factory Bonus.fromJson(Map<String, dynamic> json) => Bonus(
        announcementDate: json["announcement_date"],
        exBonusDate: json["ex_bonus_date"],
        ratio: json["ratio"],
      );

  Map<String, dynamic> toJson() => {
        "announcement_date": announcementDate,
        "ex_bonus_date": exBonusDate,
        "ratio": ratio,
      };
}

class Dividend {
  Dividend({
    this.dividendPercent,
    this.exDividendDate,
    this.type,
  });

  String dividendPercent;
  String exDividendDate;
  String type;

  factory Dividend.fromJson(Map<String, dynamic> json) => Dividend(
        dividendPercent: json["dividend_percent"].toString(),
        exDividendDate: json["ex_dividend_date"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "dividend_percent": dividendPercent,
        "ex_dividend_date": exDividendDate,
        "type": type,
      };
}

class Right {
  Right({
    this.exRightDate,
    this.premium,
    this.ratio,
  });

  String exRightDate;
  String premium;
  String ratio;

  factory Right.fromJson(Map<String, dynamic> json) => Right(
        exRightDate: json["ex_right_date"].toString(),
        premium: json["premium"].toString(),
        ratio: json["ratio"],
      );

  Map<String, dynamic> toJson() => {
        "ex_right_date": exRightDate,
        "premium": premium,
        "ratio": ratio,
      };
}

class Split {
  Split({
    this.exSplitDate,
    this.newFv,
    this.oldFv,
  });

  String exSplitDate;
  String newFv;
  String oldFv;

  factory Split.fromJson(Map<String, dynamic> json) => Split(
        exSplitDate: json["ex_split_date"].toString(),
        newFv: json["new_fv"].toString(),
        oldFv: json["old_fv"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "ex_split_date": exSplitDate,
        "new_fv": newFv,
        "old_fv": oldFv,
      };
}

class CorporateAnnouncement {
  CorporateAnnouncement({
    this.dateTime,
    this.description,
    this.heading,
    this.source,
  });

  String dateTime;
  String description;
  String heading;
  String source;

  factory CorporateAnnouncement.fromJson(Map<String, dynamic> json) =>
      CorporateAnnouncement(
        dateTime: json["date_time"],
        description: json["description"],
        heading: json["heading"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "date_time": dateTime,
        "description": description,
        "heading": heading,
        "source": source,
      };
}

class CrucialChecklist {
  CrucialChecklist({
    this.financials,
    this.industryComparisons,
    this.others,
    this.ownerships,
  });

  List<Financial> financials;
  List<Financial> industryComparisons;
  List<Financial> others;
  List<Financial> ownerships;

  factory CrucialChecklist.fromJson(Map<String, dynamic> json) =>
      CrucialChecklist(
        financials: List<Financial>.from(
            json["financials"].map((x) => Financial.fromJson(x))),
        industryComparisons: List<Financial>.from(
            json["industry_comparisons"].map((x) => Financial.fromJson(x))),
        others: List<Financial>.from(
            json["others"].map((x) => Financial.fromJson(x))),
        ownerships: List<Financial>.from(
            json["ownerships"].map((x) => Financial.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "financials": List<dynamic>.from(financials.map((x) => x.toJson())),
        "industry_comparisons":
            List<dynamic>.from(industryComparisons.map((x) => x.toJson())),
        "others": List<dynamic>.from(others.map((x) => x.toJson())),
        "ownerships": List<dynamic>.from(ownerships.map((x) => x.toJson())),
      };
}

class Financial {
  Financial({
    this.answer,
    this.question,
  });

  String answer;
  String question;

  factory Financial.fromJson(Map<String, dynamic> json) => Financial(
        answer: json["answer"],
        question: json["question"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "question": question,
      };
}

class Deals {
  Deals({
    this.blockDeals,
    this.bulkDeals,
    this.insiderDeals,
    this.sastDeals,
  });

  List<Deal> blockDeals;
  List<Deal> bulkDeals;
  List<Deal> insiderDeals;
  List<Deal> sastDeals;

  factory Deals.fromJson(Map<String, dynamic> json) => Deals(
        blockDeals:
            List<Deal>.from(json["block_deals"].map((x) => Deal.fromJson(x))),
        bulkDeals:
            List<Deal>.from(json["bulk_deals"].map((x) => Deal.fromJson(x))),
        insiderDeals:
            List<Deal>.from(json["insider_deals"].map((x) => Deal.fromJson(x))),
        sastDeals:
            List<Deal>.from(json["sast_deals"].map((x) => Deal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "block_deals": List<dynamic>.from(blockDeals.map((x) => x.toJson())),
        "bulk_deals": List<dynamic>.from(bulkDeals.map((x) => x.toJson())),
        "insider_deals":
            List<dynamic>.from(insiderDeals.map((x) => x.toJson())),
        "sast_deals": List<dynamic>.from(sastDeals.map((x) => x.toJson())),
      };
}

class Deal {
  Deal({
    this.date,
    this.dealType,
    this.name,
    this.price,
    this.quantity,
    this.traded,
    this.group,
    this.postTxnHold,
  });

  String date;
  String dealType;
  String name;
  String price;
  String quantity;
  String traded;
  String group;
  String postTxnHold;

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
        date: json["date"],
        dealType: json["dealType"],
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
        traded: json["traded"],
        group: json["group"] == null ? null : json["group"],
        postTxnHold:
            json["post_txn_hold"] == null ? null : json["post_txn_hold"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "dealType": dealType,
        "name": name,
        "price": price,
        "quantity": quantity,
        "traded": traded,
        "group": group == null ? null : group,
        "post_txn_hold": postTxnHold == null ? null : postTxnHold,
      };
}

class Delivery {
  Delivery({
    this.anlysisData,
    this.tableData,
  });

  List<AnlysisDatum> anlysisData;
  List<DeliveryTableDatum> tableData;

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        anlysisData: json != null
            ? List<AnlysisDatum>.from(
                json["anlysis_data"].map((x) => AnlysisDatum.fromJson(x)))
            : null,
        tableData: json != null
            ? List<DeliveryTableDatum>.from(
                json["table_data"].map((x) => DeliveryTableDatum.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "anlysis_data": List<dynamic>.from(anlysisData.map((x) => x.toJson())),
        "table_data": List<dynamic>.from(tableData.map((x) => x.toJson())),
      };
}

class AnlysisDatum {
  AnlysisDatum({
    this.mssg,
    this.status,
  });

  String mssg;
  String status;

  factory AnlysisDatum.fromJson(Map<String, dynamic> json) => AnlysisDatum(
        mssg: json["mssg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "mssg": mssg,
        "status": status,
      };
}

class DeliveryTableDatum {
  DeliveryTableDatum({
    this.date,
    this.delivery,
    this.deliveryVolumeBse,
    this.deliveryVolumeNse,
    this.totalDeliveryVolume,
    this.totalVolume,
  });

  String date;
  String delivery;
  String deliveryVolumeBse;
  String deliveryVolumeNse;
  String totalDeliveryVolume;
  String totalVolume;

  factory DeliveryTableDatum.fromJson(Map<String, dynamic> json) =>
      DeliveryTableDatum(
        date: json["date"],
        delivery: json["delivery_%"],
        deliveryVolumeBse: json["delivery_volume_bse"],
        deliveryVolumeNse: json["delivery_volume_nse"],
        totalDeliveryVolume: json["total_delivery_volume"],
        totalVolume: json["total_volume"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "delivery_%": delivery,
        "delivery_volume_bse": deliveryVolumeBse,
        "delivery_volume_nse": deliveryVolumeNse,
        "total_delivery_volume": totalDeliveryVolume,
        "total_volume": totalVolume,
      };
}

class Esg {
  Esg({
    this.environmentRiskScore,
    this.governanceRiskScore,
    this.rating,
    this.socialRiskScore,
    this.totalEsgRiskScore,
  });

  String environmentRiskScore;
  String governanceRiskScore;
  String rating;
  String socialRiskScore;
  String totalEsgRiskScore;

  factory Esg.fromJson(Map<String, dynamic> json) => Esg(
        environmentRiskScore: json["environment_risk_score"],
        governanceRiskScore: json["governance_risk_score"],
        rating: json["rating"],
        socialRiskScore: json["social_risk_score"],
        totalEsgRiskScore: json["total_esg_risk_score"],
      );

  Map<String, dynamic> toJson() => {
        "environment_risk_score": environmentRiskScore,
        "governance_risk_score": governanceRiskScore,
        "rating": rating,
        "social_risk_score": socialRiskScore,
        "total_esg_risk_score": totalEsgRiskScore,
      };
}

class FinancialsBalancesheet {
  FinancialsBalancesheet({
    this.analysis,
    this.consolidated,
    this.standalone,
  });

  List<FinancialsBalancesheetAnalysis> analysis;
  FinancialsBalancesheetConsolidated consolidated;
  FinancialsBalancesheetConsolidated standalone;

  factory FinancialsBalancesheet.fromJson(Map<String, dynamic> json) =>
      FinancialsBalancesheet(
        analysis: List<FinancialsBalancesheetAnalysis>.from(json["analysis"]
            .map((x) => FinancialsBalancesheetAnalysis.fromJson(x))),
        consolidated:
            FinancialsBalancesheetConsolidated.fromJson(json["consolidated"]),
        standalone:
            FinancialsBalancesheetConsolidated.fromJson(json["standalone"]),
      );

  Map<String, dynamic> toJson() => {
        "analysis": List<dynamic>.from(analysis.map((x) => x.toJson())),
        "consolidated": consolidated.toJson(),
        "standalone": standalone.toJson(),
      };
}

class FinancialsBalancesheetAnalysis {
  FinancialsBalancesheetAnalysis({
    this.description,
    this.dir,
    this.header,
  });

  String description;
  String dir;
  String header;

  factory FinancialsBalancesheetAnalysis.fromJson(Map<String, dynamic> json) =>
      FinancialsBalancesheetAnalysis(
        description: json["description"].toString(),
        dir: json["dir"].toString(),
        header: json["header"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "dir": dir,
        "header": header,
      };
}

class FinancialsBalancesheetConsolidated {
  FinancialsBalancesheetConsolidated({
    this.assets,
    this.equitiesLiabilities,
    this.others,
    this.quarters,
  });

  Assets assets;
  EquitiesLiabilities equitiesLiabilities;
  Others others;
  List<String> quarters;

  factory FinancialsBalancesheetConsolidated.fromJson(
          Map<String, dynamic> json) =>
      FinancialsBalancesheetConsolidated(
        assets: Assets.fromJson(json["assets"]),
        equitiesLiabilities:
            EquitiesLiabilities.fromJson(json["equities_liabilities"]),
        others: Others.fromJson(json["others"]),
        quarters: List<String>.from(json["quarters"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "assets": assets.toJson(),
        "equities_liabilities": equitiesLiabilities.toJson(),
        "others": others.toJson(),
        "quarters": List<dynamic>.from(quarters.map((x) => x)),
      };
}

class Assets {
  Assets({
    this.currentAssets,
    this.fixedAssets,
    this.otherAssets,
    this.totalAssets,
  });

  List<String> currentAssets;
  List<String> fixedAssets;
  List<String> otherAssets;
  List<String> totalAssets;

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
        currentAssets: List<String>.from(json["current_assets"].map((x) => x)),
        fixedAssets: List<String>.from(json["fixed_assets"].map((x) => x)),
        otherAssets: List<String>.from(json["other_assets"].map((x) => x)),
        totalAssets: List<String>.from(json["total_assets"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "current_assets": List<dynamic>.from(currentAssets.map((x) => x)),
        "fixed_assets": List<dynamic>.from(fixedAssets.map((x) => x)),
        "other_assets": List<dynamic>.from(otherAssets.map((x) => x)),
        "total_assets": List<dynamic>.from(totalAssets.map((x) => x)),
      };
}

class EquitiesLiabilities {
  EquitiesLiabilities({
    this.currentLiabilities,
    this.otherLiabilities,
    this.reservesSurplus,
    this.shareCapital,
    this.totalLiabilities,
  });

  List<String> currentLiabilities;
  List<String> otherLiabilities;
  List<String> reservesSurplus;
  List<String> shareCapital;
  List<String> totalLiabilities;

  factory EquitiesLiabilities.fromJson(Map<String, dynamic> json) =>
      EquitiesLiabilities(
        currentLiabilities:
            List<String>.from(json["current_liabilities"].map((x) => x)),
        otherLiabilities:
            List<String>.from(json["other_liabilities"].map((x) => x)),
        reservesSurplus:
            List<String>.from(json["reserves_surplus"].map((x) => x)),
        shareCapital: List<String>.from(json["share_capital"].map((x) => x)),
        totalLiabilities:
            List<String>.from(json["total_liabilities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "current_liabilities":
            List<dynamic>.from(currentLiabilities.map((x) => x)),
        "other_liabilities": List<dynamic>.from(otherLiabilities.map((x) => x)),
        "reserves_surplus": List<dynamic>.from(reservesSurplus.map((x) => x)),
        "share_capital": List<dynamic>.from(shareCapital.map((x) => x)),
        "total_liabilities": List<dynamic>.from(totalLiabilities.map((x) => x)),
      };
}

class Others {
  Others({
    this.contingentLiabilities,
  });

  List<String> contingentLiabilities;

  factory Others.fromJson(Map<String, dynamic> json) => Others(
        contingentLiabilities:
            List<String>.from(json["contingent_liabilities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "contingent_liabilities":
            List<dynamic>.from(contingentLiabilities.map((x) => x)),
      };
}

class FinancialsCashflow {
  FinancialsCashflow({
    this.consolidated,
    this.standalone,
  });

  FinancialsCashflowConsolidated consolidated;
  FinancialsCashflowConsolidated standalone;

  factory FinancialsCashflow.fromJson(Map<String, dynamic> json) =>
      FinancialsCashflow(
        consolidated:
            FinancialsCashflowConsolidated.fromJson(json["consolidated"]),
        standalone: FinancialsCashflowConsolidated.fromJson(json["standalone"]),
      );

  Map<String, dynamic> toJson() => {
        "consolidated": consolidated.toJson(),
        "standalone": standalone.toJson(),
      };
}

class FinancialsCashflowConsolidated {
  FinancialsCashflowConsolidated({
    this.financingActivities,
    this.headings,
    this.investingActivities,
    this.operatingActivities,
    this.others,
  });

  List<String> financingActivities;
  List<String> headings;
  List<String> investingActivities;
  List<String> operatingActivities;
  List<String> others;

  factory FinancialsCashflowConsolidated.fromJson(Map<String, dynamic> json) =>
      FinancialsCashflowConsolidated(
        financingActivities: json != null
            ? List<String>.from(json["financing_activities"].map((x) => x))
            : [],
        headings: json != null
            ? List<String>.from(json["headings"].map((x) => x))
            : [],
        investingActivities: json != null
            ? List<String>.from(json["investing_activities"].map((x) => x))
            : [],
        operatingActivities: json != null
            ? List<String>.from(json["operating_activities"].map((x) => x))
            : [],
        others:
            json != null ? List<String>.from(json["others"].map((x) => x)) : [],
      );

  Map<String, dynamic> toJson() => {
        "financing_activities":
            List<dynamic>.from(financingActivities.map((x) => x)),
        "headings": List<dynamic>.from(headings.map((x) => x)),
        "investing_activities":
            List<dynamic>.from(investingActivities.map((x) => x)),
        "operating_activities":
            List<dynamic>.from(operatingActivities.map((x) => x)),
        "others": List<dynamic>.from(others.map((x) => x)),
      };
}

class FinancialsDividends {
  FinancialsDividends({
    this.dividendPart,
    this.dividendYieldPart,
  });

  DividendPart dividendPart;
  DividendYieldPart dividendYieldPart;

  factory FinancialsDividends.fromJson(Map<String, dynamic> json) =>
      FinancialsDividends(
        dividendPart: DividendPart.fromJson(json["dividend_part"]),
        dividendYieldPart:
            DividendYieldPart.fromJson(json["dividend_yield_part"]),
      );

  Map<String, dynamic> toJson() => {
        "dividend_part": dividendPart.toJson(),
        "dividend_yield_part": dividendYieldPart.toJson(),
      };
}

class DividendPart {
  DividendPart({
    this.annualizedGrowthLast5Years,
    this.annualizedPayout,
    this.dividendCompanyName,
    this.dividendYield,
    this.payoutRatio,
  });

  AnnualizedGrowthLast5Years annualizedGrowthLast5Years;
  AnnualizedGrowthLast5Years annualizedPayout;
  String dividendCompanyName;
  AnnualizedGrowthLast5Years dividendYield;
  AnnualizedGrowthLast5Years payoutRatio;

  factory DividendPart.fromJson(Map<String, dynamic> json) => DividendPart(
        annualizedGrowthLast5Years: AnnualizedGrowthLast5Years.fromJson(
            json["annualized_growth_last_5_years"]),
        annualizedPayout:
            AnnualizedGrowthLast5Years.fromJson(json["annualized_payout"]),
        dividendCompanyName: json["dividend_company_name"],
        dividendYield:
            AnnualizedGrowthLast5Years.fromJson(json["dividend_yield"]),
        payoutRatio: AnnualizedGrowthLast5Years.fromJson(json["payout_ratio"]),
      );

  Map<String, dynamic> toJson() => {
        "annualized_growth_last_5_years": annualizedGrowthLast5Years.toJson(),
        "annualized_payout": annualizedPayout.toJson(),
        "dividend_company_name": dividendCompanyName,
        "dividend_yield": dividendYield.toJson(),
        "payout_ratio": payoutRatio.toJson(),
      };
}

class AnnualizedGrowthLast5Years {
  AnnualizedGrowthLast5Years({
    this.company,
    this.industry,
  });

  String company;
  String industry;

  factory AnnualizedGrowthLast5Years.fromJson(Map<String, dynamic> json) =>
      AnnualizedGrowthLast5Years(
        company: json != null ? json["company"] : "-",
        industry: json != null ? json["industry"] : "-",
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "industry": industry,
      };
}

class DividendYieldPart {
  DividendYieldPart({
    this.dividend,
    this.epsPayoutRatio,
    this.exDividendDate,
    this.paymentDate,
    this.type,
    this.dividendYieldPartYield,
  });

  List<String> dividend;
  List<String> epsPayoutRatio;
  List<String> exDividendDate;
  List<String> paymentDate;
  List<String> type;
  List<String> dividendYieldPartYield;

  factory DividendYieldPart.fromJson(Map<String, dynamic> json) =>
      DividendYieldPart(
        dividend: List<String>.from(json["dividend"].map((x) => x)),
        epsPayoutRatio:
            List<String>.from(json["eps_payout_ratio"].map((x) => x)),
        exDividendDate:
            List<String>.from(json["ex_dividend_date"].map((x) => x)),
        paymentDate: List<String>.from(json["payment_date"].map((x) => x)),
        type: List<String>.from(json["type"].map((x) => x)),
        dividendYieldPartYield: List<String>.from(json["yield"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "dividend": List<dynamic>.from(dividend.map((x) => x)),
        "eps_payout_ratio": List<dynamic>.from(epsPayoutRatio.map((x) => x)),
        "ex_dividend_date": List<dynamic>.from(exDividendDate.map((x) => x)),
        "payment_date": List<dynamic>.from(paymentDate.map((x) => x)),
        "type": List<dynamic>.from(type.map((x) => x)),
        "yield": List<dynamic>.from(dividendYieldPartYield.map((x) => x)),
      };
}

class FinancialsEarnings {
  FinancialsEarnings({
    this.earningsTableData,
    this.epsForecast,
    this.latestRelease,
    this.revenueForecast,
  });

  List<EarningsTableDatum> earningsTableData;
  String epsForecast;
  String latestRelease;
  String revenueForecast;

  factory FinancialsEarnings.fromJson(Map<String, dynamic> json) =>
      FinancialsEarnings(
        earningsTableData: List<EarningsTableDatum>.from(
            json["earnings_table_data"]
                .map((x) => EarningsTableDatum.fromJson(x))),
        epsForecast: json["eps_forecast"],
        latestRelease: json["latest_release"],
        revenueForecast: json["revenue_forecast"],
      );

  Map<String, dynamic> toJson() => {
        "earnings_table_data":
            List<dynamic>.from(earningsTableData.map((x) => x.toJson())),
        "eps_forecast": epsForecast,
        "latest_release": latestRelease,
        "revenue_forecast": revenueForecast,
      };
}

class EarningsTableDatum {
  EarningsTableDatum({
    this.date,
    this.epsForecast,
    this.periodEnd,
    this.revenueForecast,
  });

  String date;
  String epsForecast;
  String periodEnd;
  String revenueForecast;

  factory EarningsTableDatum.fromJson(Map<String, dynamic> json) =>
      EarningsTableDatum(
        date: json["date"],
        epsForecast: json["eps_forecast"],
        periodEnd: json["period_end"],
        revenueForecast: json["revenue_forecast"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "eps_forecast": epsForecast,
        "period_end": periodEnd,
        "revenue_forecast": revenueForecast,
      };
}

class FinancialsIncomeStatement {
  FinancialsIncomeStatement({
    this.analysis,
    this.consolidated,
    this.standalone,
  });

  List<FinancialsIncomeStatementAnalysis> analysis;
  FinancialsIncomeStatementConsolidated consolidated;
  FinancialsIncomeStatementConsolidated standalone;

  factory FinancialsIncomeStatement.fromJson(Map<String, dynamic> json) =>
      FinancialsIncomeStatement(
        analysis: List<FinancialsIncomeStatementAnalysis>.from(json["analysis"]
            .map((x) => FinancialsIncomeStatementAnalysis.fromJson(x))),
        consolidated: FinancialsIncomeStatementConsolidated.fromJson(
            json["consolidated"]),
        standalone:
            FinancialsIncomeStatementConsolidated.fromJson(json["standalone"]),
      );

  Map<String, dynamic> toJson() => {
        "analysis": List<dynamic>.from(analysis.map((x) => x.toJson())),
        "consolidated": consolidated.toJson(),
        "standalone": standalone.toJson(),
      };
}

class FinancialsIncomeStatementAnalysis {
  FinancialsIncomeStatementAnalysis({
    this.dir,
    this.prefix,
    this.sentence,
    this.suffix,
  });

  String dir;
  String prefix;
  String sentence;
  String suffix;

  factory FinancialsIncomeStatementAnalysis.fromJson(
          Map<String, dynamic> json) =>
      FinancialsIncomeStatementAnalysis(
        dir: json["dir"].toString(),
        prefix: json["prefix"],
        sentence: json["sentence"],
        suffix: json["suffix"] == null ? null : json["suffix"],
      );

  Map<String, dynamic> toJson() => {
        "dir": dir,
        "prefix": prefix,
        "sentence": sentence,
        "suffix": suffix == null ? null : suffix,
      };
}

class FinancialsIncomeStatementConsolidated {
  FinancialsIncomeStatementConsolidated({
    this.halfyearlyReturns,
    this.ninemonthsReturns,
    this.quarterlyReturns,
    this.yearlyReturns,
  });

  Returns halfyearlyReturns;
  Returns ninemonthsReturns;
  Returns quarterlyReturns;
  Returns yearlyReturns;

  factory FinancialsIncomeStatementConsolidated.fromJson(
          Map<String, dynamic> json) =>
      FinancialsIncomeStatementConsolidated(
        halfyearlyReturns: Returns.fromJson(json["halfyearly_returns"]),
        ninemonthsReturns: Returns.fromJson(json["ninemonths_returns"]),
        quarterlyReturns: Returns.fromJson(json["quarterly_returns"]),
        yearlyReturns: Returns.fromJson(json["yearly_returns"]),
      );

  Map<String, dynamic> toJson() => {
        "halfyearly_returns": halfyearlyReturns.toJson(),
        "ninemonths_returns": ninemonthsReturns.toJson(),
        "quarterly_returns": quarterlyReturns.toJson(),
        "yearly_returns": yearlyReturns.toJson(),
      };
}

class Returns {
  Returns({
    this.ebit,
    this.interest,
    this.netProfit,
    this.otherIncome,
    this.quarters,
    this.sales,
    this.tax,
    this.totalExpenditure,
  });

  List<String> ebit;
  List<String> interest;
  List<String> netProfit;
  List<String> otherIncome;
  List<String> quarters;
  List<String> sales;
  List<String> tax;
  List<String> totalExpenditure;

  factory Returns.fromJson(Map<String, dynamic> json) => Returns(
        ebit: List<String>.from(json["ebit"].map((x) => x)),
        interest: List<String>.from(json["interest"].map((x) => x)),
        netProfit: List<String>.from(json["net_profit"].map((x) => x)),
        otherIncome: List<String>.from(json["other_income"].map((x) => x)),
        quarters: List<String>.from(json["quarters"].map((x) => x)),
        sales: List<String>.from(json["sales"].map((x) => x)),
        tax: List<String>.from(json["tax"].map((x) => x)),
        totalExpenditure:
            List<String>.from(json["total_expenditure"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ebit": List<dynamic>.from(ebit.map((x) => x)),
        "interest": List<dynamic>.from(interest.map((x) => x)),
        "net_profit": List<dynamic>.from(netProfit.map((x) => x)),
        "other_income": List<dynamic>.from(otherIncome.map((x) => x)),
        "quarters": List<dynamic>.from(quarters.map((x) => x)),
        "sales": List<dynamic>.from(sales.map((x) => x)),
        "tax": List<dynamic>.from(tax.map((x) => x)),
        "total_expenditure": List<dynamic>.from(totalExpenditure.map((x) => x)),
      };
}

class FinancialsProfitLoss {
  FinancialsProfitLoss({
    this.analysis,
    this.consolidated,
    this.standalone,
  });

  List<FinancialsIncomeStatementAnalysis> analysis;
  FinancialsProfitLossConsolidated consolidated;
  FinancialsProfitLossConsolidated standalone;

  factory FinancialsProfitLoss.fromJson(Map<String, dynamic> json) =>
      FinancialsProfitLoss(
        analysis: List<FinancialsIncomeStatementAnalysis>.from(json["analysis"]
            .map((x) => FinancialsIncomeStatementAnalysis.fromJson(x))),
        consolidated:
            FinancialsProfitLossConsolidated.fromJson(json["consolidated"]),
        standalone:
            FinancialsProfitLossConsolidated.fromJson(json["standalone"]),
      );

  Map<String, dynamic> toJson() => {
        "analysis": List<dynamic>.from(analysis.map((x) => x.toJson())),
        "consolidated": consolidated.toJson(),
        "standalone": standalone.toJson(),
      };
}

class FinancialsProfitLossConsolidated {
  FinancialsProfitLossConsolidated({
    this.dividendDividendPercentage,
    this.earningsPerShare,
    this.expenses,
    this.income,
    this.quarters,
    this.taxExpensesContinued,
  });

  DividendDividendPercentage dividendDividendPercentage;
  EarningsPerShare earningsPerShare;
  Expenses expenses;
  Income income;
  List<String> quarters;
  TaxExpensesContinued taxExpensesContinued;

  factory FinancialsProfitLossConsolidated.fromJson(
          Map<String, dynamic> json) =>
      FinancialsProfitLossConsolidated(
        dividendDividendPercentage: DividendDividendPercentage.fromJson(
            json["dividend_&_dividend_percentage"]),
        earningsPerShare: EarningsPerShare.fromJson(json["earnings_per_share"]),
        expenses: Expenses.fromJson(json["expenses"]),
        income: Income.fromJson(json["income"]),
        quarters: List<String>.from(json["quarters"].map((x) => x)),
        taxExpensesContinued:
            TaxExpensesContinued.fromJson(json["tax_expenses_continued"]),
      );

  Map<String, dynamic> toJson() => {
        "dividend_&_dividend_percentage": dividendDividendPercentage.toJson(),
        "earnings_per_share": earningsPerShare.toJson(),
        "expenses": expenses.toJson(),
        "income": income.toJson(),
        "quarters": List<dynamic>.from(quarters.map((x) => x)),
        "tax_expenses_continued": taxExpensesContinued.toJson(),
      };
}

class DividendDividendPercentage {
  DividendDividendPercentage({
    this.equityShareDividend,
    this.taxOnDividend,
  });

  List<String> equityShareDividend;
  List<String> taxOnDividend;

  factory DividendDividendPercentage.fromJson(Map<String, dynamic> json) =>
      DividendDividendPercentage(
        equityShareDividend:
            List<String>.from(json["equity_share_dividend"].map((x) => x)),
        taxOnDividend: List<String>.from(json["tax_on_dividend"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "equity_share_dividend":
            List<dynamic>.from(equityShareDividend.map((x) => x)),
        "tax_on_dividend": List<dynamic>.from(taxOnDividend.map((x) => x)),
      };
}

class EarningsPerShare {
  EarningsPerShare({
    this.basicEps,
    this.dilutedEps,
  });

  List<String> basicEps;
  List<String> dilutedEps;

  factory EarningsPerShare.fromJson(Map<String, dynamic> json) =>
      EarningsPerShare(
        basicEps: List<String>.from(json["basic_eps"].map((x) => x)),
        dilutedEps: List<String>.from(json["diluted_eps"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "basic_eps": List<dynamic>.from(basicEps.map((x) => x)),
        "diluted_eps": List<dynamic>.from(dilutedEps.map((x) => x)),
      };
}

class Expenses {
  Expenses({
    this.costOfMaterialsConsumed,
    this.depreciationAmortisation,
    this.employeeBenefitExpenses,
    this.exceptionalItems,
    this.financeCosts,
    this.operatingDirectExpenses,
    this.otherExpenses,
    this.plBeforeExcpExtr,
    this.plBeforeTax,
    this.totalExpenses,
  });

  List<String> costOfMaterialsConsumed;
  List<String> depreciationAmortisation;
  List<String> employeeBenefitExpenses;
  List<String> exceptionalItems;
  List<String> financeCosts;
  List<String> operatingDirectExpenses;
  List<String> otherExpenses;
  List<String> plBeforeExcpExtr;
  List<String> plBeforeTax;
  List<String> totalExpenses;

  factory Expenses.fromJson(Map<String, dynamic> json) => Expenses(
        costOfMaterialsConsumed:
            List<String>.from(json["cost_of_materials_consumed"].map((x) => x)),
        depreciationAmortisation:
            List<String>.from(json["depreciation_amortisation"].map((x) => x)),
        employeeBenefitExpenses:
            List<String>.from(json["employee_benefit_expenses"].map((x) => x)),
        exceptionalItems:
            List<String>.from(json["exceptional_items"].map((x) => x)),
        financeCosts: List<String>.from(json["finance_costs"].map((x) => x)),
        operatingDirectExpenses:
            List<String>.from(json["operating_direct_expenses"].map((x) => x)),
        otherExpenses: List<String>.from(json["other_expenses"].map((x) => x)),
        plBeforeExcpExtr:
            List<String>.from(json["pl_before_excp_extr"].map((x) => x)),
        plBeforeTax: List<String>.from(json["pl_before_tax"].map((x) => x)),
        totalExpenses: List<String>.from(json["total_expenses"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "cost_of_materials_consumed":
            List<dynamic>.from(costOfMaterialsConsumed.map((x) => x)),
        "depreciation_amortisation":
            List<dynamic>.from(depreciationAmortisation.map((x) => x)),
        "employee_benefit_expenses":
            List<dynamic>.from(employeeBenefitExpenses.map((x) => x)),
        "exceptional_items": List<dynamic>.from(exceptionalItems.map((x) => x)),
        "finance_costs": List<dynamic>.from(financeCosts.map((x) => x)),
        "operating_direct_expenses":
            List<dynamic>.from(operatingDirectExpenses.map((x) => x)),
        "other_expenses": List<dynamic>.from(otherExpenses.map((x) => x)),
        "pl_before_excp_extr":
            List<dynamic>.from(plBeforeExcpExtr.map((x) => x)),
        "pl_before_tax": List<dynamic>.from(plBeforeTax.map((x) => x)),
        "total_expenses": List<dynamic>.from(totalExpenses.map((x) => x)),
      };
}

class Income {
  Income({
    this.lessExciseStOl,
    this.otherIncome,
    this.revenueFromOperationsGross,
    this.revenueFromOperationsNet,
    this.totalOperatingRevenue,
    this.totalRevenue,
  });

  List<String> lessExciseStOl;
  List<String> otherIncome;
  List<String> revenueFromOperationsGross;
  List<String> revenueFromOperationsNet;
  List<String> totalOperatingRevenue;
  List<String> totalRevenue;

  factory Income.fromJson(Map<String, dynamic> json) => Income(
        lessExciseStOl:
            List<String>.from(json["less_excise_st_ol"].map((x) => x)),
        otherIncome: List<String>.from(json["other_income"].map((x) => x)),
        revenueFromOperationsGross: List<String>.from(
            json["revenue_from_operations_gross"].map((x) => x)),
        revenueFromOperationsNet: List<String>.from(
            json["revenue_from_operations_net"].map((x) => x)),
        totalOperatingRevenue:
            List<String>.from(json["total_operating_revenue"].map((x) => x)),
        totalRevenue: List<String>.from(json["total_revenue"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "less_excise_st_ol": List<dynamic>.from(lessExciseStOl.map((x) => x)),
        "other_income": List<dynamic>.from(otherIncome.map((x) => x)),
        "revenue_from_operations_gross":
            List<dynamic>.from(revenueFromOperationsGross.map((x) => x)),
        "revenue_from_operations_net":
            List<dynamic>.from(revenueFromOperationsNet.map((x) => x)),
        "total_operating_revenue":
            List<dynamic>.from(totalOperatingRevenue.map((x) => x)),
        "total_revenue": List<dynamic>.from(totalRevenue.map((x) => x)),
      };
}

class TaxExpensesContinued {
  TaxExpensesContinued({
    this.currentTax,
    this.deferredTax,
    this.lessMatCreditEntitlement,
    this.otherDirectTaxes,
    this.plAfterTaxBeforeExtraItems,
    this.plForThePeriod,
    this.plFromContinuingOperations,
    this.totalTaxExpenses,
  });

  List<String> currentTax;
  List<String> deferredTax;
  List<String> lessMatCreditEntitlement;
  List<String> otherDirectTaxes;
  List<String> plAfterTaxBeforeExtraItems;
  List<String> plForThePeriod;
  List<String> plFromContinuingOperations;
  List<String> totalTaxExpenses;

  factory TaxExpensesContinued.fromJson(Map<String, dynamic> json) =>
      TaxExpensesContinued(
        currentTax: List<String>.from(json["current_tax"].map((x) => x)),
        deferredTax: List<String>.from(json["deferred_tax"].map((x) => x)),
        lessMatCreditEntitlement: List<String>.from(
            json["less_mat_credit_entitlement"].map((x) => x)),
        otherDirectTaxes:
            List<String>.from(json["other_direct_taxes"].map((x) => x)),
        plAfterTaxBeforeExtraItems: List<String>.from(
            json["pl_after_tax_before_extra_items"].map((x) => x)),
        plForThePeriod:
            List<String>.from(json["pl_for_the_period"].map((x) => x)),
        plFromContinuingOperations: List<String>.from(
            json["pl_from_continuing_operations"].map((x) => x)),
        totalTaxExpenses:
            List<String>.from(json["total_tax_expenses"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "current_tax": List<dynamic>.from(currentTax.map((x) => x)),
        "deferred_tax": List<dynamic>.from(deferredTax.map((x) => x)),
        "less_mat_credit_entitlement":
            List<dynamic>.from(lessMatCreditEntitlement.map((x) => x)),
        "other_direct_taxes":
            List<dynamic>.from(otherDirectTaxes.map((x) => x)),
        "pl_after_tax_before_extra_items":
            List<dynamic>.from(plAfterTaxBeforeExtraItems.map((x) => x)),
        "pl_for_the_period": List<dynamic>.from(plForThePeriod.map((x) => x)),
        "pl_from_continuing_operations":
            List<dynamic>.from(plFromContinuingOperations.map((x) => x)),
        "total_tax_expenses":
            List<dynamic>.from(totalTaxExpenses.map((x) => x)),
      };
}

class FinancialsRatios {
  FinancialsRatios({
    this.consolidated,
    this.standalone,
  });

  FinancialsRatiosConsolidated consolidated;
  FinancialsRatiosConsolidated standalone;

  factory FinancialsRatios.fromJson(Map<String, dynamic> json) =>
      FinancialsRatios(
        consolidated:
            FinancialsRatiosConsolidated.fromJson(json["consolidated"]),
        standalone: FinancialsRatiosConsolidated.fromJson(json["standalone"]),
      );

  Map<String, dynamic> toJson() => {
        "consolidated": consolidated.toJson(),
        "standalone": standalone.toJson(),
      };
}

class FinancialsRatiosConsolidated {
  FinancialsRatiosConsolidated({
    this.growthRatios,
    this.leverageRatios,
    this.liquidityRatios,
    this.marginRatios,
    this.perShareRatios,
    this.quarters,
    this.returnRatios,
    this.turnoverRatios,
    this.valuationRatios,
  });

  GrowthRatios growthRatios;
  LeverageRatios leverageRatios;
  LiquidityRatios liquidityRatios;
  MarginRatios marginRatios;
  PerShareRatios perShareRatios;
  List<String> quarters;
  ReturnRatios returnRatios;
  TurnoverRatios turnoverRatios;
  ValuationRatios valuationRatios;

  factory FinancialsRatiosConsolidated.fromJson(Map<String, dynamic> json) =>
      FinancialsRatiosConsolidated(
        growthRatios: GrowthRatios.fromJson(json["growth_ratios"]),
        leverageRatios: LeverageRatios.fromJson(json["leverage_ratios"]),
        liquidityRatios: LiquidityRatios.fromJson(json["liquidity_ratios"]),
        marginRatios: MarginRatios.fromJson(json["margin_ratios"]),
        perShareRatios: PerShareRatios.fromJson(json["per_share_ratios"]),
        quarters: List<String>.from(json["quarters"].map((x) => x)),
        returnRatios: ReturnRatios.fromJson(json["return_ratios"]),
        turnoverRatios: TurnoverRatios.fromJson(json["turnover_ratios"]),
        valuationRatios: ValuationRatios.fromJson(json["valuation_ratios"]),
      );

  Map<String, dynamic> toJson() => {
        "growth_ratios": growthRatios.toJson(),
        "leverage_ratios": leverageRatios.toJson(),
        "liquidity_ratios": liquidityRatios.toJson(),
        "margin_ratios": marginRatios.toJson(),
        "per_share_ratios": perShareRatios.toJson(),
        "quarters": List<dynamic>.from(quarters.map((x) => x)),
        "return_ratios": returnRatios.toJson(),
        "turnover_ratios": turnoverRatios.toJson(),
        "valuation_ratios": valuationRatios.toJson(),
      };
}

class GrowthRatios {
  GrowthRatios({
    this.the3YearCagrNetProfit,
    this.the3YearCagrSales,
  });

  List<String> the3YearCagrNetProfit;
  List<String> the3YearCagrSales;

  factory GrowthRatios.fromJson(Map<String, dynamic> json) => GrowthRatios(
        the3YearCagrNetProfit:
            List<String>.from(json["3_year_cagr_net_profit"].map((x) => x)),
        the3YearCagrSales:
            List<String>.from(json["3_year_cagr_sales"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "3_year_cagr_net_profit":
            List<dynamic>.from(the3YearCagrNetProfit.map((x) => x)),
        "3_year_cagr_sales":
            List<dynamic>.from(the3YearCagrSales.map((x) => x)),
      };
}

class LeverageRatios {
  LeverageRatios({
    this.debtToEquity,
    this.interestCoverageRatios,
  });

  List<String> debtToEquity;
  List<String> interestCoverageRatios;

  factory LeverageRatios.fromJson(Map<String, dynamic> json) => LeverageRatios(
        debtToEquity: List<String>.from(json["debt_to_equity"].map((x) => x)),
        interestCoverageRatios:
            List<String>.from(json["interest_coverage_ratios"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "debt_to_equity": List<dynamic>.from(debtToEquity.map((x) => x)),
        "interest_coverage_ratios":
            List<dynamic>.from(interestCoverageRatios.map((x) => x)),
      };
}

class LiquidityRatios {
  LiquidityRatios({
    this.currentRatio,
    this.quickRatio,
  });

  List<String> currentRatio;
  List<String> quickRatio;

  factory LiquidityRatios.fromJson(Map<String, dynamic> json) =>
      LiquidityRatios(
        currentRatio: List<String>.from(json["current_ratio"].map((x) => x)),
        quickRatio: List<String>.from(json["quick_ratio"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "current_ratio": List<dynamic>.from(currentRatio.map((x) => x)),
        "quick_ratio": List<dynamic>.from(quickRatio.map((x) => x)),
      };
}

class MarginRatios {
  MarginRatios({
    this.grossProfitMargin,
    this.netProfitMargin,
    this.operatingMargin,
  });

  List<String> grossProfitMargin;
  List<String> netProfitMargin;
  List<String> operatingMargin;

  factory MarginRatios.fromJson(Map<String, dynamic> json) => MarginRatios(
        grossProfitMargin:
            List<String>.from(json["gross_profit_margin"].map((x) => x)),
        netProfitMargin:
            List<String>.from(json["net_profit_margin"].map((x) => x)),
        operatingMargin:
            List<String>.from(json["operating_margin"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "gross_profit_margin":
            List<dynamic>.from(grossProfitMargin.map((x) => x)),
        "net_profit_margin": List<dynamic>.from(netProfitMargin.map((x) => x)),
        "operating_margin": List<dynamic>.from(operatingMargin.map((x) => x)),
      };
}

class PerShareRatios {
  PerShareRatios({
    this.basicEps,
    this.bookvalueShare,
    this.dilutedEps,
    this.dividendShare,
    this.faceValue,
  });

  List<String> basicEps;
  List<String> bookvalueShare;
  List<String> dilutedEps;
  List<String> dividendShare;
  List<String> faceValue;

  factory PerShareRatios.fromJson(Map<String, dynamic> json) => PerShareRatios(
        basicEps: List<String>.from(json["basic_eps"].map((x) => x)),
        bookvalueShare:
            List<String>.from(json["bookvalue_share"].map((x) => x)),
        dilutedEps: List<String>.from(json["diluted_eps"].map((x) => x)),
        dividendShare: List<String>.from(json["dividend_share"].map((x) => x)),
        faceValue: List<String>.from(json["face_value"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "basic_eps": List<dynamic>.from(basicEps.map((x) => x)),
        "bookvalue_share": List<dynamic>.from(bookvalueShare.map((x) => x)),
        "diluted_eps": List<dynamic>.from(dilutedEps.map((x) => x)),
        "dividend_share": List<dynamic>.from(dividendShare.map((x) => x)),
        "face_value": List<dynamic>.from(faceValue.map((x) => x)),
      };
}

class ReturnRatios {
  ReturnRatios({
    this.returnOnAssets,
    this.returnOnNetworthEquity,
    this.roce,
  });

  List<String> returnOnAssets;
  List<String> returnOnNetworthEquity;
  List<String> roce;

  factory ReturnRatios.fromJson(Map<String, dynamic> json) => ReturnRatios(
        returnOnAssets:
            List<String>.from(json["return_on_assets"].map((x) => x)),
        returnOnNetworthEquity:
            List<String>.from(json["return_on_networth_equity"].map((x) => x)),
        roce: List<String>.from(json["roce"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "return_on_assets": List<dynamic>.from(returnOnAssets.map((x) => x)),
        "return_on_networth_equity":
            List<dynamic>.from(returnOnNetworthEquity.map((x) => x)),
        "roce": List<dynamic>.from(roce.map((x) => x)),
      };
}

class TurnoverRatios {
  TurnoverRatios({
    this.assetTurnoverRatio,
    this.inventoryTurnoverRatio,
  });

  List<String> assetTurnoverRatio;
  List<String> inventoryTurnoverRatio;

  factory TurnoverRatios.fromJson(Map<String, dynamic> json) => TurnoverRatios(
        assetTurnoverRatio:
            List<String>.from(json["asset_turnover_ratio"].map((x) => x)),
        inventoryTurnoverRatio:
            List<String>.from(json["inventory_turnover_ratio"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "asset_turnover_ratio":
            List<dynamic>.from(assetTurnoverRatio.map((x) => x)),
        "inventory_turnover_ratio":
            List<dynamic>.from(inventoryTurnoverRatio.map((x) => x)),
      };
}

class ValuationRatios {
  ValuationRatios({
    this.evEbitda,
    this.pB,
    this.pE,
    this.pS,
  });

  List<String> evEbitda;
  List<String> pB;
  List<String> pE;
  List<String> pS;

  factory ValuationRatios.fromJson(Map<String, dynamic> json) =>
      ValuationRatios(
        evEbitda: List<String>.from(json["ev_ebitda"].map((x) => x)),
        pB: List<String>.from(json["p_b"].map((x) => x)),
        pE: List<String>.from(json["p_e"].map((x) => x)),
        pS: List<String>.from(json["p_s"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ev_ebitda": List<dynamic>.from(evEbitda.map((x) => x)),
        "p_b": List<dynamic>.from(pB.map((x) => x)),
        "p_e": List<dynamic>.from(pE.map((x) => x)),
        "p_s": List<dynamic>.from(pS.map((x) => x)),
      };
}

class FinancialsRiskProfile {
  FinancialsRiskProfile({
    this.compoundAnnualGrowthRate,
    this.riskPriceAndValuations,
  });

  FinancialsRiskProfileCompoundAnnualGrowthRate compoundAnnualGrowthRate;
  FinancialsRiskProfileCompoundAnnualGrowthRate riskPriceAndValuations;

  factory FinancialsRiskProfile.fromJson(Map<String, dynamic> json) =>
      FinancialsRiskProfile(
        compoundAnnualGrowthRate:
            FinancialsRiskProfileCompoundAnnualGrowthRate.fromJson(
                json["compound_annual_growth_rate"]),
        riskPriceAndValuations:
            FinancialsRiskProfileCompoundAnnualGrowthRate.fromJson(
                json["risk_price_and_valuations"]),
      );

  Map<String, dynamic> toJson() => {
        "compound_annual_growth_rate": compoundAnnualGrowthRate.toJson(),
        "risk_price_and_valuations": riskPriceAndValuations.toJson(),
      };
}

class FinancialsRiskProfileCompoundAnnualGrowthRate {
  FinancialsRiskProfileCompoundAnnualGrowthRate({
    this.accountCostOfDebit,
    this.costOfEquityCapmModel,
    this.creditDefaultSpread,
    this.dividendYield,
    this.earningYield,
    this.enterpriceValue,
    this.leveredBeta,
    this.marketCap,
    this.pbvPriceToBookValue,
    this.pcfoPriceToCashFlowFromOperations,
    this.pePriceToEarning,
    this.compoundAnnualGrowthRatePegPriceByEarningToGrowth,
    this.period,
    this.psPriceToSalesRevenue,
    this.waccWightedCostOfCapital,
    this.weightOfEquityWacc,
    this.weightToDebtWacc,
    this.compoundAnnualGrowthRateCostOfEquityCapmModel,
    this.compoundAnnualGrowthRatePcfoPriceToCashFlowFromOperations,
    this.pegPriceByEarningToGrowth,
    this.years,
  });

  List<String> accountCostOfDebit;
  List<String> costOfEquityCapmModel;
  List<String> creditDefaultSpread;
  List<String> dividendYield;
  List<String> earningYield;
  List<String> enterpriceValue;
  List<String> leveredBeta;
  List<String> marketCap;
  List<String> pbvPriceToBookValue;
  List<String> pcfoPriceToCashFlowFromOperations;
  List<String> pePriceToEarning;
  List<String> compoundAnnualGrowthRatePegPriceByEarningToGrowth;
  List<String> period;
  List<String> psPriceToSalesRevenue;
  List<String> waccWightedCostOfCapital;
  List<String> weightOfEquityWacc;
  List<String> weightToDebtWacc;
  List<String> compoundAnnualGrowthRateCostOfEquityCapmModel;
  List<String> compoundAnnualGrowthRatePcfoPriceToCashFlowFromOperations;
  List<String> pegPriceByEarningToGrowth;
  List<String> years;

  factory FinancialsRiskProfileCompoundAnnualGrowthRate.fromJson(
          Map<String, dynamic> json) =>
      FinancialsRiskProfileCompoundAnnualGrowthRate(
        accountCostOfDebit:
            List<String>.from(json["account_cost_of_debit"].map((x) => x)),
        costOfEquityCapmModel: json["cost_of_equity_capm model"] == null
            ? null
            : List<String>.from(
                json["cost_of_equity_capm model"].map((x) => x)),
        creditDefaultSpread:
            List<String>.from(json["credit_default_spread"].map((x) => x)),
        dividendYield: List<String>.from(json["dividend_yield"].map((x) => x)),
        earningYield: List<String>.from(json["earning_yield"].map((x) => x)),
        enterpriceValue:
            List<String>.from(json["enterprice_value"].map((x) => x)),
        leveredBeta: List<String>.from(json["levered_beta"].map((x) => x)),
        marketCap: List<String>.from(json["market_cap"].map((x) => x)),
        pbvPriceToBookValue:
            List<String>.from(json["pbv_price_to_book_value"].map((x) => x)),
        pcfoPriceToCashFlowFromOperations:
            json["pcfo_price_to_cash_flow_from_operations"] == null
                ? null
                : List<String>.from(
                    json["pcfo_price_to_cash_flow_from_operations"]
                        .map((x) => x)),
        pePriceToEarning:
            List<String>.from(json["pe_price_to_earning"].map((x) => x)),
        compoundAnnualGrowthRatePegPriceByEarningToGrowth:
            json["peg_price_by_earning_to_growth)"] == null
                ? null
                : List<String>.from(
                    json["peg_price_by_earning_to_growth)"].map((x) => x)),
        period: json["period"] == null
            ? null
            : List<String>.from(json["period"].map((x) => x)),
        psPriceToSalesRevenue:
            List<String>.from(json["ps_price_to_sales_revenue"].map((x) => x)),
        waccWightedCostOfCapital: List<String>.from(
            json["wacc_wighted_cost_of_capital"].map((x) => x)),
        weightOfEquityWacc:
            List<String>.from(json["weight_of_equity_wacc"].map((x) => x)),
        weightToDebtWacc:
            List<String>.from(json["weight_to_debt_wacc"].map((x) => x)),
        compoundAnnualGrowthRateCostOfEquityCapmModel:
            json["cost_of_equity_capm_model"] == null
                ? null
                : List<String>.from(
                    json["cost_of_equity_capm_model"].map((x) => x)),
        compoundAnnualGrowthRatePcfoPriceToCashFlowFromOperations:
            json["pcfo_price_to_cash_flow_from_operations)"] == null
                ? null
                : List<String>.from(
                    json["pcfo_price_to_cash_flow_from_operations)"]
                        .map((x) => x)),
        pegPriceByEarningToGrowth:
            json["peg_price_by_earning_to_growth"] == null
                ? null
                : List<String>.from(
                    json["peg_price_by_earning_to_growth"].map((x) => x)),
        years: json["years"] == null
            ? null
            : List<String>.from(json["years"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "account_cost_of_debit":
            List<dynamic>.from(accountCostOfDebit.map((x) => x)),
        "cost_of_equity_capm model": costOfEquityCapmModel == null
            ? null
            : List<dynamic>.from(costOfEquityCapmModel.map((x) => x)),
        "credit_default_spread":
            List<dynamic>.from(creditDefaultSpread.map((x) => x)),
        "dividend_yield": List<dynamic>.from(dividendYield.map((x) => x)),
        "earning_yield": List<dynamic>.from(earningYield.map((x) => x)),
        "enterprice_value": List<dynamic>.from(enterpriceValue.map((x) => x)),
        "levered_beta": List<dynamic>.from(leveredBeta.map((x) => x)),
        "market_cap": List<dynamic>.from(marketCap.map((x) => x)),
        "pbv_price_to_book_value":
            List<dynamic>.from(pbvPriceToBookValue.map((x) => x)),
        "pcfo_price_to_cash_flow_from_operations":
            pcfoPriceToCashFlowFromOperations == null
                ? null
                : List<dynamic>.from(
                    pcfoPriceToCashFlowFromOperations.map((x) => x)),
        "pe_price_to_earning":
            List<dynamic>.from(pePriceToEarning.map((x) => x)),
        "peg_price_by_earning_to_growth)":
            compoundAnnualGrowthRatePegPriceByEarningToGrowth == null
                ? null
                : List<dynamic>.from(
                    compoundAnnualGrowthRatePegPriceByEarningToGrowth
                        .map((x) => x)),
        "period":
            period == null ? null : List<dynamic>.from(period.map((x) => x)),
        "ps_price_to_sales_revenue":
            List<dynamic>.from(psPriceToSalesRevenue.map((x) => x)),
        "wacc_wighted_cost_of_capital":
            List<dynamic>.from(waccWightedCostOfCapital.map((x) => x)),
        "weight_of_equity_wacc":
            List<dynamic>.from(weightOfEquityWacc.map((x) => x)),
        "weight_to_debt_wacc":
            List<dynamic>.from(weightToDebtWacc.map((x) => x)),
        "cost_of_equity_capm_model":
            compoundAnnualGrowthRateCostOfEquityCapmModel == null
                ? null
                : List<dynamic>.from(
                    compoundAnnualGrowthRateCostOfEquityCapmModel
                        .map((x) => x)),
        "pcfo_price_to_cash_flow_from_operations)":
            compoundAnnualGrowthRatePcfoPriceToCashFlowFromOperations == null
                ? null
                : List<dynamic>.from(
                    compoundAnnualGrowthRatePcfoPriceToCashFlowFromOperations
                        .map((x) => x)),
        "peg_price_by_earning_to_growth": pegPriceByEarningToGrowth == null
            ? null
            : List<dynamic>.from(pegPriceByEarningToGrowth.map((x) => x)),
        "years": years == null ? null : List<dynamic>.from(years.map((x) => x)),
      };
}

class FinancialsSolvency {
  FinancialsSolvency({
    this.compoundAnnualGrowthRate,
    this.riskPriceAndValuations,
  });

  FinancialsSolvencyCompoundAnnualGrowthRate compoundAnnualGrowthRate;
  FinancialsSolvencyCompoundAnnualGrowthRate riskPriceAndValuations;

  factory FinancialsSolvency.fromJson(Map<String, dynamic> json) =>
      FinancialsSolvency(
        compoundAnnualGrowthRate:
            FinancialsSolvencyCompoundAnnualGrowthRate.fromJson(
                json["compound_annual_growth_rate"]),
        riskPriceAndValuations:
            FinancialsSolvencyCompoundAnnualGrowthRate.fromJson(
                json["risk_price_and_valuations"]),
      );

  Map<String, dynamic> toJson() => {
        "compound_annual_growth_rate": compoundAnnualGrowthRate.toJson(),
        "risk_price_and_valuations": riskPriceAndValuations.toJson(),
      };
}

class FinancialsSolvencyCompoundAnnualGrowthRate {
  FinancialsSolvencyCompoundAnnualGrowthRate({
    this.accurals,
    this.compoundAnnualGrowthRateAssetsToShareholderEquity,
    this.capitalizationRatio,
    this.cashRatio,
    this.cfoToDebt,
    this.debtToAssets,
    this.debtToCapital,
    this.dividendCover,
    this.dividendPayout,
    this.interestCoverage,
    this.longTermDebtToEbidta,
    this.longTermDebtToEquityNetWorth,
    this.period,
    this.retentionRatio,
    this.solvencyRatio,
    this.timesInterestEarned,
    this.assetsToShareholderEquity,
    this.compoundAnnualGrowthRateLongTermDebtToEquityNetWorth,
    this.years,
  });

  List<String> accurals;
  List<String> compoundAnnualGrowthRateAssetsToShareholderEquity;
  List<String> capitalizationRatio;
  List<String> cashRatio;
  List<String> cfoToDebt;
  List<String> debtToAssets;
  List<String> debtToCapital;
  List<String> dividendCover;
  List<String> dividendPayout;
  List<String> interestCoverage;
  List<String> longTermDebtToEbidta;
  List<String> longTermDebtToEquityNetWorth;
  List<String> period;
  List<String> retentionRatio;
  List<String> solvencyRatio;
  List<String> timesInterestEarned;
  List<String> assetsToShareholderEquity;
  List<String> compoundAnnualGrowthRateLongTermDebtToEquityNetWorth;
  List<String> years;

  factory FinancialsSolvencyCompoundAnnualGrowthRate.fromJson(
          Map<String, dynamic> json) =>
      FinancialsSolvencyCompoundAnnualGrowthRate(
        accurals: List<String>.from(json["accurals"].map((x) => x)),
        compoundAnnualGrowthRateAssetsToShareholderEquity:
            json["assets_to_shareholder_equity"] == null
                ? null
                : List<String>.from(
                    json["assets_to_shareholder_equity"].map((x) => x)),
        capitalizationRatio:
            List<String>.from(json["capitalization_ratio"].map((x) => x)),
        cashRatio: List<String>.from(json["cash_ratio"].map((x) => x)),
        cfoToDebt: List<String>.from(json["cfo_to_debt"].map((x) => x)),
        debtToAssets: List<String>.from(json["debt_to_assets"].map((x) => x)),
        debtToCapital: List<String>.from(json["debt_to_capital"].map((x) => x)),
        dividendCover: List<String>.from(json["dividend_cover"].map((x) => x)),
        dividendPayout:
            List<String>.from(json["dividend_payout"].map((x) => x)),
        interestCoverage:
            List<String>.from(json["interest_coverage"].map((x) => x)),
        longTermDebtToEbidta:
            List<String>.from(json["long_term_debt_to_ebidta"].map((x) => x)),
        longTermDebtToEquityNetWorth:
            json["long_term_debt_to_equity_(net_worth)"] == null
                ? null
                : List<String>.from(
                    json["long_term_debt_to_equity_(net_worth)"].map((x) => x)),
        period: json["period"] == null
            ? null
            : List<String>.from(json["period"].map((x) => x)),
        retentionRatio:
            List<String>.from(json["retention_ratio"].map((x) => x)),
        solvencyRatio: List<String>.from(json["solvency_ratio"].map((x) => x)),
        timesInterestEarned:
            List<String>.from(json["times_interest_earned"].map((x) => x)),
        assetsToShareholderEquity: json["assets_to_shareholder_equity"] == null
            ? null
            : List<String>.from(
                json["assets_to_shareholder_equity"].map((x) => x)),
        compoundAnnualGrowthRateLongTermDebtToEquityNetWorth:
            json["long_term_debt_to_equity_net worth"] == null
                ? null
                : List<String>.from(
                    json["long_term_debt_to_equity_net worth"].map((x) => x)),
        years: json["years"] == null
            ? null
            : List<String>.from(json["years"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "accurals": List<dynamic>.from(accurals.map((x) => x)),
        "assets_to_shareholder_equity":
            compoundAnnualGrowthRateAssetsToShareholderEquity == null
                ? null
                : List<dynamic>.from(
                    compoundAnnualGrowthRateAssetsToShareholderEquity
                        .map((x) => x)),
        "capitalization_ratio":
            List<dynamic>.from(capitalizationRatio.map((x) => x)),
        "cash_ratio": List<dynamic>.from(cashRatio.map((x) => x)),
        "cfo_to_debt": List<dynamic>.from(cfoToDebt.map((x) => x)),
        "debt_to_assets": List<dynamic>.from(debtToAssets.map((x) => x)),
        "debt_to_capital": List<dynamic>.from(debtToCapital.map((x) => x)),
        "dividend_cover": List<dynamic>.from(dividendCover.map((x) => x)),
        "dividend_payout": List<dynamic>.from(dividendPayout.map((x) => x)),
        "interest_coverage": List<dynamic>.from(interestCoverage.map((x) => x)),
        "long_term_debt_to_ebidta":
            List<dynamic>.from(longTermDebtToEbidta.map((x) => x)),
        "long_term_debt_to_equity_(net_worth)": longTermDebtToEquityNetWorth ==
                null
            ? null
            : List<dynamic>.from(longTermDebtToEquityNetWorth.map((x) => x)),
        "period":
            period == null ? null : List<dynamic>.from(period.map((x) => x)),
        "retention_ratio": List<dynamic>.from(retentionRatio.map((x) => x)),
        "solvency_ratio": List<dynamic>.from(solvencyRatio.map((x) => x)),
        "times_interest_earned":
            List<dynamic>.from(timesInterestEarned.map((x) => x)),
        "assets_to_shareholder equity": assetsToShareholderEquity == null
            ? null
            : List<dynamic>.from(assetsToShareholderEquity.map((x) => x)),
        "long_term_debt_to_equity_net worth":
            compoundAnnualGrowthRateLongTermDebtToEquityNetWorth == null
                ? null
                : List<dynamic>.from(
                    compoundAnnualGrowthRateLongTermDebtToEquityNetWorth
                        .map((x) => x)),
        "years": years == null ? null : List<dynamic>.from(years.map((x) => x)),
      };
}

FutureAndOptions stockFutureandOptionFromJson(String str) =>
    FutureAndOptions.fromJson(json.decode(str)["futures_and_options_data"]);

String stockFutureandOptionToJson(StockDetail data) =>
    json.encode(data.toJson());

class FutureAndOptions {
  FutureAndOptions({
    this.callSummary,
    this.futureSummary,
    this.putSummary,
    this.summary,
  });

  Summary callSummary;
  FutureSummary futureSummary;
  Summary putSummary;
  FutureAndOptionsSummary summary;

  factory FutureAndOptions.fromJson(Map<String, dynamic> json) =>
      FutureAndOptions(
        callSummary:
            json != null ? Summary.fromJson(json["call_summary"]) : null,
        futureSummary: json != null
            ? FutureSummary.fromJson(json["future_summary"])
            : null,
        putSummary: json != null ? Summary.fromJson(json["put_summary"]) : null,
        summary: json != null
            ? FutureAndOptionsSummary.fromJson(json["summary"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "call_summary": callSummary.toJson(),
        "future_summary": futureSummary.toJson(),
        "put_summary": putSummary.toJson(),
        "summary": summary.toJson(),
      };
}

class Summary {
  Summary({
    this.contracts,
    this.cumulativeCallOi,
    this.cumulativeCallOiChange,
    this.maxTradedStrikePrice,
  });

  String contracts;
  String cumulativeCallOi;
  String cumulativeCallOiChange;
  String maxTradedStrikePrice;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        contracts: json["contracts"],
        cumulativeCallOi: json["cumulative_call_oi"],
        cumulativeCallOiChange: json["cumulative_call_oi_change"],
        maxTradedStrikePrice: json["max_traded_strike_price"],
      );

  Map<String, dynamic> toJson() => {
        "contracts": contracts,
        "cumulative_call_oi": cumulativeCallOi,
        "cumulative_call_oi_change": cumulativeCallOiChange,
        "max_traded_strike_price": maxTradedStrikePrice,
      };
}

class FutureSummary {
  FutureSummary({
    this.closingPrice,
    this.futureContracts,
    this.futureContractsChange,
    this.futureOi,
    this.futureOiChange,
    this.premiumDiscount,
    this.previousClose,
    this.previousCloseChange,
  });

  String closingPrice;
  String futureContracts;
  String futureContractsChange;
  String futureOi;
  String futureOiChange;
  String premiumDiscount;
  String previousClose;
  String previousCloseChange;

  factory FutureSummary.fromJson(Map<String, dynamic> json) => FutureSummary(
        closingPrice: json["closing_price"],
        futureContracts: json["future_contracts"],
        futureContractsChange: json["future_contracts_change"],
        futureOi: json["future_oi"],
        futureOiChange: json["future_oi_change"],
        premiumDiscount: json["premium_discount"],
        previousClose: json["previous_close"],
        previousCloseChange: json["previous_close_change"],
      );

  Map<String, dynamic> toJson() => {
        "closing_price": closingPrice,
        "future_contracts": futureContracts,
        "future_contracts_change": futureContractsChange,
        "future_oi": futureOi,
        "future_oi_change": futureOiChange,
        "premium_discount": premiumDiscount,
        "previous_close": previousClose,
        "previous_close_change": previousCloseChange,
      };
}

class FutureAndOptionsSummary {
  FutureAndOptionsSummary({
    this.lotSize,
    this.nearExpiry,
    this.stockClosePrice,
    this.tradeDate,
  });

  String lotSize;
  String nearExpiry;
  String stockClosePrice;
  String tradeDate;

  factory FutureAndOptionsSummary.fromJson(Map<String, dynamic> json) =>
      FutureAndOptionsSummary(
        lotSize: json["lot_size"],
        nearExpiry: json["near_expiry"],
        stockClosePrice: json["stock_close_price"],
        tradeDate: json["trade_date"],
      );

  Map<String, dynamic> toJson() => {
        "lot_size": lotSize,
        "near_expiry": nearExpiry,
        "stock_close_price": stockClosePrice,
        "trade_date": tradeDate,
      };
}

// class HistoricalData {
//   HistoricalData({
//     this.daily,
//     this.monthly,
//     this.weekly,
//   });

//   List<Daily> daily;
//   List<Daily> monthly;
//   List<Daily> weekly;

//   factory HistoricalData.fromJson(Map<String, dynamic> json) => HistoricalData(
//         daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
//         monthly:
//             List<Daily>.from(json["monthly"].map((x) => Daily.fromJson(x))),
//         weekly: List<Daily>.from(json["weekly"].map((x) => Daily.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
//         "monthly": List<dynamic>.from(monthly.map((x) => x.toJson())),
//         "weekly": List<dynamic>.from(weekly.map((x) => x.toJson())),
//       };
// }

// class Daily {
//   Daily({
//     this.adjClose,
//     this.close,
//     this.date,
//     this.high,
//     this.low,
//     this.open,
//     this.volume,
//   });

//   String adjClose;
//   String close;
//   String date;
//   String high;
//   String low;
//   String open;
//   String volume;

//   factory Daily.fromJson(Map<String, dynamic> json) => Daily(
//         adjClose: json["adj_close"],
//         close: json["close"],
//         date: json["date"],
//         high: json["high"],
//         low: json["low"],
//         open: json["open"],
//         volume: json["volume"],
//       );

//   Map<String, dynamic> toJson() => {
//         "adj_close": adjClose,
//         "close": close,
//         "date": date,
//         "high": high,
//         "low": low,
//         "open": open,
//         "volume": volume,
//       };
// }

class Quality {
  Quality({
    this.debtToEbitdaAvg,
    this.dividendPayoutRatio,
    this.ebitGrowth,
    this.ebitToInterestAvg,
    this.institutionalHolding,
    this.netDebtToEquityAvg,
    this.pledgedShares,
    this.quality,
    this.relatedPartyTransactionsToSales,
    this.roceAvg,
    this.roeAvg,
    this.salesGrowth,
    this.salesToCapitalEmployedAvg,
    this.taxRatio,
  });

  String debtToEbitdaAvg;
  String dividendPayoutRatio;
  String ebitGrowth;
  String ebitToInterestAvg;
  String institutionalHolding;
  String netDebtToEquityAvg;
  String pledgedShares;
  String quality;
  String relatedPartyTransactionsToSales;
  String roceAvg;
  String roeAvg;
  String salesGrowth;
  String salesToCapitalEmployedAvg;
  String taxRatio;

  factory Quality.fromJson(Map<String, dynamic> json) => Quality(
        debtToEbitdaAvg: json["debt_to_ebitda_avg"],
        dividendPayoutRatio: json["dividend_payout_ratio"],
        ebitGrowth: json["ebit_growth"],
        ebitToInterestAvg: json["ebit_to_interest_avg"],
        institutionalHolding: json["institutional_holding"],
        netDebtToEquityAvg: json["net_debt_to_equity_avg"],
        pledgedShares: json["pledged_shares"],
        quality: json["quality"],
        relatedPartyTransactionsToSales:
            json["related_party_transactions_to_sales"],
        roceAvg: json["roce_avg"],
        roeAvg: json["roe_avg"],
        salesGrowth: json["sales_growth"],
        salesToCapitalEmployedAvg: json["sales_to_capital_employed_avg"],
        taxRatio: json["tax_ratio"],
      );

  Map<String, dynamic> toJson() => {
        "debt_to_ebitda_avg": debtToEbitdaAvg,
        "dividend_payout_ratio": dividendPayoutRatio,
        "ebit_growth": ebitGrowth,
        "ebit_to_interest_avg": ebitToInterestAvg,
        "institutional_holding": institutionalHolding,
        "net_debt_to_equity_avg": netDebtToEquityAvg,
        "pledged_shares": pledgedShares,
        "quality": quality,
        "related_party_transactions_to_sales": relatedPartyTransactionsToSales,
        "roce_avg": roceAvg,
        "roe_avg": roeAvg,
        "sales_growth": salesGrowth,
        "sales_to_capital_employed_avg": salesToCapitalEmployedAvg,
        "tax_ratio": taxRatio,
      };
}

class QuickSummary {
  QuickSummary({
    this.analysis,
    // this.financialDataHighlights,
    // this.financialRatios,
    // this.highsLows,
    // this.keyMovingAverage,
    // this.keyProfitLossData,
    // this.priceGainLoss,
    // this.priceRangeVolatility,
    // this.priceVolumeAction,
    // this.technicalIndicators,
    this.consolidated,
    this.standalone,
  });

  List<Consolidated> consolidated;
  List<Standalone> standalone;
  List<IndustryComparisonElement> analysis;
  // FinancialDataHighlights financialDataHighlights;
  // FinancialRatios financialRatios;
  // HighsLows highsLows;
  // KeyMovingAverage keyMovingAverage;
  // KeyProfitLossData keyProfitLossData;
  // PriceGainLoss priceGainLoss;
  // PriceRangeVolatility priceRangeVolatility;
  // PriceVolumeAction priceVolumeAction;
  // TechnicalIndicators technicalIndicators;

  factory QuickSummary.fromJson(Map<String, dynamic> json) => QuickSummary(
        analysis: List<IndustryComparisonElement>.from(
            json["analysis"].map((x) => IndustryComparisonElement.fromJson(x))),

        consolidated: List<Consolidated>.from(json["company_esssentials"]
                ["consolidated"]
            .map((x) => Consolidated.fromJson(x))),

        standalone: List<Standalone>.from(json["company_esssentials"]
                ["standalone"]
            .map((x) => Standalone.fromJson(x))),

        // financialDataHighlights:
        //     FinancialDataHighlights.fromJson(json["financial_data_highlights"]),
        // financialRatios: FinancialRatios.fromJson(json["financial_ratios"]),
        // highsLows: HighsLows.fromJson(json["highs_lows"]),
        // keyMovingAverage: KeyMovingAverage.fromJson(json["key_moving_average"]),
        // keyProfitLossData:
        //     KeyProfitLossData.fromJson(json["key_profit_loss_data"]),
        // priceGainLoss: PriceGainLoss.fromJson(json["price_gain_loss"]),
        // priceRangeVolatility:
        //     PriceRangeVolatility.fromJson(json["price_range_volatility"]),
        // priceVolumeAction:
        //     PriceVolumeAction.fromJson(json["price_volume_action"]),
        // technicalIndicators:
        //     TechnicalIndicators.fromJson(json["technical_indicators"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "analysis": List<dynamic>.from(analysis.map((x) => x.toJson())),
  //       "financial_data_highlights": financialDataHighlights.toJson(),
  //       "financial_ratios": financialRatios.toJson(),
  //       "highs_lows": highsLows.toJson(),
  //       "key_moving_average": keyMovingAverage.toJson(),
  //       "key_profit_loss_data": keyProfitLossData.toJson(),
  //       "price_gain_loss": priceGainLoss.toJson(),
  //       "price_range_volatility": priceRangeVolatility.toJson(),
  //       "price_volume_action": priceVolumeAction.toJson(),
  //       "technical_indicators": technicalIndicators.toJson(),
  //     };
}

class Consolidated {
  String title;
  String value;

  Consolidated({this.title, this.value});

  factory Consolidated.fromJson(Map<String, dynamic> json) => Consolidated(
        title: json["title"],
        value: json["value"],
      );
  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
      };
}

class Standalone {
  String title;
  String value;

  Standalone({this.title, this.value});

  factory Standalone.fromJson(Map<String, dynamic> json) => Standalone(
        title: json["title"],
        value: json["value"],
      );
  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
      };
}

class IndustryComparisonElement {
  IndustryComparisonElement({
    this.status,
    this.text,
  });

  String status;
  String text;

  factory IndustryComparisonElement.fromJson(Map<String, dynamic> json) =>
      IndustryComparisonElement(
        status: json["status"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
      };
}

class FinancialDataHighlights {
  FinancialDataHighlights({
    this.bookValueShare,
    this.consensusTarget,
    this.enterpriseValue,
    this.grossProfitTtm,
    this.marketCap,
    this.revenueShareTtm,
    this.revenueTtm,
  });

  String bookValueShare;
  String consensusTarget;
  String enterpriseValue;
  String grossProfitTtm;
  String marketCap;
  String revenueShareTtm;
  String revenueTtm;

  factory FinancialDataHighlights.fromJson(Map<String, dynamic> json) =>
      FinancialDataHighlights(
        bookValueShare: json["book_value_share"],
        consensusTarget: json["consensus_target"],
        enterpriseValue: json["enterprise_value"],
        grossProfitTtm: json["gross_profit_ttm"],
        marketCap: json["market_cap"],
        revenueShareTtm: json["revenue_share_ttm"],
        revenueTtm: json["revenue_ttm"],
      );

  Map<String, dynamic> toJson() => {
        "book_value_share": bookValueShare,
        "consensus_target": consensusTarget,
        "enterprise_value": enterpriseValue,
        "gross_profit_ttm": grossProfitTtm,
        "market_cap": marketCap,
        "revenue_share_ttm": revenueShareTtm,
        "revenue_ttm": revenueTtm,
      };
}

class FinancialRatios {
  FinancialRatios({
    this.divShare,
    this.divYield,
    this.eps,
    this.forwardPe,
    this.pe,
    this.trailingPe,
  });

  String divShare;
  String divYield;
  String eps;
  String forwardPe;
  String pe;
  String trailingPe;

  factory FinancialRatios.fromJson(Map<String, dynamic> json) =>
      FinancialRatios(
        divShare: json["div_share"],
        divYield: json["div_yield"],
        eps: json["eps"],
        forwardPe: json["forward_pe"],
        pe: json["pe"],
        trailingPe: json["trailing_pe"],
      );

  Map<String, dynamic> toJson() => {
        "div_share": divShare,
        "div_yield": divYield,
        "eps": eps,
        "forward_pe": forwardPe,
        "pe": pe,
        "trailing_pe": trailingPe,
      };
}

class HighsLows {
  HighsLows({
    this.fiveYear,
    this.oneMonth,
    this.oneWeek,
    this.oneYear,
    this.sixMonths,
    this.tenYear,
    this.threeMonths,
    this.twoWeeks,
    this.twoYear,
  });

  HighsLowsFiveYear fiveYear;
  HighsLowsFiveYear oneMonth;
  HighsLowsFiveYear oneWeek;
  HighsLowsFiveYear oneYear;
  HighsLowsFiveYear sixMonths;
  HighsLowsFiveYear tenYear;
  HighsLowsFiveYear threeMonths;
  HighsLowsFiveYear twoWeeks;
  HighsLowsFiveYear twoYear;

  factory HighsLows.fromJson(Map<String, dynamic> json) => HighsLows(
        fiveYear: HighsLowsFiveYear.fromJson(json["five_year"] ?? null),
        oneMonth: HighsLowsFiveYear.fromJson(json["one_month"] ?? null),
        oneWeek: HighsLowsFiveYear.fromJson(json["one_week"] ?? null),
        oneYear: HighsLowsFiveYear.fromJson(json["one_year"] ?? null),
        sixMonths: HighsLowsFiveYear.fromJson(json["six_months"] ?? null),
        tenYear: HighsLowsFiveYear.fromJson(json["ten_year"] ?? null),
        threeMonths: HighsLowsFiveYear.fromJson(json["three_months"] ?? null),
        twoWeeks: HighsLowsFiveYear.fromJson(json["two_weeks"] ?? null),
        twoYear: HighsLowsFiveYear.fromJson(json["two_year"] ?? null),
      );

  Map<String, dynamic> toJson() => {
        "five_year": fiveYear.toJson(),
        "one_month": oneMonth.toJson(),
        "one_week": oneWeek.toJson(),
        "one_year": oneYear.toJson(),
        "six_months": sixMonths.toJson(),
        "ten_year": tenYear.toJson(),
        "three_months": threeMonths.toJson(),
        "two_weeks": twoWeeks.toJson(),
        "two_year": twoYear.toJson(),
      };
}

class HighsLowsFiveYear {
  HighsLowsFiveYear({
    this.high,
    this.low,
  });

  String high;
  String low;

  factory HighsLowsFiveYear.fromJson(Map<String, dynamic> json) =>
      HighsLowsFiveYear(
        high: json["high"],
        low: json["low"],
      );

  Map<String, dynamic> toJson() => {
        "high": high,
        "low": low,
      };
}

class KeyMovingAverage {
  KeyMovingAverage({
    this.the100Days,
    this.the10Days,
    this.the15Days,
    this.the200Days,
    this.the20Days,
    this.the50Days,
    this.the5Days,
  });

  Days the100Days;
  Days the10Days;
  Days the15Days;
  Days the200Days;
  Days the20Days;
  Days the50Days;
  Days the5Days;

  factory KeyMovingAverage.fromJson(Map<String, dynamic> json) =>
      KeyMovingAverage(
        the100Days: Days.fromJson(json["100_days"]),
        the10Days: Days.fromJson(json["10_days"]),
        the15Days: Days.fromJson(json["15_days"]),
        the200Days: Days.fromJson(json["200_days"]),
        the20Days: Days.fromJson(json["20_days"]),
        the50Days: Days.fromJson(json["50_days"]),
        the5Days: Days.fromJson(json["5_days"]),
      );

  Map<String, dynamic> toJson() => {
        "100_days": the100Days.toJson(),
        "10_days": the10Days.toJson(),
        "15_days": the15Days.toJson(),
        "200_days": the200Days.toJson(),
        "20_days": the20Days.toJson(),
        "50_days": the50Days.toJson(),
        "5_days": the5Days.toJson(),
      };
}

class Days {
  Days({
    this.ema,
    this.sma,
  });

  String ema;
  String sma;

  factory Days.fromJson(Map<String, dynamic> json) => Days(
        ema: json["ema"],
        sma: json["sma"],
      );

  Map<String, dynamic> toJson() => {
        "ema": ema,
        "sma": sma,
      };
}

class KeyProfitLossData {
  KeyProfitLossData({
    this.divPaid,
    this.grossProfit,
    this.netInc,
    this.opsExpense,
    this.opsIncome,
    this.pbt,
    this.period,
    this.revenue,
  });

  DivPaid divPaid;
  DivPaid grossProfit;
  DivPaid netInc;
  DivPaid opsExpense;
  DivPaid opsIncome;
  DivPaid pbt;
  String period;
  DivPaid revenue;

  factory KeyProfitLossData.fromJson(Map<String, dynamic> json) =>
      KeyProfitLossData(
        divPaid: DivPaid.fromJson(json["div_paid"]),
        grossProfit: DivPaid.fromJson(json["gross_profit"]),
        netInc: DivPaid.fromJson(json["net_inc"]),
        opsExpense: DivPaid.fromJson(json["ops_expense"]),
        opsIncome: DivPaid.fromJson(json["ops_income"]),
        pbt: DivPaid.fromJson(json["pbt"]),
        period: json["period"],
        revenue: DivPaid.fromJson(json["revenue"]),
      );

  Map<String, dynamic> toJson() => {
        "div_paid": divPaid.toJson(),
        "gross_profit": grossProfit.toJson(),
        "net_inc": netInc.toJson(),
        "ops_expense": opsExpense.toJson(),
        "ops_income": opsIncome.toJson(),
        "pbt": pbt.toJson(),
        "period": period,
        "revenue": revenue.toJson(),
      };
}

class DivPaid {
  DivPaid({
    this.amount,
    this.growth,
  });

  String amount;
  String growth;

  factory DivPaid.fromJson(Map<String, dynamic> json) => DivPaid(
        amount: json["amount"],
        growth: json["growth"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "growth": growth,
      };
}

class PriceGainLoss {
  PriceGainLoss({
    this.fiveYear,
    this.oneMonth,
    this.oneWeek,
    this.oneYear,
    this.sixMonths,
    this.tenYear,
    this.threeMonths,
    this.twoWeeks,
    this.twoYear,
  });

  PriceGainLossFiveYear fiveYear;
  PriceGainLossFiveYear oneMonth;
  PriceGainLossFiveYear oneWeek;
  PriceGainLossFiveYear oneYear;
  PriceGainLossFiveYear sixMonths;
  PriceGainLossFiveYear tenYear;
  PriceGainLossFiveYear threeMonths;
  PriceGainLossFiveYear twoWeeks;
  PriceGainLossFiveYear twoYear;

  factory PriceGainLoss.fromJson(Map<String, dynamic> json) => PriceGainLoss(
        fiveYear: PriceGainLossFiveYear.fromJson(json["five_year"]),
        oneMonth: PriceGainLossFiveYear.fromJson(json["one_month"]),
        oneWeek: PriceGainLossFiveYear.fromJson(json["one_week"]),
        oneYear: PriceGainLossFiveYear.fromJson(json["one_year"]),
        sixMonths: PriceGainLossFiveYear.fromJson(json["six_months"]),
        tenYear: PriceGainLossFiveYear.fromJson(json["ten_year"]),
        threeMonths: PriceGainLossFiveYear.fromJson(json["three_months"]),
        twoWeeks: PriceGainLossFiveYear.fromJson(json["two_weeks"]),
        twoYear: PriceGainLossFiveYear.fromJson(json["two_year"]),
      );

  Map<String, dynamic> toJson() => {
        "five_year": fiveYear.toJson(),
        "one_month": oneMonth.toJson(),
        "one_week": oneWeek.toJson(),
        "one_year": oneYear.toJson(),
        "six_months": sixMonths.toJson(),
        "ten_year": tenYear.toJson(),
        "three_months": threeMonths.toJson(),
        "two_weeks": twoWeeks.toJson(),
        "two_year": twoYear.toJson(),
      };
}

class PriceGainLossFiveYear {
  PriceGainLossFiveYear({
    this.absoluteChg,
    this.chgPercentage,
  });

  String absoluteChg;
  String chgPercentage;

  factory PriceGainLossFiveYear.fromJson(Map<String, dynamic> json) =>
      PriceGainLossFiveYear(
        absoluteChg: json["absolute_chg"],
        chgPercentage: json["chg_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "absolute_chg": absoluteChg,
        "chg_percentage": chgPercentage,
      };
}

class PriceRangeVolatility {
  PriceRangeVolatility({
    this.the10DayPeriod,
    this.the3MonthsPeriod,
    this.the5DayPeriod,
    this.the5WeekPeriod,
    this.lbdPr,
    this.monthPr,
    this.weekPr,
  });

  The10DayPeriod the10DayPeriod;
  The10DayPeriod the3MonthsPeriod;
  The10DayPeriod the5DayPeriod;
  The10DayPeriod the5WeekPeriod;
  The10DayPeriod lbdPr;
  The10DayPeriod monthPr;
  The10DayPeriod weekPr;

  factory PriceRangeVolatility.fromJson(Map<String, dynamic> json) =>
      PriceRangeVolatility(
        the10DayPeriod: The10DayPeriod.fromJson(json["10_day_period"]),
        the3MonthsPeriod: The10DayPeriod.fromJson(json["3_months_period"]),
        the5DayPeriod: The10DayPeriod.fromJson(json["5_day_period"]),
        the5WeekPeriod: The10DayPeriod.fromJson(json["5_week_period"]),
        lbdPr: The10DayPeriod.fromJson(json["lbd_pr"]),
        monthPr: The10DayPeriod.fromJson(json["month_pr"]),
        weekPr: The10DayPeriod.fromJson(json["week_pr"]),
      );

  Map<String, dynamic> toJson() => {
        "10_day_period": the10DayPeriod.toJson(),
        "3_months_period": the3MonthsPeriod.toJson(),
        "5_day_period": the5DayPeriod.toJson(),
        "5_week_period": the5WeekPeriod.toJson(),
        "lbd_pr": lbdPr.toJson(),
        "month_pr": monthPr.toJson(),
        "week_pr": weekPr.toJson(),
      };
}

class The10DayPeriod {
  The10DayPeriod({
    this.avgPr,
    this.rangePercentage,
  });

  String avgPr;
  String rangePercentage;

  factory The10DayPeriod.fromJson(Map<String, dynamic> json) => The10DayPeriod(
        avgPr: json["avg_pr"],
        rangePercentage: json["range_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "avg_pr": avgPr,
        "range_percentage": rangePercentage,
      };
}

class PriceVolumeAction {
  PriceVolumeAction({
    this.beta,
    this.code,
    this.eodSharePrice,
    this.fiveDayAvgVol,
    this.fnoStock,
    this.industry,
    this.lastBusinessDate,
    this.previousPrice,
    this.priceBook,
    this.priceChange,
    this.sector,
    this.volume,
  });

  String beta;
  String code;
  String eodSharePrice;
  String fiveDayAvgVol;
  String fnoStock;
  String industry;
  String lastBusinessDate;
  String previousPrice;
  String priceBook;
  String priceChange;
  String sector;
  String volume;

  factory PriceVolumeAction.fromJson(Map<String, dynamic> json) =>
      PriceVolumeAction(
        beta: json["beta"],
        code: json["code"],
        eodSharePrice: json["eod_share_price"],
        fiveDayAvgVol: json["five_day_avg_vol"],
        fnoStock: json["fno_stock"],
        industry: json["industry"],
        lastBusinessDate: json["last_business_date"],
        previousPrice: json["previous_price"],
        priceBook: json["price_book"],
        priceChange: json["price_change"],
        sector: json["sector"],
        volume: json["volume"],
      );

  Map<String, dynamic> toJson() => {
        "beta": beta,
        "code": code,
        "eod_share_price": eodSharePrice,
        "five_day_avg_vol": fiveDayAvgVol,
        "fno_stock": fnoStock,
        "industry": industry,
        "last_business_date": lastBusinessDate,
        "previous_price": previousPrice,
        "price_book": priceBook,
        "price_change": priceChange,
        "sector": sector,
        "volume": volume,
      };
}

class TechnicalIndicators {
  TechnicalIndicators({
    this.adx,
    this.awesomeOsc,
    this.chaikinMoneyFlow,
    this.macd,
    this.psar,
    this.rsi,
    this.rsiSmooth,
    this.superTrend,
    this.williamsPercentR,
  });

  String adx;
  String awesomeOsc;
  String chaikinMoneyFlow;
  String macd;
  String psar;
  String rsi;
  String rsiSmooth;
  String superTrend;
  String williamsPercentR;

  factory TechnicalIndicators.fromJson(Map<String, dynamic> json) =>
      TechnicalIndicators(
        adx: json["adx"],
        awesomeOsc: json["awesome_osc"],
        chaikinMoneyFlow: json["chaikin_money_flow"],
        macd: json["macd"],
        psar: json["psar"],
        rsi: json["rsi"],
        rsiSmooth: json["rsi_smooth"],
        superTrend: json["super_trend"],
        williamsPercentR: json["williams_percent_r"],
      );

  Map<String, dynamic> toJson() => {
        "adx": adx,
        "awesome_osc": awesomeOsc,
        "chaikin_money_flow": chaikinMoneyFlow,
        "macd": macd,
        "psar": psar,
        "rsi": rsi,
        "rsi_smooth": rsiSmooth,
        "super_trend": superTrend,
        "williams_percent_r": williamsPercentR,
      };
}

Quotes stockQuotesfromJson(String str) => Quotes.fromJson(json.decode(str));

String stockQuotesToJson(Quotes data) => json.encode(data.toJson());

class Quotes {
  Quotes({
    this.analysis,
    this.bse,
    this.nse,
    this.preopeningSession,
  });

  QuotesAnalysis analysis;
  Bse bse;
  Bse nse;
  PreopeningSession preopeningSession;

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        analysis:
            json != null ? QuotesAnalysis.fromJson(json["analysis"]) : null,
        bse: json != null ? Bse.fromJson(json["bse"]) : null,
        nse: json != null ? Bse.fromJson(json["nse"]) : null,
        preopeningSession: json != null
            ? PreopeningSession.fromJson(json["preopening_session"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "analysis": analysis.toJson(),
        "bse": bse.toJson(),
        "nse": nse.toJson(),
        "preopening_session": preopeningSession.toJson(),
      };
}

class QuotesAnalysis {
  QuotesAnalysis({
    this.actionInMcap,
    this.dayConsecutive,
    this.liquidity,
    this.movingAvg,
    this.performanceToday,
  });

  ActionInMcap actionInMcap;
  ActionInMcap dayConsecutive;
  ActionInMcap liquidity;
  ActionInMcap movingAvg;
  ActionInMcap performanceToday;

  factory QuotesAnalysis.fromJson(Map<String, dynamic> json) => QuotesAnalysis(
        actionInMcap: json["action_in_mcap"] != "-"
            ? ActionInMcap.fromJson(json["action_in_mcap"])
            : null,
        dayConsecutive: json["day_consecutive"] != "-"
            ? ActionInMcap.fromJson(json["day_consecutive"])
            : null,
        liquidity: json["liquidity"] != "-"
            ? ActionInMcap.fromJson(json["liquidity"])
            : null,
        movingAvg: json["moving_avg"] != "-"
            ? ActionInMcap.fromJson(json["moving_avg"])
            : null,
        performanceToday: json["performance_today"] != "-"
            ? ActionInMcap.fromJson(json["performance_today"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "action_in_mcap": actionInMcap.toJson(),
        "day_consecutive": dayConsecutive.toJson(),
        "liquidity": liquidity.toJson(),
        "moving_avg": movingAvg.toJson(),
        "performance_today": performanceToday.toJson(),
      };
}

class ActionInMcap {
  ActionInMcap({
    this.dir,
    this.header,
    this.msg,
  });

  String dir;
  String header;
  String msg;

  factory ActionInMcap.fromJson(Map<String, dynamic> json) => ActionInMcap(
        dir: json["dir"].toString(),
        header: json["header"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "dir": dir,
        "header": header,
        "msg": msg,
      };
}

class Bse {
  Bse({
    this.the20DAvgDelivery,
    this.the20DAvgVolume,
    this.beta,
    this.bvps,
    this.change,
    this.changePercent,
    this.daysRangeHigh,
    this.daysRangeLow,
    this.dividendYield,
    this.faceValue,
    this.lcLimit,
    this.marketCapture,
    this.open,
    this.pB,
    this.pC,
    this.previousClose,
    this.price,
    this.sectorPe,
    this.ttmEps,
    this.ttmPe,
    this.ucLimit,
    this.volume,
    this.vwap,
    this.weekRangeHigh,
    this.weekRangeLow,
  });

  String the20DAvgDelivery;
  String the20DAvgVolume;
  String beta;
  String bvps;
  String change;
  String changePercent;
  String daysRangeHigh;
  String daysRangeLow;
  String dividendYield;
  String faceValue;
  String lcLimit;
  String marketCapture;
  String open;
  String pB;
  String pC;
  String previousClose;
  String price;
  String sectorPe;
  String ttmEps;
  String ttmPe;
  String ucLimit;
  String volume;
  String vwap;
  String weekRangeHigh;
  String weekRangeLow;

  factory Bse.fromJson(Map<String, dynamic> json) => Bse(
        the20DAvgDelivery: json["20d_avg_delivery"],
        the20DAvgVolume: json["20d_avg_volume"],
        beta: json["beta"],
        bvps: json["bvps"],
        change: json["change"],
        changePercent: json["change_percent"],
        daysRangeHigh: json["days_range_high"],
        daysRangeLow: json["days_range_low"],
        dividendYield: json["dividend_yield"],
        faceValue: json["face_value"],
        lcLimit: json["lc_limit"],
        marketCapture: json["market_capture"],
        open: json["open"],
        pB: json["p_b"],
        pC: json["p_c"],
        previousClose: json["previous_close"],
        price: json["price"],
        sectorPe: json["sector_pe"],
        ttmEps: json["ttm_eps"],
        ttmPe: json["ttm_pe"],
        ucLimit: json["uc_limit"],
        volume: json["volume"],
        vwap: json["vwap"],
        weekRangeHigh: json["week_range_high"],
        weekRangeLow: json["week_range_low"],
      );

  Map<String, dynamic> toJson() => {
        "20d_avg_delivery": the20DAvgDelivery,
        "20d_avg_volume": the20DAvgVolume,
        "beta": beta,
        "bvps": bvps,
        "change": change,
        "change_percent": changePercent,
        "days_range_high": daysRangeHigh,
        "days_range_low": daysRangeLow,
        "dividend_yield": dividendYield,
        "face_value": faceValue,
        "lc_limit": lcLimit,
        "market_capture": marketCapture,
        "open": open,
        "p_b": pB,
        "p_c": pC,
        "previous_close": previousClose,
        "price": price,
        "sector_pe": sectorPe,
        "ttm_eps": ttmEps,
        "ttm_pe": ttmPe,
        "uc_limit": ucLimit,
        "volume": volume,
        "vwap": vwap,
        "week_range_high": weekRangeHigh,
        "week_range_low": weekRangeLow,
      };
}

class PreopeningSession {
  PreopeningSession({
    this.chg,
    this.chgPercent,
    this.previousClose,
    this.price,
  });

  String chg;
  String chgPercent;
  String previousClose;
  String price;

  factory PreopeningSession.fromJson(Map<String, dynamic> json) =>
      PreopeningSession(
        chg: json["chg"],
        chgPercent: json["chg_percent"],
        previousClose: json["previous_close"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "chg": chg,
        "chg_percent": chgPercent,
        "previous_close": previousClose,
        "price": price,
      };
}

class ReturnsClass {
  ReturnsClass({
    this.analysis,
    this.byClosestPeers,
    this.byIndustryPeers,
    this.byMcapPeers,
    this.stockVsSensex,
    this.totalReturns,
  });

  List<ReturnsAnalysis> analysis;
  ByPeers byClosestPeers;
  ByPeers byIndustryPeers;
  ByPeers byMcapPeers;
  List<StockVsSensex> stockVsSensex;
  List<TotalReturn> totalReturns;

  factory ReturnsClass.fromJson(Map<String, dynamic> json) => ReturnsClass(
        analysis: List<ReturnsAnalysis>.from(
            json["analysis"].map((x) => ReturnsAnalysis.fromJson(x))),
        byClosestPeers: ByPeers.fromJson(json["by_closest_peers"]),
        byIndustryPeers: ByPeers.fromJson(json["by_industry_peers"]),
        byMcapPeers: ByPeers.fromJson(json["by_mcap_peers"]),
        stockVsSensex: List<StockVsSensex>.from(
            json["stock_vs_sensex"].map((x) => StockVsSensex.fromJson(x))),
        totalReturns: List<TotalReturn>.from(
            json["total_returns"].map((x) => TotalReturn.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "analysis": List<dynamic>.from(analysis.map((x) => x.toJson())),
        "by_closest_peers": byClosestPeers.toJson(),
        "by_industry_peers": byIndustryPeers.toJson(),
        "by_mcap_peers": byMcapPeers.toJson(),
        "stock_vs_sensex":
            List<dynamic>.from(stockVsSensex.map((x) => x.toJson())),
        "total_returns":
            List<dynamic>.from(totalReturns.map((x) => x.toJson())),
      };
}

class ReturnsAnalysis {
  ReturnsAnalysis({
    this.prefix,
    this.suffix,
  });

  String prefix;
  String suffix;

  factory ReturnsAnalysis.fromJson(Map<String, dynamic> json) =>
      ReturnsAnalysis(
        prefix: json["prefix"],
        suffix: json["suffix"],
      );

  Map<String, dynamic> toJson() => {
        "prefix": prefix,
        "suffix": suffix,
      };
}

class ByPeers {
  ByPeers({
    this.rows,
    this.text,
  });

  List<Rows> rows;
  String text;

  factory ByPeers.fromJson(Map<String, dynamic> json) => ByPeers(
        rows: List<Rows>.from(json["rows"].map((x) => Rows.fromJson(x))),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
        "text": text,
      };
}

class Rows {
  Rows({
    this.quarter,
    this.returns,
    this.time,
  });

  String quarter;
  String returns;
  String time;

  factory Rows.fromJson(Map<String, dynamic> json) => Rows(
        quarter: json["quarter"].toString(),
        returns: json["returns"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "quarter": quarter,
        "returns": returns,
        "time": time,
      };
}

class StockVsSensex {
  StockVsSensex({
    this.duration,
    this.sensex,
    this.stock,
  });

  String duration;
  String sensex;
  String stock;

  factory StockVsSensex.fromJson(Map<String, dynamic> json) => StockVsSensex(
        duration: json["duration"],
        sensex: json["sensex"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "sensex": sensex,
        "stock": stock,
      };
}

class TotalReturn {
  TotalReturn({
    this.dividend,
    this.period,
    this.price,
    this.total,
  });

  String dividend;
  String period;
  String price;
  String total;

  factory TotalReturn.fromJson(Map<String, dynamic> json) => TotalReturn(
        dividend: json["dividend"],
        period: json["period"],
        price: json["price"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "dividend": dividend,
        "period": period,
        "price": price,
        "total": total,
      };
}

class Scrutiny {
  Scrutiny({
    this.financials,
    this.industryComparison,
    this.price,
    this.shareholdingPattern,
  });

  Financials financials;
  List<IndustryComparisonElement> industryComparison;
  List<IndustryComparisonElement> price;
  List<IndustryComparisonElement> shareholdingPattern;

  factory Scrutiny.fromJson(Map<String, dynamic> json) => Scrutiny(
        financials: Financials.fromJson(json["financials"]),
        industryComparison: List<IndustryComparisonElement>.from(
            json["industry_comparison"]
                .map((x) => IndustryComparisonElement.fromJson(x))),
        price: List<IndustryComparisonElement>.from(
            json["price"].map((x) => IndustryComparisonElement.fromJson(x))),
        shareholdingPattern: List<IndustryComparisonElement>.from(
            json["shareholding_pattern"]
                .map((x) => IndustryComparisonElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "financials": financials.toJson(),
        "industry_comparison":
            List<dynamic>.from(industryComparison.map((x) => x.toJson())),
        "price": List<dynamic>.from(price.map((x) => x.toJson())),
        "shareholding_pattern":
            List<dynamic>.from(shareholdingPattern.map((x) => x.toJson())),
      };
}

class Financials {
  Financials({
    this.cagrText,
    this.netProfit,
    this.operatingProfit,
    this.piotroskiScore,
    this.revenue,
    this.text,
  });

  String cagrText;
  String netProfit;
  String operatingProfit;
  String piotroskiScore;
  String revenue;
  String text;

  factory Financials.fromJson(Map<String, dynamic> json) => Financials(
        cagrText: json["cagr_text"],
        netProfit: json["net_profit"],
        operatingProfit: json["operating_profit"],
        piotroskiScore: json["piotroski_score"],
        revenue: json["revenue"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "cagr_text": cagrText,
        "net_profit": netProfit,
        "operating_profit": operatingProfit,
        "piotroski_score": piotroskiScore,
        "revenue": revenue,
        "text": text,
      };
}

class Shareholding {
  Shareholding({
    this.analysis,
    this.pieChart,
    this.tableData,
  });

  List<FinancialsIncomeStatementAnalysis> analysis;
  PieChart pieChart;
  ShareholdingTableData tableData;

  factory Shareholding.fromJson(Map<String, dynamic> json) => Shareholding(
        analysis: List<FinancialsIncomeStatementAnalysis>.from(json["analysis"]
            .map((x) => FinancialsIncomeStatementAnalysis.fromJson(x))),
        pieChart: PieChart.fromJson(json["pie_chart"]),
        tableData: ShareholdingTableData.fromJson(json["table_data"]),
      );

  Map<String, dynamic> toJson() => {
        "analysis": List<dynamic>.from(analysis.map((x) => x.toJson())),
        "pie_chart": pieChart.toJson(),
        "table_data": tableData.toJson(),
      };
}

class PieChart {
  PieChart({
    this.fiis,
    this.insurance,
    this.mutualFunds,
    this.nonInstitution,
    this.other,
    this.otherDiis,
    this.promoters,
  });

  String fiis;
  String insurance;
  String mutualFunds;
  String nonInstitution;
  String other;
  String otherDiis;
  String promoters;

  factory PieChart.fromJson(Map<String, dynamic> json) => PieChart(
        fiis: json["fiis"],
        insurance: json["insurance"],
        mutualFunds: json["mutual_funds"],
        nonInstitution: json["non_institution"],
        other: json["other"],
        otherDiis: json["other_diis"],
        promoters: json["promoters"],
      );

  Map<String, dynamic> toJson() => {
        "fiis": fiis,
        "insurance": insurance,
        "mutual_funds": mutualFunds,
        "non_institution": nonInstitution,
        "other": other,
        "other_diis": otherDiis,
        "promoters": promoters,
      };
}

class ShareholdingTableData {
  ShareholdingTableData({
    this.dii,
    this.fii,
    this.others,
    this.promoter,
    this.public,
  });

  List<Dii> dii;
  List<Dii> fii;
  List<Dii> others;
  List<Dii> promoter;
  List<Dii> public;

  factory ShareholdingTableData.fromJson(Map<String, dynamic> json) =>
      ShareholdingTableData(
        dii: List<Dii>.from(json["dii"].map((x) => Dii.fromJson(x))),
        fii: List<Dii>.from(json["fii"].map((x) => Dii.fromJson(x))),
        others: List<Dii>.from(json["others"].map((x) => Dii.fromJson(x))),
        promoter: List<Dii>.from(json["promoter"].map((x) => Dii.fromJson(x))),
        public: List<Dii>.from(json["public"].map((x) => Dii.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dii": List<dynamic>.from(dii.map((x) => x.toJson())),
        "fii": List<dynamic>.from(fii.map((x) => x.toJson())),
        "others": List<dynamic>.from(others.map((x) => x.toJson())),
        "promoter": List<dynamic>.from(promoter.map((x) => x.toJson())),
        "public": List<dynamic>.from(public.map((x) => x.toJson())),
      };
}

class Dii {
  Dii({
    this.quarter,
    this.value,
  });

  String quarter;
  String value;

  factory Dii.fromJson(Map<String, dynamic> json) => Dii(
        quarter: json["quarter"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "quarter": quarter,
        "value": value,
      };
}

class Swot {
  Swot({
    this.opportunities,
    this.strengths,
    this.threats,
    this.weaknesses,
  });

  List<String> opportunities;
  List<String> strengths;
  List<String> threats;
  List<String> weaknesses;

  factory Swot.fromJson(Map<String, dynamic> json) => Swot(
        opportunities: List<String>.from(json["opportunities"].map((x) => x)),
        strengths: List<String>.from(json["strengths"].map((x) => x)),
        threats: List<String>.from(json["threats"].map((x) => x)),
        weaknesses: List<String>.from(json["weaknesses"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "opportunities": List<dynamic>.from(opportunities.map((x) => x)),
        "strengths": List<dynamic>.from(strengths.map((x) => x)),
        "threats": List<dynamic>.from(threats.map((x) => x)),
        "weaknesses": List<dynamic>.from(weaknesses.map((x) => x)),
      };
}

CommodityOverviewModelTechnicalIndicator stockTechnicalFromJson(String str) =>
    CommodityOverviewModelTechnicalIndicator.fromJson(json.decode(str));

String stockTechnicalToJson(CommodityOverviewModelTechnicalIndicator data) =>
    json.encode(data.toJson());

class Technical {
  Technical({
    this.the15Min,
    this.the1Hour,
    this.the1Min,
    this.the30Min,
    this.the5Hour,
    this.the5Min,
    this.daily,
    this.monthly,
    this.weekly,
  });

  The15Min the15Min;
  The15Min the1Hour;
  The15Min the1Min;
  The15Min the30Min;
  The15Min the5Hour;
  The15Min the5Min;
  The15Min daily;
  The15Min monthly;
  The15Min weekly;

  factory Technical.fromJson(Map<String, dynamic> json) => Technical(
        the15Min: json != null ? The15Min.fromJson(json["15min"]) : null,
        the1Hour: json != null ? The15Min.fromJson(json["1hour"]) : null,
        the1Min: json != null ? The15Min.fromJson(json["1min"]) : null,
        the30Min: json != null ? The15Min.fromJson(json["30min"]) : null,
        the5Hour: json != null ? The15Min.fromJson(json["5hour"]) : null,
        the5Min: json != null ? The15Min.fromJson(json["5min"]) : null,
        daily: json != null ? The15Min.fromJson(json["daily"]) : null,
        monthly: json != null ? The15Min.fromJson(json["monthly"]) : null,
        weekly: json != null ? The15Min.fromJson(json["weekly"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "15min": the15Min.toJson(),
        "1hour": the1Hour.toJson(),
        "1min": the1Min.toJson(),
        "30min": the30Min.toJson(),
        "5hour": the5Hour.toJson(),
        "5min": the5Min.toJson(),
        "daily": daily.toJson(),
        "monthly": monthly.toJson(),
        "weekly": weekly.toJson(),
      };
}

class The15Min {
  The15Min({
    this.movingAverages,
    this.pivotPoints,
    this.summary,
    this.technicalIndicator,
  });

  MovingAverages movingAverages;
  PivotPoints pivotPoints;
  The15MinSummary summary;
  TechnicalIndicator technicalIndicator;

  factory The15Min.fromJson(Map<String, dynamic> json) => The15Min(
        movingAverages: MovingAverages.fromJson(json["moving_averages"]),
        pivotPoints: PivotPoints.fromJson(json["pivot_points"]),
        summary: The15MinSummary.fromJson(json["summary"]),
        technicalIndicator:
            TechnicalIndicator.fromJson(json["technical_indicator"]),
      );

  Map<String, dynamic> toJson() => {
        "moving_averages": movingAverages.toJson(),
        "pivot_points": pivotPoints.toJson(),
        "summary": summary.toJson(),
        "technical_indicator": technicalIndicator.toJson(),
      };
}

class MovingAverages {
  MovingAverages({
    this.buy,
    this.sell,
    this.tableData,
    this.text,
  });

  String buy;
  String sell;
  MovingAveragesTableData tableData;
  String text;

  factory MovingAverages.fromJson(Map<String, dynamic> json) => MovingAverages(
        buy: json["buy"],
        sell: json["sell"],
        tableData: MovingAveragesTableData.fromJson(json["table_data"]),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "buy": buy,
        "sell": sell,
        "table_data": tableData.toJson(),
        "text": text,
      };
}

class MovingAveragesTableData {
  MovingAveragesTableData({
    this.exponential,
    this.simple,
  });

  List<Exponential> exponential;
  List<Exponential> simple;

  factory MovingAveragesTableData.fromJson(Map<String, dynamic> json) =>
      MovingAveragesTableData(
        exponential: List<Exponential>.from(
            json["exponential"].map((x) => Exponential.fromJson(x))),
        simple: List<Exponential>.from(
            json["simple"].map((x) => Exponential.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exponential": List<dynamic>.from(exponential.map((x) => x.toJson())),
        "simple": List<dynamic>.from(simple.map((x) => x.toJson())),
      };
}

class Exponential {
  Exponential({
    this.title,
    this.type,
    this.value,
  });

  String title;
  String type;
  String value;

  factory Exponential.fromJson(Map<String, dynamic> json) => Exponential(
        title: json["title"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "type": type,
        "value": value,
      };
}

class PivotPoints {
  PivotPoints({
    this.camarilla,
    this.classic,
    this.demark,
    this.fibonacci,
    this.woodie,
  });

  Camarilla camarilla;
  Camarilla classic;
  Camarilla demark;
  Camarilla fibonacci;
  Camarilla woodie;

  factory PivotPoints.fromJson(Map<String, dynamic> json) => PivotPoints(
        camarilla: Camarilla.fromJson(json["camarilla"]),
        classic: Camarilla.fromJson(json["classic"]),
        demark: Camarilla.fromJson(json["demark"]),
        fibonacci: Camarilla.fromJson(json["fibonacci"]),
        woodie: Camarilla.fromJson(json["woodie"]),
      );

  Map<String, dynamic> toJson() => {
        "camarilla": camarilla.toJson(),
        "classic": classic.toJson(),
        "demark": demark.toJson(),
        "fibonacci": fibonacci.toJson(),
        "woodie": woodie.toJson(),
      };
}

class Camarilla {
  Camarilla({
    this.pivotPoints,
    this.r1,
    this.r2,
    this.r3,
    this.s1,
    this.s2,
    this.s3,
  });

  String pivotPoints;
  String r1;
  String r2;
  String r3;
  String s1;
  String s2;
  String s3;

  factory Camarilla.fromJson(Map<String, dynamic> json) => Camarilla(
        pivotPoints: json["pivot_points"],
        r1: json["r1"],
        r2: json["r2"],
        r3: json["r3"],
        s1: json["s1"],
        s2: json["s2"],
        s3: json["s3"],
      );

  Map<String, dynamic> toJson() => {
        "pivot_points": pivotPoints,
        "r1": r1,
        "r2": r2,
        "r3": r3,
        "s1": s1,
        "s2": s2,
        "s3": s3,
      };
}

class The15MinSummary {
  The15MinSummary({
    this.summaryText,
  });

  String summaryText;

  factory The15MinSummary.fromJson(Map<String, dynamic> json) =>
      The15MinSummary(
        summaryText: json["summary_text"],
      );

  Map<String, dynamic> toJson() => {
        "summary_text": summaryText,
      };
}

class TechnicalIndicator {
  TechnicalIndicator({
    this.buy,
    this.neutral,
    this.sell,
    this.tableData,
    this.text,
  });

  String buy;
  String neutral;
  String sell;
  List<TechnicalIndicatorTableDatum> tableData;
  String text;

  factory TechnicalIndicator.fromJson(Map<String, dynamic> json) =>
      TechnicalIndicator(
        buy: json["buy"],
        neutral: json["neutral"],
        sell: json["sell"],
        tableData: List<TechnicalIndicatorTableDatum>.from(json["table_data"]
            .map((x) => TechnicalIndicatorTableDatum.fromJson(x))),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "buy": buy,
        "neutral": neutral,
        "sell": sell,
        "table_data": List<dynamic>.from(tableData.map((x) => x.toJson())),
        "text": text,
      };
}

class TechnicalIndicatorTableDatum {
  TechnicalIndicatorTableDatum({
    this.action,
    this.name,
    this.value,
  });

  String action;
  String name;
  String value;

  factory TechnicalIndicatorTableDatum.fromJson(Map<String, dynamic> json) =>
      TechnicalIndicatorTableDatum(
        action: json["action"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "name": name,
        "value": value,
      };
}

class TopSummaryFinancials {
  TopSummaryFinancials({
    this.notWorking,
    this.working,
  });

  List<String> notWorking;
  List<String> working;

  factory TopSummaryFinancials.fromJson(Map<String, dynamic> json) =>
      TopSummaryFinancials(
        notWorking: List<String>.from(json["not_working"].map((x) => x)),
        working: List<String>.from(json["working"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "not_working": List<dynamic>.from(notWorking.map((x) => x)),
        "working": List<dynamic>.from(working.map((x) => x)),
      };
}

class Valuation {
  Valuation({
    this.dividendYield,
    this.evToCapitalEmployed,
    this.evToEbit,
    this.evToEbitda,
    this.evToSales,
    this.peRatio,
    this.pegRatio,
    this.priceToBookValue,
    this.roceLatest,
    this.roeLatest,
    this.valuationGradeMeter,
  });

  String dividendYield;
  String evToCapitalEmployed;
  String evToEbit;
  String evToEbitda;
  String evToSales;
  String peRatio;
  String pegRatio;
  String priceToBookValue;
  String roceLatest;
  String roeLatest;
  String valuationGradeMeter;

  factory Valuation.fromJson(Map<String, dynamic> json) => Valuation(
        dividendYield: json["dividend_yield"],
        evToCapitalEmployed: json["ev_to_capital_employed"],
        evToEbit: json["ev_to_ebit"],
        evToEbitda: json["ev_to_ebitda"],
        evToSales: json["ev_to_sales"],
        peRatio: json["pe_ratio"],
        pegRatio: json["peg_ratio"],
        priceToBookValue: json["price_to_book_value"],
        roceLatest: json["roce_latest"],
        roeLatest: json["roe_latest"],
        valuationGradeMeter: json["valuation_grade_meter"],
      );

  Map<String, dynamic> toJson() => {
        "dividend_yield": dividendYield,
        "ev_to_capital_employed": evToCapitalEmployed,
        "ev_to_ebit": evToEbit,
        "ev_to_ebitda": evToEbitda,
        "ev_to_sales": evToSales,
        "pe_ratio": peRatio,
        "peg_ratio": pegRatio,
        "price_to_book_value": priceToBookValue,
        "roce_latest": roceLatest,
        "roe_latest": roeLatest,
        "valuation_grade_meter": valuationGradeMeter,
      };
}

class Volatility {
  Volatility({
    this.averagePriceRange,
    this.betaValues,
    this.sharePriceRange,
  });

  List<AveragePriceRange> averagePriceRange;
  List<BetaValues> betaValues;
  List<SharePriceRange> sharePriceRange;

  factory Volatility.fromJson(Map<String, dynamic> json) => Volatility(
        averagePriceRange: json != null
            ? List<AveragePriceRange>.from(json["average_price_range"]
                .map((x) => AveragePriceRange.fromJson(x)))
            : [],
        betaValues: json != null
            ? List<BetaValues>.from(
                json["beta_values"].map((x) => BetaValues.fromJson(x)))
            : [],
        sharePriceRange: json != null
            ? List<SharePriceRange>.from(json["share_price_range"]
                .map((x) => SharePriceRange.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "average_price_range":
            List<dynamic>.from(averagePriceRange.map((x) => x.toJson())),
        "beta_values": List<dynamic>.from(betaValues.map((x) => x.toJson())),
        "share_price_range":
            List<dynamic>.from(sharePriceRange.map((x) => x.toJson())),
      };
}

class BetaValues {
  BetaValues(
      {this.dailyOneMonthRange,
      this.dailyThreeMonthRange,
      this.longTermBeta,
      this.monthlyOneYearRange,
      this.monthlyTwoYearRange,
      this.period,
      this.weeklyOneYearRange,
      this.weeklyTwoYearRange});

  String dailyOneMonthRange;
  String dailyThreeMonthRange;
  String longTermBeta;
  String monthlyTwoYearRange;
  String monthlyOneYearRange;
  String period;
  String weeklyOneYearRange;
  String weeklyTwoYearRange;

  factory BetaValues.fromJson(Map<String, dynamic> json) => BetaValues(
      dailyOneMonthRange: json["daily_one_month_range"],
      dailyThreeMonthRange: json["daily_three_month_range"],
      longTermBeta: json["long_term_beta"],
      monthlyOneYearRange: json["monthly_one_year_range"],
      monthlyTwoYearRange: json["monthly_two_year_range"],
      period: json["period"],
      weeklyOneYearRange: json["weekly_one_year_range"],
      weeklyTwoYearRange: json["weekly_two_year_range"]);

  Map<String, dynamic> toJson() => {
        "daily_one_month_range": dailyOneMonthRange,
        "daily_three_month_range": dailyThreeMonthRange,
        "long_term_beta": longTermBeta,
        "monthly_one_year_range": monthlyOneYearRange,
        "monthly_two_year_range": monthlyTwoYearRange,
        "period": period,
        "weekly_one_year_range": weeklyOneYearRange,
        "weekly_two_year_range": weeklyTwoYearRange
      };
}

class AveragePriceRange {
  AveragePriceRange({
    this.averagePriceRange,
    this.period,
    this.priceRangePercentage,
  });

  String averagePriceRange;
  String period;
  String priceRangePercentage;

  factory AveragePriceRange.fromJson(Map<String, dynamic> json) =>
      AveragePriceRange(
        averagePriceRange: json["average_price_range"],
        period: json["period"],
        priceRangePercentage: json["price_range_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "average_price_range": averagePriceRange,
        "period": period,
        "price_range_percentage": priceRangePercentage,
      };
}

class SharePriceRange {
  SharePriceRange({
    this.close,
    this.date,
    this.high,
    this.low,
    this.priceRange,
    this.priceRangePercentage,
  });

  String close;
  String date;
  String high;
  String low;
  String priceRange;
  String priceRangePercentage;

  factory SharePriceRange.fromJson(Map<String, dynamic> json) =>
      SharePriceRange(
        close: json["close"],
        date: json["date"],
        high: json["high"],
        low: json["low"],
        priceRange: json["price_range"],
        priceRangePercentage: json["price_range_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "close": close,
        "date": date,
        "high": high,
        "low": low,
        "price_range": priceRange,
        "price_range_percentage": priceRangePercentage,
      };
}



class Stock2 {
  Stock2({
    this.backendParameter,
    this.chg,
    this.chgPer,
    this.high,
    this.low,
    this.name,
    this.price,
    this.volume,
  });
  String backendParameter;
  String chg;
  String chgPer;
  String high;
  String low;
  String name;
  String price;
  String volume;
  factory Stock2.fromJson(Map<String, dynamic> json) => Stock2(
    backendParameter : json["backend_parameter"],
    chg : json["chg"],
    chgPer : json["chg_per"],
    high : json["high"],
    low : json["low"],
    name : json["name"],
    price : json["price"],
    volume : json["volume"],
  );
}


class StockModel2 {
  List<StockData2> bse;
  List<StockData2> nse;

  StockModel2({this.bse, this.nse});

  StockModel2.fromJson(Map<String, dynamic> json) {
    if (json['bse'] != null) {
      bse = [];
      json['bse'].forEach((v) {
        bse.add(new StockData2.fromJson(v));
      });
    }
    if (json['nse'] != null) {
      nse = [];
      json['nse'].forEach((v) {
        nse.add(new StockData2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bse != null) {
      data['bse'] = this.bse.map((v) => v.toJson()).toList();
    }
    if (this.nse != null) {
      data['nse'] = this.nse.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockData2 {
  String backendParameter;
  String chg;
  String chgPer;
  String high;
  String low;
  String name;
  String price;
  String volume;

  StockData2(
      {this.backendParameter,
      this.chg,
      this.chgPer,
      this.high,
      this.low,
      this.name,
      this.price,
      this.volume});

  StockData2.fromJson(Map<String, dynamic> json) {
    backendParameter = json['backend_parameter'];
    chg = json['chg'];
    chgPer = json['chg_per'];
    high = json['high'];
    low = json['low'];
    name = json['name'];
    price = json['price'];
    volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backend_parameter'] = this.backendParameter;
    data['chg'] = this.chg;
    data['chg_per'] = this.chgPer;
    data['high'] = this.high;
    data['low'] = this.low;
    data['name'] = this.name;
    data['price'] = this.price;
    data['volume'] = this.volume;
    return data;
  }
}