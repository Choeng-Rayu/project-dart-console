import 'medication.dart';
import 'doctor.dart';
import 'patient.dart';

class Prescription {
  final String id;
  final DateTime time;
  final List<Medication> medications;
  final String instructions;
  final Doctor prescribedBy;
  final Patient prescribedTo;

  Prescription({
    required this.id,
    required this.time,
    required this.medications,
    required this.instructions,
    required this.prescribedBy,
    required this.prescribedTo,
  });

  // Get total number of medications in prescription
  int get medicationCount => medications.length;

  // Add a medication to the prescription
  void addMedication(Medication medication) {
    if (!medications.contains(medication)) {
      medications.add(medication);
    }
  }

  // Remove a medication from the prescription
  void removeMedication(Medication medication) {
    medications.remove(medication);
  }

  // Get all medication names as a list
  List<String> get medicationNames =>
      medications.map((med) => med.name).toList();

  // Get full prescription details
  Map<String, dynamic> get fullDetails => {
        'id': id,
        'time': time.toIso8601String(),
        'medications': medications.map((med) => med.fullDetails).toList(),
        'instructions': instructions,
        'doctor': prescribedBy.name,
        'patient': prescribedTo.name,
      };

  // Check if prescription is recent (within last 30 days)
  bool get isRecent => DateTime.now().difference(time).inDays <= 30;

  // Get formatted prescription date
  String get formattedDate =>
      '${time.year}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}';
}
