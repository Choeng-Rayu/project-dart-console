import 'person.dart';

class Patient extends Person {
  final String patientID;
  final String bloodType;
  final List<String> medicalRecords;
  final List<String> allergies;
  final String emergencyContact;

  Patient({
    required String name,
    required String dateOfBirth,
    required String address,
    required String tel,
    required this.patientID,
    required this.bloodType,
    required this.medicalRecords,
    required this.allergies,
    required this.emergencyContact,
  }) : super(
          name: name,
          dateOfBirth: dateOfBirth,
          address: address,
          tel: tel,
        );
}
