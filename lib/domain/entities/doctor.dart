import 'staff.dart';
import 'patient.dart';

class Doctor extends Staff {
  final String specialization;
  final List<String> certifications;
  final List<Patient> currentPatients;

  Doctor({
    required String name,
    required String dateOfBirth,
    required String address,
    required String tel,
    required String staffID,
    required DateTime hireDate,
    required double salary,
    required Map<String, List<DateTime>> schedule,
    required this.specialization,
    required this.certifications,
    required this.currentPatients,
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

  // Add a patient to doctor's current patients
  void addPatient(Patient patient) {
    if (!currentPatients.contains(patient)) {
      currentPatients.add(patient);
    }
  }

  // Remove a patient from doctor's current patients
  void removePatient(Patient patient) {
    currentPatients.remove(patient);
  }

  // Get total number of current patients
  int get patientCount => currentPatients.length;

  // Check if doctor is certified in a specific area
  bool hasCertification(String certification) {
    return certifications.contains(certification);
  }

  // Add a new certification
  void addCertification(String certification) {
    if (!certifications.contains(certification)) {
      certifications.add(certification);
    }
  }
}