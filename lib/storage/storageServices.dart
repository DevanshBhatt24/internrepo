import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_calc/date_calc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_ind/refferal/referModel.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/mutual/business/mutualfunds.dart';
import 'package:http/http.dart' as http;
import 'package:technical_ind/storage/referalSharedPref.dart';
import '../styles.dart';

class StorageService extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  User user;
  Map<String, dynamic> fireStoreUser;

  StorageService(this.user) {
    getUserdata(user);
  }

  Map<String, dynamic> get currentFireStoreUser => fireStoreUser;

  Future<Map<String, dynamic>> get currentUserData => getUserdata(user);

  Stream<DocumentSnapshot> get fireStoreUserChanges =>
      db.collection('Users').doc(user.uid).snapshots();

  Future<bool> checkUserExists(User user) async {
    bool exists = false;
    try {
      var doc = await db.doc("Users/${user.uid}").get();
      return doc.exists;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> createNewUser() async {
    DateTime dateTime = DateTime.now();
    // DateTime onlyDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    // DateTime threeDays = onlyDate.add(Duration(days: 3));
    // ReferralSharedPreference.setAlreadyAdded(false);
    // ReferralSharedPreference.setBool(false);
    // ReferralSharedPreference.setDate(threeDays);
    var d = DateCalc(dateTime.year, dateTime.month, dateTime.day);
    DateTime trial = d.addDay(30);
    String refferalID = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('refferalID')) {
      refferalID = prefs.getString('refferalID');
      await incrementTotalRefferal(refferalID);
    }
    Object object = {
      "signUpDate": dateTime.toIso8601String(),
      "EndDate": trial.toIso8601String(),
      "trialEnded": false,
      "status": "onSub", //onTrial,endTrial,onSub,endSub
      "payments": [],
      "ReferEnroll": false,
      "refferedBy": refferalID == "" ? "direct" : refferalID
    };
    if (!await checkUserExists(user)) await createUser(object);
    notifyListeners();
  }

  Future<void> createUser(
    Map<String, dynamic> object,
  ) async {
    CollectionReference userRef = db.collection('Users');
    await userRef.doc(user.uid).set(object);
    notifyListeners();
  }

  Future<void> getUserdata(User u) async {
    user = u;
    CollectionReference userRef = db.collection('Users');
    var snap = await userRef.doc(user.uid).get();
    fireStoreUser = snap.data();
    notifyListeners();
  }

  Future<void> updateUser(
    Map<String, dynamic> object,
  ) async {
    CollectionReference userRef = db.collection('Users');

    await userRef.doc(user.uid).update(object);
    await getUserdata(user);
    notifyListeners();
  }

  Future<void> updateTrending(Map<String, dynamic> object, String type) async {
    CollectionReference userRef = db.collection('global');

    await userRef.doc(type).update(object);
    await getUserdata(user);
    notifyListeners();
  }

  Future<void> createRefferalAccount(
      ReferAccount referAccount, String refferalLink) async {
    Object account = {
      "ReferEnroll": true,
      "refferalAccount": referAccount.toJson(),
      "dynamicLink": refferalLink,
      "totalRefferal": 0,
      "totalCommision": 0.0,
      "referPayments": []
    };
    await updateUser(account);
  }

  Future<void> updateUpi(String accountNumber, String ifsc) async {
    ReferAccount refAcc = await getRefferAccount(user.uid);
    refAcc.accountNumber = accountNumber;
    refAcc.ifsc = ifsc;
    Object account = {
      "refferalAccount": refAcc.toJson(),
    };
    await updateUser(account);
  }

  static Future<ReferAccount> getRefferAccount(String uid) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    var snapshot = await db.collection('Users').doc(uid).get();
    print(snapshot.get("refferalAccount"));
    Map<String, dynamic> accountMap = snapshot.get("refferalAccount");
    ReferAccount referAccount = ReferAccount.fromJson(accountMap);
    return referAccount;
  }

  Future<void> incrementTotalRefferal(String uid) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var snapshot = await db.collection('Users').doc(uid).get();
    int totalRefers = snapshot.data()['totalRefferal'];
    totalRefers += 1;
    await db
        .collection('Users')
        .doc(uid)
        .update({'totalRefferal': totalRefers});
  }

  static Future<void> incrementTotalCommision(String uid, double amount) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var snapshot = await db.collection('Users').doc(uid).get();

    double totalComm = snapshot.data()['totalCommision'].toDouble();
    totalComm += amount;
    await db.collection('Users').doc(uid).update({'totalCommision': totalComm});
  }

  static Future<void> handleUpiPayment(
      ReferAccount account, String amount, String uid) async {
    String url = "http://visit.bottomstreet.com/payment/index.php";
    Object body = {
      'amount': amount,
      'bank_account': '${account.accountNumber}',
      'secret_key': 'opqpwomsajhasuhqwe',
      'ifsc': '${account.ifsc}'
    };
    var response = await http.post(Uri.parse(url), body: body);
    print(response.body);

    var jsonData = jsonDecode(response.body);
    print(jsonData);
    if (jsonData["respones"]["status"] != "ACCEPTED") {
      BotToast.showText(
          contentColor: almostWhite,
          textStyle: TextStyle(color: black),
          text: "Error paying refferer");
    } else {
      FirebaseFirestore db = FirebaseFirestore.instance;
      var snapshot = await db.collection('Users').doc(uid).get();
      List<String> pIDs = List.castFrom(snapshot.data()['referPayments']);
      pIDs.add(jsonData['orderId']);
      await db.collection('Users').doc(uid).update({'referPayments': pIDs});
      await incrementTotalCommision(uid, (double.tryParse(amount) ?? 0.0));
    }
  }

  updateNewsWatchlist(Article article) async {
    await db.collection('Users').doc(user.uid).update({
      "NewsWatchlist": FieldValue.arrayUnion([article.toJson()])
    });
    await getUserdata(user);
    notifyListeners();
  }

  updateStocksWatchlist(String isin) async {
    await db.collection('Users').doc(user.uid).update({
      "StocksWatchlist": FieldValue.arrayUnion([isin])
    });
    await getUserdata(user);
    notifyListeners();
  }

  updateCryptoWatchlist(String cryptoCode) async {
    await db.collection('Users').doc(user.uid).update({
      "CryptoWatchlist": FieldValue.arrayUnion([cryptoCode])
    });
    await getUserdata(user);
    notifyListeners();
  }

  updateForexWatchlist(String forexCode) async {
    await db.collection('Users').doc(user.uid).update({
      "ForexWatchlist": FieldValue.arrayUnion([forexCode])
    });
    await getUserdata(user);
    notifyListeners();
  }

  updateMutualWatchlist(MutualWatchlistModel mf) async {
    await db.collection('Users').doc(user.uid).update({
      "MutualWatchlist": FieldValue.arrayUnion([mf.toJson()])
    });
    await getUserdata(user);
    notifyListeners();
  }

  updateEtfWatchlist(String etfCode) async {
    await db.collection('Users').doc(user.uid).update({
      "EtfWatchlist": FieldValue.arrayUnion([etfCode])
    });
    await getUserdata(user);
    notifyListeners();
  }

  updateGlobalIndicesWatchlist(String globalCode) async {
    await db.collection('Users').doc(user.uid).update({
      "GlobalIndicesWatchlist": FieldValue.arrayUnion([globalCode])
    });
    await getUserdata(user);
    notifyListeners();
  }

  updateIndianIndicesWatchlist(String indianCode) async {
    await db.collection('Users').doc(user.uid).update({
      "IndianIndicesWatchlist": FieldValue.arrayUnion([indianCode])
    });
    await getUserdata(user);
    notifyListeners();
  }

  removeNewsWatchlist(Article article) async {
    await db.collection('Users').doc(user.uid).update({
      "NewsWatchlist": FieldValue.arrayRemove([article.toJson()])
    });
    await getUserdata(user);
    notifyListeners();
  }

  removeCryptoWatchlist(List<dynamic> cryptoCode) async {
    await db.collection('Users').doc(user.uid).update({
      "CryptoWatchlist":
          FieldValue.arrayRemove(cryptoCode.map((e) => e).toList())
    });
    await getUserdata(user);
    notifyListeners();
  }

  removeEtfWatchlist(List<dynamic> etfCode) async {
    await db.collection('Users').doc(user.uid).update({
      "EtfWatchlist": FieldValue.arrayRemove(etfCode.map((e) => e).toList())
    });
    await getUserdata(user);
    notifyListeners();
  }

  removeForexWatchlist(List<dynamic> forexCode) async {
    await db.collection('Users').doc(user.uid).update({
      "ForexWatchlist": FieldValue.arrayRemove(forexCode.map((e) => e).toList())
    });
    await getUserdata(user);
    notifyListeners();
  }

  removeMutualWatchlist(List<dynamic> mf) async {
    await db.collection('Users').doc(user.uid).update(
        {"MutualWatchlist": FieldValue.arrayRemove(mf.map((e) => e).toList())});
    await getUserdata(user);
    notifyListeners();
  }

  removeMutualWatchlistOtherway(List<dynamic> mf) async {
    await db.collection('Users').doc(user.uid).update({"MutualWatchlist": mf});
    await getUserdata(user);
    notifyListeners();
  }

  removeGlobalIndicesWatchlist(List<dynamic> globalCode) async {
    await db.collection('Users').doc(user.uid).update({
      "GlobalIndicesWatchlist":
          FieldValue.arrayRemove(globalCode.map((e) => e).toList())
    });
    await getUserdata(user);
    notifyListeners();
  }

  removeIndianIndicesWatchlist(List<dynamic> indianCode) async {
    await db.collection('Users').doc(user.uid).update({
      "IndianIndicesWatchlist":
          FieldValue.arrayRemove(indianCode.map((e) => e).toList())
    });
    await getUserdata(user);
    notifyListeners();
  }

  removeNewsWatchlistFromList(List<Article> article) async {
    await db.collection('Users').doc(user.uid).update({
      "NewsWatchlist":
          FieldValue.arrayRemove(article.map((e) => e.toJson()).toList())
    });
    await getUserdata(user);
    notifyListeners();
  }

  removeStockWatchlistFromList(List<dynamic> isin) async {
    await db.collection('Users').doc(user.uid).update({
      "StocksWatchlist": FieldValue.arrayRemove(isin.map((e) => e).toList())
    });
    await getUserdata(user);
    notifyListeners();
  }
}
