import '../../domain/domain.dart';
import '../infrastructure.dart';

class ReservationRepositoryImpl extends ReservationRepository {

  final ReservationDatasource reservationDatasource;

  ReservationRepositoryImpl({
    ReservationDatasource? reservationDatasource
  }) : reservationDatasource = reservationDatasource ?? ReservationDatasourceImpl();
  
  @override
  Future<Reservation> createUpdateReservation( String name, String rut, String email, String reservationDate, String reservationTime, String serviceName ) {
    return reservationDatasource.createUpdateReservation( name, rut, email, reservationDate, reservationTime, serviceName );
  }
  
  @override
  Future<void> deleteReservation(String id) {
    return reservationDatasource.deleteReservation(id);
  }
  
  @override
  Future<Reservation> getReservationById(String id) {
    return reservationDatasource.getReservationById(id);
  }
  
  @override
  Future<List<Reservation>> getReservations() {
    return reservationDatasource.getReservations(); 
  }


 
}
