// To parse this JSON data, do
//
//     final ipoIndividualModel = ipoIndividualModelFromJson(jsonString);

import 'dart:convert';

IpoIndividualModel ipoIndividualModelFromJson(String str) =>
    IpoIndividualModel.fromJson(json.decode(str));

String ipoIndividualModelToJson(IpoIndividualModel data) =>
    json.encode(data.toJson());

class IpoIndividualModel {
  IpoIndividualModel({
    this.analysis,
    this.contactInfo,
    this.importantDates,
    this.ipoAllotmentStatus,
    this.ipoDetails,
    this.managementTeam,
    this.message,
    this.registrarInfo,
    this.summary,
  });

  Analysis analysis;
  ContactInfoClass contactInfo;
  ImportantDates importantDates;
  IpoAllotmentStatus ipoAllotmentStatus;
  IpoDetails ipoDetails;
  List<ManagementTeam> managementTeam;
  String message;
  ContactInfoClass registrarInfo;
  Summary summary;

  factory IpoIndividualModel.fromJson(Map<String, dynamic> json) =>
      IpoIndividualModel(
        analysis: Analysis.fromJson(json["analysis"]),
        contactInfo: ContactInfoClass.fromJson(json["contact_info"]),
        importantDates: ImportantDates.fromJson(json["important_dates"]),
        ipoAllotmentStatus:
            IpoAllotmentStatus.fromJson(json["ipo_allotment_status"]),
        ipoDetails: IpoDetails.fromJson(json["ipo_details"]),
        managementTeam: List<ManagementTeam>.from(
            json["management_team"].map((x) => ManagementTeam.fromJson(x))),
        message: json["message"],
        registrarInfo: ContactInfoClass.fromJson(json["registrar_info"]),
        summary: Summary.fromJson(json["summary"]),
      );

  Map<String, dynamic> toJson() => {
        "analysis": analysis.toJson(),
        "contact_info": contactInfo.toJson(),
        "important_dates": importantDates.toJson(),
        "ipo_allotment_status": ipoAllotmentStatus.toJson(),
        "ipo_details": ipoDetails.toJson(),
        "management_team":
            List<dynamic>.from(managementTeam.map((x) => x.toJson())),
        "message": message,
        "registrar_info": registrarInfo.toJson(),
        "summary": summary.toJson(),
      };
}

class Analysis {
  Analysis({
    this.profitInfo,
    this.revenueInfo,
  });

  ProfitInfoClass profitInfo;
  ProfitInfoClass revenueInfo;

  factory Analysis.fromJson(Map<String, dynamic> json) => Analysis(
        profitInfo: ProfitInfoClass.fromJson(json["profit_info"]),
        revenueInfo: ProfitInfoClass.fromJson(json["revenue_info"]),
      );

  Map<String, dynamic> toJson() => {
        "profit_info": profitInfo.toJson(),
        "revenue_info": revenueInfo.toJson(),
      };
}

class ProfitInfoClass {
  ProfitInfoClass({
    this.fy17,
    this.fy18,
    this.fy19,
    this.fy20,
  });

  String fy17;
  String fy18;
  String fy19;
  String fy20;

  factory ProfitInfoClass.fromJson(Map<String, dynamic> json) =>
      ProfitInfoClass(
        fy17: json["fy_17"],
        fy18: json["fy_18"],
        fy19: json["fy_19"],
        fy20: json["fy_20"],
      );

  Map<String, dynamic> toJson() => {
        "fy_17": fy17,
        "fy_18": fy18,
        "fy_19": fy19,
        "fy_20": fy20,
      };
}

class ContactInfoClass {
  ContactInfoClass({
    this.address,
    this.email,
    this.fax,
    this.telephoneNumber,
    this.website,
  });

  String address;
  String email;
  String fax;
  String telephoneNumber;
  String website;

  factory ContactInfoClass.fromJson(Map<String, dynamic> json) =>
      ContactInfoClass(
        address: json["address"],
        email: json["email"],
        fax: json["fax"],
        telephoneNumber: json["telephone_number"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "email": email,
        "fax": fax,
        "telephone_number": telephoneNumber,
        "website": website,
      };
}

class ImportantDates {
  ImportantDates({
    this.creditOfEquityShares,
    this.finalizationOfBasisOfAllotment,
    this.initiationOfRefunds,
    this.listingDate,
  });

  String creditOfEquityShares;
  String finalizationOfBasisOfAllotment;
  String initiationOfRefunds;
  String listingDate;

  factory ImportantDates.fromJson(Map<String, dynamic> json) => ImportantDates(
        creditOfEquityShares: json["credit_of_equity_shares"],
        finalizationOfBasisOfAllotment:
            json["finalization_of_basis_of_allotment"],
        initiationOfRefunds: json["initiation_of_refunds"],
        listingDate: json["listing_date"],
      );

