import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
        home: StartScreen(title: 'Welcome to Buyear'),
      )
    );
  }
}