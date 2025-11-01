import 'dart:collection';
import 'staff.dart';
import 'room.dart';
import 'patient.dart';

class Nurse extends Staff {
  final List<Room> _assignedRooms;
  final List<Patient> _assignedPatients;

  // Getters
  UnmodifiableListView<Room> get assignedRooms =>
      UnmodifiableListView(_assignedRooms);
  UnmodifiableListView<Patient> get assignedPatients =>
      UnmodifiableListView(_assignedPatients);

  Nurse({
    required String name,
    required String dateOfBirth,
    required String address,
    required String tel,
    required String staffID,
    required DateTime hireDate,
    required double salary,
    required Map<String, List<DateTime>> schedule,
    required List<Room> assignedRooms,
    required List<Patient> assignedPatients,
  })  : _assignedRooms = List.from(assignedRooms),
        _assignedPatients = List.from(assignedPatients),
        super(
          name: name,
          dateOfBirth: dateOfBirth,
          address: address,
          tel: tel,
          staffID: staffID,
          hireDate: hireDate,
          salary: salary,
          schedule: schedule,
        );

  void _validateAssignments() {
    // Add any validation logic here if needed
    // For example, checking maximum number of assignments
  }

  // Add a room to nurse's assignments
  void assignRoom(Room room) {
    if (!_assignedRooms.contains(room)) {
      _assignedRooms.add(room);
      _validateAssignments();
    }
  }

  // Remove a room from nurse's assignments
  void removeRoom(Room room) {
    _assignedRooms.remove(room);
  }

  // Add a patient to nurse's assignments
  void assignPatient(Patient patient) {
    if (!_assignedPatients.contains(patient)) {
      _assignedPatients.add(patient);
      _validateAssignments();
    }
  }

  // Remove a patient from nurse's assignments
  void removePatient(Patient patient) {
    _assignedPatients.remove(patient);
  }

  // Get total number of patients
  int get patientCount => _assignedPatients.length;

  // Get total number of rooms
  int get roomCount => _assignedRooms.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other && other is Nurse && runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() =>
      'Nurse(staffID: $staffID, name: $name, patients: ${patientCount}, rooms: ${roomCount})';
}
