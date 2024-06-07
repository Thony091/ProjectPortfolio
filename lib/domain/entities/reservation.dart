class Reservation{

  final String id;
  final String name;
  final String rut;
  final String email;
  final DateTime reservationDate;
  final DateTime reservationTime;
  final String serviceName;

  Reservation({
    required this.id,
    required this.name,
    required this.rut,
    required this.email,
    required this.reservationDate,
    required this.reservationTime,
    required this.serviceName,
  });
}