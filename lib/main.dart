import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Home/HomePage.dart';
import 'package:flutter_application_1/routes/root.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/Start/StartScreen.dart';
import 'package:flutter_application_1/routes/Shopping/WantList/WantListPage.dart';
import 'package:flutter_application_1/routes/Shopping/SellPage.dart';
import 'package:flutter_application_1/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserState>(
      create: (context) => UserState(),
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/WantListPage': (BuildContext context) => WantListPage(),
          '/SellPage': (BuildContext context) => SellPage(),
          // '/settings': (BuildContext context) => SettingsPage(),
        },
        title: 'Buyear',
        // gradient: LinearGradient(
        //       colors: [Colors.lightBlue.shade200, Colors.deepPurple.shade200],
        //     ),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        home: LoginCheck(),
      ),
    );
  }
}

class LoginCheck extends StatefulWidget {
  const LoginCheck({Key? key}) : super(key: key);

  @override
  State<LoginCheck> createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // ログインしてない
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return StartScreen(title: "title");
          },
        ),
      );
    } else {
      // ログイン済み
      // ユーザー情報を更新
      final UserState userState =
          Provider.of<UserState>(context, listen: false);
      final uid = user.uid;
      final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("user")
          .where("userID", isEqualTo: uid)
          .get();
      final userProfile =
          userSnapshot.docs.first.data() as Map<String, dynamic>;
      final loginUserName = userProfile["userName"];
      userState.setUser(user);
      userState.setUserName(loginUserName!);
      userState.setUserID(uid);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return RootWidget();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
