import 'package:flutter/material.dart';
import 'package:caducee/common/const.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

Step ageStep(int currentStep, int age, Function setState, BuildContext context,
    Function(String) onChanged) {
  return Step(
    state: currentStep > 0 ? StepState.complete : StepState.indexed,
    isActive: true,
    title: const Text('Âge'),
    content: Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          autocorrect: false,
          keyboardAppearance: Theme.of(context).brightness,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.person_outline,
              color: myDarkGreen,
            ),
            hintText: "Entrez votre âge",
          ),
          onChanged: onChanged,
        ),
        if (age > 120 && age != 0 || age < 1 && age != 0)
          const Text(
            "Veuillez renseigner un âge entre 1 et 120 ans",
            style: TextStyle(color: Colors.red),
          ),
        const SizedBox(height: 5),
        age != 0
            ? age == 1
                ? Text("Vous avez $age an")
                : Text("Vous avez $age ans")
            : Container(),
      ],
    ),
  );
}

Step genderStep(
    int currentStep,
    int selectedGender,
    Function setState,
    String genre,
    Function(int?) onChangedMale,
    Function(int?) onChangedFemale) {
  return Step(
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
          groupValue: selectedGender,
          onChanged: onChangedMale,
        ),
        RadioListTile(
          secondary: const Icon(
            Icons.female_outlined,
            color: myDarkGreen,
          ),
          activeColor: myDarkGreen,
          title: const Text('Femme'),
          value: 1,
          groupValue: selectedGender,
          onChanged: onChangedFemale,
        ),
      ],
    ),
  );
}

Step symptomStep(int currentStep, Function setState, List<String> symptoms,
    BuildContext context, Function(List<String>) onConfirm) {
  final items = allSymptoms
      .map((animal) => MultiSelectItem<String>(animal, animal))
      .toList();
  return Step(
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
                        dialogHeight: MediaQuery.of(context).size.height * 0.5,
                        selectedItemsTextStyle: const TextStyle(
                          color: myDarkGreen,
                          fontSize: 16,
                        ),
                        separateSelectedItems: true,
                        items: items,
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
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                        confirmText: const Text("Confirmer",
                            style: TextStyle(color: myDarkGreen)),
                        cancelText: const Text("Annuler",
                            style: TextStyle(color: myDarkGreen)),
                        isDismissible: true,
                        onConfirm: onConfirm,
                        onSelectionChanged: (selectedItems) {
                          if (selectedItems.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: const Duration(seconds: 1),
                                margin: const EdgeInsets.all(8.0),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                backgroundColor: myDarkGreen,
                                content: Text(
                                    "Vous avez sélectionné $selectedItems")));
                          }
                        },
                      ),
                    ],
                  )))
        ],
      ));
}
