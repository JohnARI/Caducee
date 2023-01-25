import 'package:flutter/material.dart';

class FirstSymptomsPage extends StatefulWidget {
  const FirstSymptomsPage({super.key, required this.button});
  final Widget button;

  @override
  State<FirstSymptomsPage> createState() => _FirstSymptomsPageState();
}

class _FirstSymptomsPageState extends State<FirstSymptomsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "DIAGNOSTIC",
                style: TextStyle(fontSize: 15, letterSpacing: 8),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/images/symptoms_first_dark.gif'
                  : 'assets/images/symptoms_first_light.gif',
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Bienvenue sur le diagnostic symptomatique",
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Le test n'est pas un diagnostic médical, il ne remplace pas une consultation.",
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          widget.button,
        ],
      ),
    );
  }
}
