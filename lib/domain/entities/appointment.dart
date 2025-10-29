import 'patient.dart';
import 'room.dart';
import 'doctor.dart';
import 'enums/appointment_status.dart';

class Appointment {
  final String id;
  final DateTime dateTime;
  final int duration; // in minutes
  final Patient patient;
  final Doctor doctor;
  final Room? room;
  AppointmentStatus status;
  final String reason;
  final String? notes;

  Appointment({
    required this.id,
    required this.dateTime,
    required this.duration,
    required this.patient,
    required this.doctor,
    this.room,
    this.status = AppointmentStatus.SCHEDULE,
    required this.reason,
    this.notes,
  });
}
