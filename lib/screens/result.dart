import 'package:caducee/common/const.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(
      {super.key,
      required this.response,
      required this.genre,
      required this.age,
      required this.symptoms});
  final String response;
  final String genre;
  final int age;
  final List<String> symptoms;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool firstPage = true;

  @override
  void initState() {
    super.initState();
    firstPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return firstPage
        ? Scaffold(
            body: Column(
              children: [
                const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "RÉSULTAT",
                      style: TextStyle(fontSize: 15, letterSpacing: 8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/result_dark.gif'
                        : 'assets/images/result_light.gif',
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Avant de commencer, voici quelques informations à savoir",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Le diagnostic à été fait à partir de vos symptômes et de vos informations personnelles.",
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.red,
                      ),
                      Text(
                        "Le résultat est généré par une intelligence artificielle, il peut donc être erroné. Ne vous fiez pas à elle.",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      firstPage = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: myDarkGreen,
                    animationDuration: const Duration(milliseconds: 300),
                    minimumSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Text("Voir le résultat"),
                ),
              ],
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    const Text(
                      "DIAGNOSTIC TERMINÉ",
                      style: TextStyle(
                        letterSpacing: 10,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      widget.response,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircularPercentIndicator(
                            radius: 60,
                            percent: widget.age / 100,
                            animation: true,
                            animationDuration: 1000,
                            lineWidth: 10,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: myDarkGreen,
                            backgroundColor: myDarkGreen.withOpacity(0.2),
                            center: Text(
                              "${widget.age} ans",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          CircularPercentIndicator(
                            radius: 60,
                            percent: 1,
                            animation: true,
                            animationDuration: 1000,
                            lineWidth: 10,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: widget.genre == 'homme'
                                ? Colors.blue
                                : Colors.pink,
                            backgroundColor: myDarkGreen.withOpacity(0.2),
                            center: widget.genre == 'homme'
                                ? Icon(
                                    Icons.male_rounded,
                                    size: 80,
                                    color: Colors.blue.shade300,
                                  )
                                : Icon(
                                    Icons.female_rounded,
                                    size: 80,
                                    color: Colors.pink.shade300,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: const [
                        Icon(Icons.warning, color: Colors.red, size: 30.0),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Ce test n'est pas un diagnostic médical, il ne remplace pas une consultation.",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: myDarkGreen,
                        animationDuration: const Duration(milliseconds: 300),
                        minimumSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Text("Retour à l'accueil"),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
