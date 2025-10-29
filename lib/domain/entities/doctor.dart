import 'dart:collection';
import 'staff.dart';
import 'patient.dart';

class Doctor extends Staff {
  final String _specialization;
  final List<String> _certifications;
  final List<Patient> _currentPatients;

  // Getters
  String get specialization => _specialization;
  UnmodifiableListView<String> get certifications =>
      UnmodifiableListView(_certifications);
  UnmodifiableListView<Patient> get currentPatients =>
      UnmodifiableListView(_currentPatients);
  int get patientCount => _currentPatients.length;

  Doctor({
    required String name,
    required String dateOfBirth,
    required String address,
    required String tel,
    required String staffID,
    required DateTime hireDate,
    required double salary,
    required Map<String, List<DateTime>> schedule,
    required String specialization,
    required List<String> certifications,
    required List<Patient> currentPatients,
  })  : _specialization = specialization,
        _certifications = List.from(certifications),
        _currentPatients = List.from(currentPatients),
        super(
          name: name,
          dateOfBirth: dateOfBirth,
          address: address,
          tel: tel,
          staffID: staffID,
          hireDate: hireDate,
          salary: salary,
          schedule: schedule,
        ) {
    _validateDoctor();
  }

  void _validateDoctor() {
    if (_specialization.trim().isEmpty) {
      throw ArgumentError('Specialization cannot be empty');
    }
  }

  // Add a patient to doctor's current patients
  void addPatient(Patient patient) {
    if (!_currentPatients.contains(patient)) {
      _currentPatients.add(patient);
    }
  }

  // Remove a patient from doctor's current patients
  void removePatient(Patient patient) {
    _currentPatients.remove(patient);
  }

  // Check if doctor is certified in a specific area
  bool hasCertification(String certification) {
    return _certifications.contains(certification);
  }

  // Add a new certification
  void addCertification(String certification) {
    if (!_certifications.contains(certification)) {
      _certifications.add(certification);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Doctor &&
          runtimeType == other.runtimeType &&
          _specialization == other._specialization;

  @override
  int get hashCode => super.hashCode ^ _specialization.hashCode;

  @override
  String toString() =>
      'Doctor(staffID: $staffID, name: $name, specialization: $_specialization)';
}
