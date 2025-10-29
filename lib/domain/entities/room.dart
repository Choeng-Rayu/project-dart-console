import 'enums/room_type.dart';
import 'enums/room_status.dart';
import 'enums/equipment_status.dart';
import 'equipment.dart';
import 'bed.dart';

class Room {
  final String roomId;
  final String number;
  final RoomType roomType;
  RoomStatus status;
  final List<Equipment> equipment;
  final List<Bed> beds;

  Room({
    required this.roomId,
    required this.number,
    required this.roomType,
    required this.status,
    required this.equipment,
    required this.beds,
  });

  // Get available beds in the room
  List<Bed> getAvailableBeds() {
    return beds.where((bed) => bed.isAvailable).toList();
  }

  // Check if room has any available beds
  bool get hasAvailableBeds => beds.any((bed) => bed.isAvailable);

  // Get count of available beds
  int get availableBedCount => beds.where((bed) => bed.isAvailable).length;

  // Update room status
  void updateStatus(RoomStatus newStatus) {
    status = newStatus;
  }

  // Add equipment to room
  void addEquipment(Equipment newEquipment) {
    equipment.add(newEquipment);
  }

  // Remove equipment from room
  void removeEquipment(String equipmentId) {
    equipment.removeWhere((equipment) => equipment.equipmentId == equipmentId);
  }

  // Get all operational equipment
  List<Equipment> getOperationalEquipment() {
    return equipment
        .where((equipment) => equipment.status == EquipmentStatus.OPERATIONAL)
        .toList();
  }
}
