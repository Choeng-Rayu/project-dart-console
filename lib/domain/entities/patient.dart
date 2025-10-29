import 'dart:collection';
import 'person.dart';
import 'doctor.dart';
import 'nurse.dart';
import 'prescription.dart';
import 'room.dart';
import 'bed.dart';

class Patient extends Person {
  final String _patientID;
  final String _bloodType;
  final List<String> _medicalRecords;
  final List<String> _allergies;
  final String _emergencyContact;

  // Relationships
  final List<Doctor> _assignedDoctors;
  final List<Nurse> _assignedNurses;
  final List<Prescription> _prescriptions;
  Room? _currentRoom;
  Bed? _currentBed;

  // Getters
  String get patientID => _patientID;
  String get bloodType => _bloodType;
  UnmodifiableListView<String> get medicalRecords =>
      UnmodifiableListView(_medicalRecords);
  UnmodifiableListView<String> get allergies =>
      UnmodifiableListView(_allergies);
  String get emergencyContact => _emergencyContact;

  // Relationship getters
  UnmodifiableListView<Doctor> get assignedDoctors =>
      UnmodifiableListView(_assignedDoctors);
  UnmodifiableListView<Nurse> get assignedNurses =>
      UnmodifiableListView(_assignedNurses);
  UnmodifiableListView<Prescription> get prescriptions =>
      UnmodifiableListView(_prescriptions);
  Room? get currentRoom => _currentRoom;
  Bed? get currentBed => _currentBed;

  Patient({
    required String name,
    required String dateOfBirth,
    required String address,
    required String tel,
    required String patientID,
    required String bloodType,
    required List<String> medicalRecords,
    required List<String> allergies,
    required String emergencyContact,
    List<Doctor>? assignedDoctors,
    List<Nurse>? assignedNurses,
    List<Prescription>? prescriptions,
    Room? currentRoom,
    Bed? currentBed,
  })  : _patientID = patientID,
        _bloodType = bloodType,
        _medicalRecords = List.from(medicalRecords),
        _allergies = List.from(allergies),
        _emergencyContact = emergencyContact,
        _assignedDoctors = List.from(assignedDoctors ?? []),
        _assignedNurses = List.from(assignedNurses ?? []),
        _prescriptions = List.from(prescriptions ?? []),
        _currentRoom = currentRoom,
        _currentBed = currentBed,
        super(
          name: name,
          dateOfBirth: dateOfBirth,
          address: address,
          tel: tel,
        ) {
    _validatePatient();
  }

  // Doctor relationship methods
  void assignDoctor(Doctor doctor) {
    if (!_assignedDoctors.contains(doctor)) {
      _assignedDoctors.add(doctor);
      doctor.addPatient(this);
    }
  }

  void removeDoctor(Doctor doctor) {
    if (_assignedDoctors.remove(doctor)) {
      doctor.removePatient(this);
    }
  }

  // Nurse relationship methods
  void assignNurse(Nurse nurse) {
    if (!_assignedNurses.contains(nurse)) {
      _assignedNurses.add(nurse);
      nurse.assignPatient(this);
    }
  }

  void removeNurse(Nurse nurse) {
    if (_assignedNurses.remove(nurse)) {
      nurse.removePatient(this);
    }
  }

  // Room and bed assignment methods
  void assignToBed(Room room, Bed bed) {
    if (bed.isAvailable && room.beds.contains(bed)) {
      // Discharge from current bed if any
      discharge();

      _currentRoom = room;
      _currentBed = bed;
      bed.assignPatient(this);
    } else {
      throw ArgumentError('Bed is not available or not in the specified room');
    }
  }

  void discharge() {
    if (_currentBed != null) {
      _currentBed!.removePatient();
      _currentBed = null;
      _currentRoom = null;
    }
  }

  // Prescription methods
  void addPrescription(Prescription prescription) {
    if (prescription.prescribedTo == this &&
        !_prescriptions.contains(prescription)) {
      _prescriptions.add(prescription);
    }
  }

  // Get active prescriptions (not older than 30 days)
  UnmodifiableListView<Prescription> get activePrescriptions =>
      UnmodifiableListView(_prescriptions.where((p) => p.isRecent));

  void _validatePatient() {
    if (_patientID.trim().isEmpty) {
      throw ArgumentError('Patient ID cannot be empty');
    }
    if (_bloodType.trim().isEmpty) {
      throw ArgumentError('Blood type cannot be empty');
    }
    if (_emergencyContact.trim().isEmpty) {
      throw ArgumentError('Emergency contact cannot be empty');
    }
  }

  // Add a medical record
  void addMedicalRecord(String record) {
    if (record.trim().isNotEmpty) {
      _medicalRecords.add(record);
    }
  }

  // Add an allergy
  void addAllergy(String allergy) {
    if (allergy.trim().isNotEmpty && !_allergies.contains(allergy)) {
      _allergies.add(allergy);
    }
  }

  // Remove an allergy
  void removeAllergy(String allergy) {
    _allergies.remove(allergy);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Patient &&
          runtimeType == other.runtimeType &&
          _patientID == other._patientID;

  @override
  int get hashCode => super.hashCode ^ _patientID.hashCode;

  @override
  String toString() =>
      'Patient(patientID: $_patientID, name: $name, bloodType: $_bloodType)';
}
