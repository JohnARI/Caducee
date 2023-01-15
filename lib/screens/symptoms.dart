import 'dart:convert';
import 'package:caducee/common/const.dart';
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
  // final apiKey = apiSecretKey;

  var url = Uri.https("api.openai.com", "/v1/completions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $apiKey'
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
  int currentStep = 0;
  String response = "";
  List<String> symptoms = [];
  String _selectedValue = "";
  final List<String> bouche = ["Aucun", "Douleur à la mâchoire", "maux de dents", "Saignements de gencives", "Aphtes", "Ulcères buccaux", "Langue enflée", "Mauvaise haleine"];
  final List<String> gorge = ["Toux sèche", "Douleur en avalant", "Enrouement", "Douleur cervicale", "Ganglions lymphatiques enflés"];
  final List<String> vue = ["Aucun",
    "Vision floue", "Double vision", "Maux de tête liés à la vue", "Yeux rouges", "Éblouissement", "Photophobie"
  ];
  final List<String> oreilles = ["Aucun",
    "Acouphènes", "Bourdonnements d'oreille", "Perte d'audition", "Douleur à l'oreille", "Vertiges", "Équilibre Instable"
  ];
  final List<String> nez = [ "Aucun",
    "Nez qui coule", "Nez bouché", "Saignements de nez", "Perte d'odorat", "Démangeaisons de la narine"
  ];
  final List<String> tete = ["Aucun",
    "Maux de tête", "Migraines", "Vertiges", "Étourdissements", "Perte de conscience", "Vomissements"

  ];

  final List<String> corps = ["Aucun", 
     "Douleurs articulaires", "Douleurs musculaires", "Fatigue", "Frissons", "Transpiration", "Perte de poids", "Fièvre"
  ];

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
        title: const Text('Bouche'),
        content: SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              itemCount: bouche.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                  value: bouche[index],
                  groupValue: _selectedValue,
                  title: Text(bouche[index]),
                  onChanged: (value) {
                    setState(() {
                      symptoms
                          .removeWhere((symptom) => bouche.contains(symptom));
                      symptoms.add(value!);
                      if (value == "Aucun") {
                        _selectedValue = "";
                      } else {
                        _selectedValue = value;
                      }

                    });
                  },
                );
              },
            )),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text('Gorge'),
        content: SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              itemCount: gorge.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                  value: gorge[index],
                  groupValue: _selectedValue,
                  title: Text(gorge[index]),
                  onChanged: (value) {
                    setState(() {
                      symptoms
                          .removeWhere((symptom) => gorge.contains(symptom));
                      symptoms.add(value!);
                      if (value == "Aucun") {
                        _selectedValue = "";
                      } else {
                        _selectedValue = value;
                      }
                    });
                  },
                );
              },
            )),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text('Vue'),
        content: SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              itemCount: vue.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                  value: vue[index],
                  groupValue: _selectedValue,
                  title: Text(vue[index]),
                  onChanged: (value) {
                    setState(() {
                      symptoms
                          .removeWhere((symptom) => vue.contains(symptom));
                      symptoms.add(value!);
                      if (value == "Aucun") {
                        _selectedValue = "";
                      } else {
                        _selectedValue = value;
                      }
                    });
                  },
                );
              },
            )),
      ),
      Step(
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 3,
        title: const Text('Oreilles'),
        content: SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              itemCount: oreilles.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                  value: oreilles[index],
                  groupValue: _selectedValue,
                  title: Text(oreilles[index]),
                  onChanged: (value) {
                    setState(() {
                      symptoms
                          .removeWhere((symptom) => oreilles.contains(symptom));
                      symptoms.add(value!);
                      if (value == "Aucun") {
                        _selectedValue = "";
                      } else {
                        _selectedValue = value;
                      }
                    });
                  },
                );
              },
            )),
      ),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: const Text('Nez'),
        content: SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              itemCount: nez.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                  value: nez[index],
                  groupValue: _selectedValue,
                  title: Text(nez[index]),
                  onChanged: (value) {
                    setState(() {
                      symptoms
                          .removeWhere((symptom) => nez.contains(symptom));
                      symptoms.add(value!);
                      if (value == "Aucun") {
                        _selectedValue = "";
                      } else {
                        _selectedValue = value;
                      }
                    });
                  },
                );
              },
            )),
      ),
      Step(
        state: currentStep > 5 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 5,
        title: const Text('Tête'),
        content: SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              itemCount: tete.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                  value: tete[index],
                  groupValue: _selectedValue,
                  title: Text(tete[index]),
                  onChanged: (value) {
                    setState(() {
                      symptoms
                          .removeWhere((symptom) => tete.contains(symptom));
                      symptoms.add(value!);
                      if (value == "Aucun") {
                        _selectedValue = "";
                      } else {
                        _selectedValue = value;
                      }
                    });
                  },
                );
              },
            )),
      ),
      Step(
        state: currentStep > 6 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 6,
        title: const Text('Corps'),
        content: SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              itemCount: corps.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                  value: corps[index],
                  groupValue: _selectedValue,
                  title: Text(corps[index]),
                  onChanged: (value) {
                    setState(() {
                      symptoms
                          .removeWhere((symptom) => corps.contains(symptom));
                      symptoms.add(value!);
                      if (value == "Aucun") {
                       _selectedValue = "";
                      } else {
                        _selectedValue = value;
                      }
                    });
                  },
                );
              },
            )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Symptômes", style: TextStyle(color: myGreen)),
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: myGreen,
          ),
          child: isLoading
              ? Theme.of(context).brightness == Brightness.dark
                  ? Center(
                      child: Image.asset('assets/images/diagnostic_dark.gif'))
                  : Center(
                      child: Image.asset('assets/images/diagnostic_light.gif'))
              : Stepper(
                  type: StepperType.vertical,
                  steps: getSteps(),
                  currentStep: currentStep,
                  onStepTapped: (value) => setState(() => currentStep = value),
                  onStepContinue: () {
                    final isLastStep = currentStep == getSteps().length - 1;
                    if (isLastStep) {
                      print(symptoms);
                    } else {
                      setState(() => currentStep += 1);
                    }
                  },
                  onStepCancel: currentStep == 0
                      ? null
                      : () => setState(() => currentStep -= 1),

                  // custom the buttons
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
                                    borderRadius: BorderRadius.circular(8.0),
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
                                  setState(() {
                                    isLoading = true;
                                    print(symptoms);
                                  });
                                  response = await generateResponse(
                                      "J'ai ces symptômes : ${symptoms.join(", ")}. Fais une phrase dans ce style :Vous avez potentiellement: (nom des maladies). (conseil d'aller voir un médecin).");
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
                                    borderRadius: BorderRadius.circular(8.0),
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
