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

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showLogin = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState!.reset();
      error = '';
      nameController.text = '';
      emailController.text = '';
      passwordController.text = '';
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: SafeArea(
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 30.0),
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset('assets/images/iconLogo.png')),
                        !showLogin
                            ? const Text(
                                'Inscription',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: myDarkGreen,
                                ),
                              )
                            : const Text(
                                'Connexion',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: myDarkGreen,
                                ),
                              ),
                        const Text(
                          'Bienvenue sur Caducée',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),

                        const SizedBox(height: 25.0),

                        Text(
                          error,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),

                        // Input for name on the register screen
                        !showLogin
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: TextFormField(
                                  autocorrect: false,
                                  style: textColor,
                                  controller: nameController,
                                  decoration: textInputDecoration.copyWith(
                                    hintText: 'Nom',
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: myDarkGreen,
                                    ),
                                    hintStyle: textColor,
                                  ),
                                  validator: (value) =>
                                      value!.isEmpty ? 'Entrez un nom' : null,
                                ),
                              )
                            : Container(),
                        // End of input for name on the register screen

                        !showLogin ? const SizedBox(height: 10.0) : Container(),

                        // Input email on both pages

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            autocorrect: false,
                            style: textColor,
                            controller: emailController,
                            decoration: textInputDecoration.copyWith(
                              hintText: 'Email',
                              hintStyle: textColor,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: myDarkGreen,
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Entrez un email' : null,
                          ),
                        ),

                        // End of input email on both pages

                        // Input password on both pages
                        const SizedBox(height: 10.0),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            autocorrect: false,
                            style: textColor,
                            controller: passwordController,
                            decoration: textInputDecoration.copyWith(
                              hintText: 'Mot de passe',
                              hintStyle: textColor,
                              prefixIcon:
                                  const Icon(Icons.lock, color: myDarkGreen),
                            ),
                            validator: (value) => value!.length < 6
                                ? 'Entrez un mot de passe d\'au moins 6 caractères'
                                : null,
                            obscureText: true,
                          ),
                        ),
                        // End of input password on both pages

                        !showLogin ? Container() : const SizedBox(height: 10.0),

                        !showLogin
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text('Mot de passe oublié ?',
                                        style: TextStyle(
                                          color: Colors.black54,
                                        )),
                                  ],
                                ),
                              ),
                        const SizedBox(height: 25.0),

                        // Submit button
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              var password = passwordController.value.text;
                              var email = emailController.value.text;
                              var name = nameController.value.text;

                              dynamic result = showLogin
                                  ? await _auth.signInWithEmailAndPassword(
                                      email, password)
                                  : await _auth.registerWithEmailAndPassword(
                                      name, email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Email ou mot de passe incorrect';
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(25.0),
                            margin:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            decoration: BoxDecoration(
                              color: myDarkGreen,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                showLogin ? 'Connectez-vous' : 'Inscription',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50.0),

                        // Don't have an account
                        GestureDetector(
                          onTap: toggleView,
                          child: Text(
                            showLogin
                                ? 'Vous n\'avez pas de compte ? Inscrivez-vous'
                                : 'Vous avez déjà un compte ? Connectez-vous',
                            style: const TextStyle(
                              color: myDarkGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
