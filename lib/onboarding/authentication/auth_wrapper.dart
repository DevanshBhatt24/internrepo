import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import '../../components/LoadingPage.dart';
import '../../main.dart';
import '../../providers/authproviders.dart';
import '../../providers/storageProviders.dart';
import '../splashScreen.dart';
import '../startScreen.dart';

class AuthenticationWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _authState = watch(authStateProvider);
    final u = watch(firestoreUserProvider);
    return _authState.when(
      data: (value) {
        print("value changed");
        if (value != null) {
          print("not null");
          context.read(storageServicesProvider).getUserdata(value);
          if (u == null) return SplashScreen();
          return MainBuild();
        } else {
          print("null");
          return Startscreen();
        }
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
      error: (_, __) {
        return Scaffold(
          body: Center(
            child: Text("OOPS"),
          ),
        );
      },
    );
  }
}

class MainBuild extends StatefulWidget {
  const MainBuild({Key key}) : super(key: key);

  @override
  _MainBuildState createState() => _MainBuildState();
}

class _MainBuildState extends State<MainBuild> {
  @override
  Widget build(BuildContext context) {
    // return LoadingPage();
    return Container(
      color: Colors.black,
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => NavC()), (route) => false);
    });
  }
}
