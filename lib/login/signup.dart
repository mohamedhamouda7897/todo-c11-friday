import 'package:flutter/material.dart';
import 'package:todo_c11_friday/firebase_functions.dart';
import 'package:todo_c11_friday/login/login/login.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = "signUp";

  SignupScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('SignUp Screen'),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.all(18.0),
          child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(text: "I have an Account? "),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ])),
        ),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null) {
                    return "Please enter email Address";
                  }
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@gmail+\.[a-zA-Z]+")
                      .hasMatch(value);

                  if (!emailValid) {
                    return "Please enter Valid Email Format ex: example@gmail.com ";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: userNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your username";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'phone',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ageController,
                validator: (value) {},
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'age',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  bool regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(value!);
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FirebaseFunctions.createAccountAuth(
                        emailController.text, passwordController.text,
                        age: int.parse(ageController.text),
                        phone: phoneController.text,
                        userName: userNameController.text, onSuccess: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    }, onError: (error) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(error),
                          actions: [
                            ElevatedButton(
                                onPressed: () {}, child: Text("Cacnel")),
                            ElevatedButton(onPressed: () {}, child: Text("Ok")),
                          ],
                        ),
                      );
                    });
                  }
                },
                child: const Text('SignUp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
