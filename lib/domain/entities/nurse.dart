import 'staff.dart';
import 'room.dart';
import 'patient.dart';

class Nurse extends Staff {
  final List<Room> assignedRooms;
  final List<Patient> assignedPatients;

  Nurse({
    required String name,
    required String dateOfBirth,
    required String address,
    required String tel,
    required String staffID,
    required DateTime hireDate,
    required double salary,
    required Map<String, List<DateTime>> schedule,
    required this.assignedRooms,
    required this.assignedPatients,
  }) : super(
          name: name,
          dateOfBirth: dateOfBirth,
          address: address,
          tel: tel,
          staffID: staffID,
          hireDate: hireDate,
          salary: salary,
          schedule: schedule,
        );

  // Assign a new room to the nurse
  void assignRoom(Room room) {
    if (!assignedRooms.contains(room)) {
      assignedRooms.add(room);
    }
  }

  // Remove a room from nurse's assignments
  void removeRoom(Room room) {
    assignedRooms.remove(room);
  }

  // Assign a new patient to the nurse
  void assignPatient(Patient patient) {
    if (!assignedPatients.contains(patient)) {
      assignedPatients.add(patient);
    }
  }

  // Remove a patient from nurse's assignments
  void removePatient(Patient patient) {
    assignedPatients.remove(patient);
  }

  // Get total number of patients
  int get patientCount => assignedPatients.length;

  // Get total number of rooms
  int get roomCount => assignedRooms.length;
}