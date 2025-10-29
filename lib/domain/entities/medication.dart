class Medication {
  final String id;
  final String name;
  final String dosage;
  final String manufacturer;
  final List<String> sideEffects;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.manufacturer,
    required this.sideEffects,
  });

  // Check if medication has specific side effect
  bool hasSideEffect(String sideEffect) {
    return sideEffects.contains(sideEffect);
  }

  // Add a new side effect to the list
  void addSideEffect(String sideEffect) {
    if (!sideEffects.contains(sideEffect)) {
      sideEffects.add(sideEffect);
    }
  }

  // Get formatted dosage information
  String get dosageInfo => '$name - $dosage';

  // Get full medication details
  Map<String, dynamic> get fullDetails => {
        'id': id,
        'name': name,
        'dosage': dosage,
        'manufacturer': manufacturer,
        'sideEffects': sideEffects,
      };
}
