import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReferAccount {
  String name;
  String email;
  String phone;
  String accountNumber;
  String ifsc;

  ReferAccount(
      {this.name, this.email, this.phone, this.accountNumber, this.ifsc});

  ReferAccount.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    accountNumber = json['accountNumber'];
    ifsc = json['ifsc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['accountNumber'] = this.accountNumber;
    data['ifsc'] = this.ifsc;
    return data;
  }
}
