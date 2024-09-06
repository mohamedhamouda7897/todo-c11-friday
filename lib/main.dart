import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_friday/firebase_options.dart';
import 'package:todo_c11_friday/home.dart';
import 'package:todo_c11_friday/login/login/login.dart';
import 'package:todo_c11_friday/login/signup.dart';
import 'package:todo_c11_friday/models/task_model.dart';
import 'package:todo_c11_friday/providers/my_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseFirestore.instance.enableNetwork();
  runApp(ChangeNotifierProvider(
    create: (context) => MyProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return MaterialApp(
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignupScreen.routeName: (context) => SignupScreen(),
      },
      initialRoute: pro.firebaseUser != null
          ? HomeScreen.routeName
          : LoginScreen.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
