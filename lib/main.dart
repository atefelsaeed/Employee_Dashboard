import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'hassan/my_home_page.dart';
import 'hassan/employee_model.dart';
import 'package:provider/provider.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(ChangeNotifierProvider<Employees>(
    create: (_) => Employees(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(canvasColor: Color.fromRGBO(255, 255, 255, 20)),
      home: MyHomePage(),
    );
  }
}
