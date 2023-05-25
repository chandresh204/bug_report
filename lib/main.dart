import 'package:bug_report/constants.dart';
import 'package:bug_report/firebase_options.dart';
import 'package:bug_report/project_list_page.dart';
import 'package:bug_report/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'project_info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    _initializeFirebaseVariables();
    context = context;
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(color: Colors.black)
      ),
      home: _selectRoute(),
    );
  }

  void _initializeFirebaseVariables() {
    Constants.auth = FirebaseAuth.instance;
    Constants.dbRef = FirebaseDatabase.instanceFor(
        app: Firebase.app() ,
        databaseURL: 'https://bugreportapp-a2fe2-default-rtdb.asia-southeast1.firebasedatabase.app/')
        .ref(Constants.auth.currentUser!.phoneNumber);
    print('current database: ${FirebaseDatabase.instance.databaseURL}');
  }

  Widget _selectRoute() {
    if (Constants.auth.currentUser != null) {
      return ProjectListPage();
    }
    return SignIn();
  }
}