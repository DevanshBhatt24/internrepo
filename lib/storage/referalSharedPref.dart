// import 'package:shared_preferences/shared_preferences.dart';

// class ReferralSharedPreference {
//   static SharedPreferences _preferences;

//   static const _alreadyAdded = 'alreadyAdded';
//   static const _date = 'date';
//   static const _bool = 'bool';

//   static Future init() async {
//     _preferences = await SharedPreferences.getInstance();
//   }

//   static Future setAlreadyAdded(bool alreadyAdded) async =>
//       await _preferences.setBool(_alreadyAdded, alreadyAdded);

//   static bool getAlreadyAdded() => _preferences.getBool(_alreadyAdded) ?? null;

//   static Future setBool(bool bool) async =>
//       await _preferences.setBool(_bool, bool);

//   static bool getBool() => _preferences.getBool(_bool) ?? null;

//   static Future setDate(DateTime d) async {
//     final date = d.toIso8601String();

//     return await _preferences.setString(_date, date);
//   }

//   static DateTime getDate() {
//     final date = _preferences.getString(_date);
//     return date == null ? null : DateTime.tryParse(date) ?? null;
//   }
// }
