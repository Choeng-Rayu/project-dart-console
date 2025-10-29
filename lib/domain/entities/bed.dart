import 'enums/bed_type.dart';
import 'patient.dart';

class Bed {
  final String bedNumber;
  final BedType bedType;
  bool isOccupied;
  Patient? patientId; // Nullable since bed might be empty
  final List<String> features;

  Bed({
    required this.bedNumber,
    required this.bedType,
    this.isOccupied = false,
    this.patientId,
    required this.features,
  });

  // Assign patient to bed
  void assignPatient(Patient patient) {
    patientId = patient;
    isOccupied = true;
  }

  // Remove patient from bed
  void removePatient() {
    patientId = null;
    isOccupied = false;
  }

  // Check if bed is available
  bool get isAvailable => !isOccupied;
}
