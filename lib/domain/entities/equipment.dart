import 'enums/equipment_status.dart';

class Equipment {
  final String equipmentId;
  final String name;
  final String type;
  final String serialNumber;
  EquipmentStatus status;
  final DateTime lastServiceDate;
  final DateTime nextServiceDate;

  Equipment({
    required this.equipmentId,
    required this.name,
    required this.type,
    required this.serialNumber,
    required this.status,
    required this.lastServiceDate,
    required this.nextServiceDate,
  });

  void reportMaintenance() {
    status = EquipmentStatus.IN_MAINTENANCE;
  }

  void updateStatus(EquipmentStatus newStatus) {
    status = newStatus;
  }
}
