import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/storageServices.dart';
import 'authproviders.dart';

final firestoreUserProvider = Provider<Map<String, dynamic>>((ref) {
  return ref.watch(storageServicesProvider).fireStoreUser;
});

final storageServicesProvider = ChangeNotifierProvider<StorageService>((ref) {
  return StorageService(ref.watch(authServicesProvider).currentUser);
});

final storageUserProvider = FutureProvider<Map<String, dynamic>>((ref) {
  return ref.watch(storageServicesProvider).currentUserData;
});
