import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../onboarding/authentication/auth.dart';

final authServicesProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(FirebaseAuth.instance);
});

final authStateProvider = StreamProvider<User>((ref) {
  return ref.watch(authServicesProvider).authStateChanges;
});

final emailProvider = StateProvider<String>((ref) {
  return null;
});
final passwordProvider = StateProvider<String>((ref) {
  return null;
});
