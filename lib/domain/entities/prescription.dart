import 'dart:collection';
import 'medication.dart';
import 'doctor.dart';
import 'patient.dart';

class Prescription {
  final String _id;
  final DateTime _time;
  final List<Medication> _medications;
  final String _instructions;
  final Doctor _prescribedBy;
  final Patient _prescribedTo;

  // Getters
  String get id => _id;
  DateTime get time => _time;
  UnmodifiableListView<Medication> get medications =>
      UnmodifiableListView(_medications);
  String get instructions => _instructions;
  Doctor get prescribedBy => _prescribedBy;
  Patient get prescribedTo => _prescribedTo;

  Prescription({
    required String id,
    required DateTime time,
    required List<Medication> medications,
    required String instructions,
    required Doctor prescribedBy,
    required Patient prescribedTo,
  })  : _id = id,
        _time = time,
        _medications = List.from(medications),
        _instructions = instructions,
        _prescribedBy = prescribedBy,
        _prescribedTo = prescribedTo {
    _validatePrescription();
  }

  void _validatePrescription() {
    if (_id.trim().isEmpty) {
      throw ArgumentError('Prescription ID cannot be empty');
    }
    if (_instructions.trim().isEmpty) {
      throw ArgumentError('Instructions cannot be empty');
    }
  }

  // Get total number of medications in prescription
  int get medicationCount => _medications.length;

  // Add a medication to the prescription
  void addMedication(Medication medication) {
    if (!_medications.contains(medication)) {
      _medications.add(medication);
    }
  }

  // Remove a medication from the prescription
  void removeMedication(Medication medication) {
    _medications.remove(medication);
  }

  // Get all medication names as a list
  UnmodifiableListView<String> get medicationNames =>
      UnmodifiableListView(_medications.map((med) => med.name));

  // Get full prescription details
  Map<String, dynamic> get fullDetails => {
        'id': _id,
        'time': _time.toIso8601String(),
        'medications': _medications.map((med) => med.fullDetails).toList(),
        'instructions': _instructions,
        'doctor': _prescribedBy.name,
        'patient': _prescribedTo.name,
      };

  // Check if prescription is recent (within last 30 days)
  bool get isRecent => DateTime.now().difference(_time).inDays <= 30;

  // Get formatted prescription date
  String get formattedDate =>
      '${_time.year}-${_time.month.toString().padLeft(2, '0')}-${_time.day.toString().padLeft(2, '0')}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Prescription &&
          runtimeType == other.runtimeType &&
          _id == other._id;

  @override
  int get hashCode => _id.hashCode;

  @override
  String toString() =>
      'Prescription(id: $_id, patient: ${_prescribedTo.name}, doctor: ${_prescribedBy.name})';
}