  Map<String, dynamic> toJson() => {
        "credit_of_equity_shares": creditOfEquityShares,
        "finalization_of_basis_of_allotment": finalizationOfBasisOfAllotment,
        "initiation_of_refunds": initiationOfRefunds,
        "listing_date": listingDate,
      };
}

class IpoAllotmentStatus {
  IpoAllotmentStatus({
    this.bseIpoWebsite,
    this.linkInTimeWebsite,
  });

  String bseIpoWebsite;
  String linkInTimeWebsite;

  factory IpoAllotmentStatus.fromJson(Map<String, dynamic> json) =>
      IpoAllotmentStatus(
        bseIpoWebsite: json["bse_ipo_website"],
        linkInTimeWebsite: json["link_in_time_website"],
      );

  Map<String, dynamic> toJson() => {
        "bse_ipo_website": bseIpoWebsite,
        "link_in_time_website": linkInTimeWebsite,
      };
}

class IpoDetails {
  IpoDetails({
    this.equitySharesAfterTheIssue,
    this.equitySharesOfferedOfs,
    this.equitySharesPriorToTheIssue,
    this.faceValue,
    this.issueClosesOn,
    this.issueConstitutes,
    this.issuePrice,
    this.issueSize,
    this.issuesOpensOn,
    this.listingAt,
    this.marketCap,
    this.minimumInvestment,
    this.minimumLot,
    this.retailCategoryAllocation,
  });

  String equitySharesAfterTheIssue;
  String equitySharesOfferedOfs;
  String equitySharesPriorToTheIssue;
  String faceValue;
  String issueClosesOn;
  String issueConstitutes;
  String issuePrice;
  String issueSize;
  String issuesOpensOn;
  String listingAt;
  String marketCap;
  String minimumInvestment;
  String minimumLot;
  String retailCategoryAllocation;

  factory IpoDetails.fromJson(Map<String, dynamic> json) => IpoDetails(
        equitySharesAfterTheIssue: json["equity_shares_after_the_issue"],
        equitySharesOfferedOfs: json["equity_shares_offered_ofs"],
        equitySharesPriorToTheIssue: json["equity_shares_prior_to_the_issue"],
        faceValue: json["face_value"],
        issueClosesOn: json["issue_closes_on"],
        issueConstitutes: json["issue_constitutes"],
        issuePrice: json["issue_price"],
        issueSize: json["issue_size"],
        issuesOpensOn: json["issues_opens_on"],
        listingAt: json["listing_at"],
        marketCap: json["market_cap"],
        minimumInvestment: json["minimum_investment"],
        minimumLot: json["minimum_lot"],
        retailCategoryAllocation: json["retail_category_allocation"],
      );

  Map<String, dynamic> toJson() => {
        "equity_shares_after_the_issue": equitySharesAfterTheIssue,
        "equity_shares_offered_ofs": equitySharesOfferedOfs,
        "equity_shares_prior_to_the_issue": equitySharesPriorToTheIssue,
        "face_value": faceValue,
        "issue_closes_on": issueClosesOn,
        "issue_constitutes": issueConstitutes,
        "issue_price": issuePrice,
        "issue_size": issueSize,
        "issues_opens_on": issuesOpensOn,
        "listing_at": listingAt,
        "market_cap": marketCap,
        "minimum_investment": minimumInvestment,
        "minimum_lot": minimumLot,
        "retail_category_allocation": retailCategoryAllocation,
      };
}

class ManagementTeam {
  ManagementTeam({
    this.designation,
    this.name,
  });

  String designation;
  String name;

  factory ManagementTeam.fromJson(Map<String, dynamic> json) => ManagementTeam(
        designation: json["designation"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "designation": designation,
        "name": name,
      };
}

class Summary {
  Summary({
    this.employee,
    this.nii,
    this.qib,
    this.retail,
    this.total,
  });

  Employee employee;
  Employee nii;
  Employee qib;
  Employee retail;
  Employee total;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        employee: Employee.fromJson(json["Employee"]),
        nii: Employee.fromJson(json["NII"]),
        qib: Employee.fromJson(json["QIB"]),
        retail: Employee.fromJson(json["Retail"]),
        total: Employee.fromJson(json["TOTAL"]),
      );

  Map<String, dynamic> toJson() => {
        "Employee": employee.toJson(),
        "NII": nii.toJson(),
        "QIB": qib.toJson(),
        "Retail": retail.toJson(),
        "TOTAL": total.toJson(),
      };
}

class Employee {
  Employee({
    this.day1,
    this.day2,
    this.day3,
    this.shares,
  });

  String day1;
  String day2;
  String day3;
  String shares;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        day1: json["day_1"],
        day2: json["day_2"],
        day3: json["day_3"],
        shares: json["shares"],
      );

  Map<String, dynamic> toJson() => {
        "day_1": day1,
        "day_2": day2,
        "day_3": day3,
        "shares": shares,
      };
}
