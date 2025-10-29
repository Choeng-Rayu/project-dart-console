import 'person.dart';

abstract class Staff extends Person {
  final String staffID;
  final DateTime hireDate;
  final double salary;
  final Map<String, List<DateTime>> schedule;

  Staff({
    required String name,
    required String dateOfBirth,
    required String address,
    required String tel,
    required this.staffID,
    required this.hireDate,
    required this.salary,
    required this.schedule,
  }) : super(
          name: name,
          dateOfBirth: dateOfBirth,
          address: address,
          tel: tel,
        );
}
