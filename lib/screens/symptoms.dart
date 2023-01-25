import 'dart:convert';
import 'package:caducee/common/const.dart';
import 'package:caducee/common/symptoms_steps.dart';
import 'package:caducee/screens/first_symptoms_page.dart';
import 'package:caducee/screens/result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const backgroundColor = Color(0xff343541);
const botBackgroundColor = Color(0xff444654);

class Symptoms extends StatefulWidget {
  const Symptoms({super.key});

  @override
  State<Symptoms> createState() => _SymptomsState();
}

Future<String> generateResponse(String prompt) async {
  const apiKey = apiSecretKey;

  var url = Uri.https("api.openai.com", "/v1/completions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    },
    body: jsonEncode({
      "model": "text-davinci-003",
      "prompt": prompt,
      'temperature': 0.5,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    }),
  );

// Do something with the response
  Map<String, dynamic> newresponse =
      jsonDecode(utf8.decode(response.bodyBytes));
  return newresponse['choices'][0]['text'];
}

class _SymptomsState extends State<Symptoms> {
  void _showResponsePage(
      String response, String genre, int age, List<String> symptoms) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(
                response: response,
                genre: genre,
                age: age,
                symptoms: symptoms)));
  }

  late bool isLoading;
  bool firstPage = true;
  int currentStep = 0;
  List<String> symptoms = [];
  int _selectedGender = 0;
  int age = 0;
  String genre = "homme";

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  List<Step> getSteps() {
    return [
      ageStep(currentStep, age, setState, context, (value) {
        setState(() {
          if (value == "") {
            age = 0;
          } else {
            age = int.parse(value);
          }
        });
      }),
      genderStep(
        currentStep,
        _selectedGender,
        setState,
        genre,
        (value) {
          setState(() {
            genre = "homme";
            _selectedGender = value!;
          });
        },
        (value) {
          setState(() {
            _selectedGender = value!;
            genre = "femme";
          });
        },
      ),
      symptomStep(currentStep, setState, symptoms, context, (value) {
        setState(() {
          symptoms = value;
        });
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: firstPage
            ? FirstSymptomsPage(
                button: ElevatedButton(
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
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text("C'est parti !")),
              )
            : Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: myDarkGreen),
                ),
                child: isLoading
                    ? Theme.of(context).brightness == Brightness.dark
                        ? Center(
                            child: Image.asset(
                                'assets/images/diagnostic_dark.gif'))
                        : Center(
                            child: Image.asset(
                                'assets/images/diagnostic_light.gif'))
                    : Stepper(
                        type: StepperType.vertical,
                        steps: getSteps(),
                        currentStep: currentStep,
                        onStepTapped: (value) =>
                            setState(() => currentStep = value),
                        onStepContinue: () {
                          final isLastStep =
                              currentStep == getSteps().length - 1;
                          if (isLastStep) {
                          } else {
                            setState(() => currentStep += 1);
                          }
                        },
                        onStepCancel: currentStep == 0
                            ? null
                            : () => setState(() => currentStep -= 1),
                        controlsBuilder:
                            (BuildContext context, ControlsDetails details) {
                          return Row(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: currentStep == getSteps().length - 1
                                    ? () async {
                                        if (symptoms.length < 2 ||
                                            symptoms.length > 6 ||
                                            age < 1 ||
                                            age > 100) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            margin: const EdgeInsets.all(8.0),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              symptoms.length < 2
                                                  ? "Veuillez sélectionner au moins 2 symptômes"
                                                  : symptoms.length > 6
                                                      ? "Veuillez sélectionner au plus 6 symptômes"
                                                      : age < 1 || age > 100
                                                          ? "Veuillez entrer un âge valide"
                                                          : "Veuillez entrer un âge valide",
                                            ),
                                          ));
                                          return;
                                        }

                                        setState(() {
                                          isLoading = true;
                                        });
                                        String response = (await generateResponse(
                                            "Tu es un médecin et tu vas essayer de faire un diagnostic médical à partir mes symptômes avec des mots simple. J'ai $age ans, je suis un(e) $genre et j'ai ces symptômes : ${symptoms.join(", ")}. Fais une phrase dans ce style :Vous avez potentiellement un(e): (maladie)."));
                                        _showResponsePage(
                                            response, genre, age, symptoms);
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    : details.onStepContinue,
                                style: ElevatedButton.styleFrom(
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  minimumSize: const Size(100, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  currentStep == getSteps().length - 1
                                      ? 'Terminer'
                                      : 'Suivant',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              currentStep == 0
                                  ? Container()
                                  : TextButton(
                                      onPressed: details.onStepCancel,
                                      child: const Text('Retour',
                                          style: TextStyle(color: myGreen)),
                                    ),
                            ],
                          );
                        },
                      ),
              ));
  }
}
