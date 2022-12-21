import 'package:caducee/common/const.dart';
import 'package:caducee/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:caducee/common/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showLogin = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState!.reset();
      error = '';
      emailController.text = '';
      passwordController.text = '';
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              elevation: 0.0,
              title: Text(
                  showLogin ? 'Connexion' : 'Inscription'),
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    showLogin ? 'Inscription' : 'Connexion',
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: toggleView,
                )
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Input email
                    TextFormField(
                      controller: emailController,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Entrez un email' : null,
                    ),

                    // Input password
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: passwordController,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Mot de passe',
                      ),
                      validator: (value) =>
                          value!.length > 6 ? 'Le mot de passe doit au moins faire 6 charactères' : null,
                      obscureText: true,
                    ),
                    const SizedBox(height: 10.0),

                    // Submit button
                    ElevatedButton(
                      child: Text(
                        showLogin ? 'Connexion' : 'Inscription',
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          var password = passwordController.value.text;
                          var email = emailController.value.text;

                          dynamic result = showLogin 
                          ? await _auth.signInWithEmailAndPassword(email, password) 
                          : await _auth.registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Email ou mot de passe incorrect';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
