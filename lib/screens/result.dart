import 'package:caducee/common/const.dart';
import 'package:caducee/components/result_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

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
  bool firstPage = false;
  final int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    firstPage = false;
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
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
                    repeat: ImageRepeat.repeat,
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
            body: LiquidSwipe(
              enableLoop: false,
              pages: [
                ResultPage(
                  image: const AssetImage('assets/images/result_age.png'),
                  title: "Vous avez :",
                  subtitle: "${widget.age.toString()} ans",
                  color: Colors.white,
                  button: Container(),
                ),
                ResultPage(
                  image: const AssetImage('assets/images/result_genre.png'),
                  title: "Vous êtes :",
                  subtitle: widget.genre,
                  color: Colors.grey.shade100,
                  button: Container(),
                ),
                ResultPage(
                  image: const AssetImage('assets/images/result_symptoms.png'),
                  title: "Vous avez ces symptômes :",
                  subtitle: widget.symptoms.toString(),
                  color: Colors.white,
                  button: Container(),
                ),
                ResultPage(
                  image: const AssetImage('assets/images/result_result.png'),
                  title: "Résultat :",
                  subtitle: widget.response,
                  color: Colors.grey.shade100,
                  button: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                backgroundColor: myDarkGreen,
                animationDuration: const Duration(milliseconds: 300),
                minimumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                  ),
                  child: const Text("Retour à l'accueil"),
                ),
                ),
              ],
              slideIconWidget: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              positionSlideIcon: 0.5,
              waveType: WaveType.liquidReveal,
            ),
          );
  }
}
