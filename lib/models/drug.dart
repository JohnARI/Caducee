class AppDrugData {
  final String name;
  final List<String> brand;
  final String shortDesc;
  final String longDesc;
  final List<String> dosage;
  final String category;
  final String recommendation;
  final String usage;
  AppDrugData(
      {required this.name,
      required this.shortDesc,
      required this.longDesc,
      required this.brand,
      required this.dosage,
      required this.recommendation,
      required this.usage,
      required this.category
      });
}