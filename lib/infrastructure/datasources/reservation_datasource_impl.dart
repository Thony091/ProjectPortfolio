
import 'package:dio/dio.dart';
import 'package:portafolio_project/infrastructure/infrastructure.dart';

import '../../config/config.dart';
import '../../domain/domain.dart';

class ReservationDatasourceImpl extends ReservationDatasource {

  late final Dio dio;
  // final String accessToken;

  ReservationDatasourceImpl(
    // required this.accessToken
  ) : dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.baseUrl,
      headers: {
        // 'Authorization': 'Bearer $accessToken'
      }
    )
  );

  @override
  Future<Reservation> createUpdateReservation( 
    String name, String rut, String email, String reservationDate, String reservationTime, String serviceName ) async {
    
      try {

        final data = {
          'name': name,
          'rut': rut,
          'email': email,
          'reservationDate': reservationDate,
          'reservationTime': reservationTime,
          'serviceName': serviceName,
        };
        final response = await dio.post( '/reservation', data: data );

        final reserva = ReservationMapper.jsonToEntity( response.data );

        return reserva;

      } catch (e) {
        throw Exception('Error al crear la reserva');
      }

  }

  @override
  Future<void> deleteReservation(String id) {
    // TODO: implement deleteReservation
    throw UnimplementedError();
  }

  @override
  Future<Reservation> getReservationById(String id) {
    // TODO: implement getReservationById
    throw UnimplementedError();
  }

  @override
  Future<List<Reservation>> getReservations() {
    // TODO: implement getReservations
    throw UnimplementedError();
  }

}