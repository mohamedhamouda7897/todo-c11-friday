import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_friday/firebase_functions.dart';
import 'package:todo_c11_friday/home.dart';
import 'package:todo_c11_friday/login/signup.dart';
import 'package:todo_c11_friday/providers/my_provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "Login";

  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pushNamed(context, SignupScreen.routeName);
        },
        child: const Padding(
          padding: EdgeInsets.all(18.0),
          child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(text: "Dont't have an Account? "),
                TextSpan(
                    text: "SignUp",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ])),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FirebaseFunctions.loginUser(
                    emailController.text, passwordController.text,
                    onSuccess: (label) {
                      provider.initUser();
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.routeName, (route) => false,
                      arguments: label);
                }, onError: (error) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text(error),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Okay!!"))
                      ],
                    ),
                  );
                });
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
