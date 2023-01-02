class AppDrugData {
  final String name;
  final String molecule;
  final String description;
  final List<String> form;
  final List<String> dosage;
  final String category;
  final String recommendation;
  final String usage;
  final List<String> favorite;
  AppDrugData(
      {required this.name,
      required this.description,
      required this.molecule,
      required this.form,
      required this.dosage,
      required this.recommendation,
      required this.usage,
      required this.category,
      this.favorite = const [],
      });
}