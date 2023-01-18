import 'dart:convert';
import 'package:caducee/common/const.dart';
import 'package:caducee/screens/first_symptoms_page.dart';
import 'package:caducee/screens/result.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
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
      'temperature': 1,
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
  void _showResponsePage(String response) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(response: response)));
  }

  late bool isLoading;
  bool firstPage = true;
  int currentStep = 0;
  String response = "";
  List<String> symptoms = [];
  double _selectedAge = 1;
  int _selectedGender = 0;
  int age = 0;
  String genre = "";

  final _items = allSymptoms
      .map((animal) => MultiSelectItem<String>(animal, animal))
      .toList();

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  List<Step> getSteps() {
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: true,
        title: const Text('Âge'),
        content: Column(
          children: [
            const Text("Veuillez renseigner votre âge"),
            Slider(
                activeColor: myDarkGreen,
                inactiveColor: myGreen,
                value: _selectedAge,
                onChanged: (newValue) {
                  setState(() {
                    _selectedAge = newValue;
                    age = _selectedAge.round();
                  });
                },
                min: 1,
                max: 100,
                divisions: 100,
                label: _selectedAge.round() == 1
                    ? "${_selectedAge.round()} an"
                    : "${_selectedAge.round()} ans"),
            age != 0
                ? age == 1
                    ? Text("Vous avez $age an")
                    : Text("Vous avez $age ans")
                : Container(),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: true,
        title: const Text('Genre'),
        content: Column(
          children: [
            const Text("Veuillez renseigner votre genre"),
            RadioListTile(
              secondary: const Icon(
                Icons.male_outlined,
                color: myDarkGreen,
              ),
              activeColor: myDarkGreen,
              title: const Text('Homme'),
              value: 0,
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  genre = "homme";
                  _selectedGender = value!;
                });
              },
            ),
            RadioListTile(
              secondary: const Icon(
                Icons.female_outlined,
                color: myDarkGreen,
              ),
              activeColor: myDarkGreen,
              title: const Text('Femme'),
              value: 1,
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                  genre = "femme";
                });
              },
            ),
          ],
        ),
      ),
      Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: true,
          title: const Text('Symptômes'),
          content: Column(
            children: [
              SingleChildScrollView(
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          const Text("Veuillez renseigner vos symptômes"),
                          const SizedBox(height: 40),
                          MultiSelectDialogField(
                            searchable: true,
                            searchHint: "Rechercher",
                            barrierColor: Colors.black.withOpacity(0.5),
                            closeSearchIcon: const Icon(Icons.close),
                            dialogHeight:
                                MediaQuery.of(context).size.height * 0.5,
                            selectedItemsTextStyle: const TextStyle(
                              color: myDarkGreen,
                              fontSize: 16,
                            ),
                            separateSelectedItems: true,
                            items: _items,
                            title: const Text("Symptômes"),
                            selectedColor: myDarkGreen,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: myGreen,
                                width: 1,
                              ),
                            ),
                            buttonIcon: const Icon(
                              Icons.thermostat_outlined,
                              color: myDarkGreen,
                            ),
                            buttonText: const Text(
                              "Symptômes",
                              style: TextStyle(
                                color: myDarkGreen,
                                fontSize: 16,
                              ),
                            ),
                            unselectedColor:
                                Theme.of(context).textTheme.bodyText1!.color,
                            itemsTextStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            confirmText: const Text("Confirmer",
                                style: TextStyle(color: myDarkGreen)),
                            cancelText: const Text("Annuler",
                                style: TextStyle(color: myDarkGreen)),
                            isDismissible: true,
                            onConfirm: (value) {
                              symptoms = value;
                            },
                          ),
                        ],
                      )))
            ],
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              currentStep == getSteps().length - 1
                                  ? TextButton(
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: myDarkGreen,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Terminer',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (symptoms.length < 2 ||
                                            symptoms.length > 6 ||
                                            age == 0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              margin: const EdgeInsets.all(8.0),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                symptoms.length < 2
                                                    ? "Veuillez renseigner au moins 2 symptômes"
                                                    : age == 0
                                                        ? "Veuillez renseigner votre âge"
                                                        : "Veuillez renseigner au plus 6 symptômes",
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        setState(() {
                                          isLoading = true;
                                        });
                                        response = await generateResponse(
                                            "J'ai $age ans et je suis un(e) $genre et j'ai ces symptômes : ${symptoms.join(", ")}. Fais une phrase dans ce style :Vous avez potentiellement: (nom des maladies). (conseil d'aller voir un médecin)");
                                        _showResponsePage(response);
                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                                    )
                                  : TextButton(
                                      onPressed: details.onStepContinue,
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: myDarkGreen,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Suivant',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                            ),
                                          ),
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
