
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portafolio_project/infrastructure/infrastructure.dart';

import '../../domain/domain.dart';


final reservationProvider = StateNotifierProvider<ReservationNotifier, ReservartionState>((ref) {

  final reservationRepository = ReservationRepositoryImpl();

  return ReservationNotifier(
    reservationRepository: reservationRepository
  );
});

class ReservationNotifier extends StateNotifier<ReservartionState>{

  final ReservationRepository reservationRepository;

  ReservationNotifier({
    required this.reservationRepository
  }) : super(ReservartionState()){
    getReservations();
  }
  
  Future<void> getReservations() async {
    
    state = state.copyWith(isLoading: true);

    try {
      
      final reservations = await reservationRepository.getReservations();
      
      state = state.copyWith(
        reservations: reservations,
        isLoading: false
      );

    } catch (e) {
      
      state = state.copyWith(
        isLoading: false,
        error: 'Error al obtener las reservas'
      );

    }
  }

  Future<void> createReservation( 
      String name, String rut, String email, String reservationDate, String reservationTime, String serviceName
    ) async {
    
    state = state.copyWith(isLoading: true);

    try {
      
      final reservation = await reservationRepository.createUpdateReservation( 
        name, rut, email, reservationDate, reservationTime, serviceName );
      
      state = state.copyWith(
        reservations: [...state.reservations, reservation],
        isLoading: false
      );

    } catch (e) {
      
      state = state.copyWith(
        isLoading: false,
        error: 'Error al crear la reserva'
      );

    }
  }


}

class ReservartionState {

  final List<Reservation> reservations;
  final bool isLoading;
  final String error;

  ReservartionState({
    this.reservations = const [],
    this.isLoading = false,
    this.error = ''
  });

  ReservartionState copyWith({
    List<Reservation>? reservations,
    bool? isLoading,
    String? error
  }) => ReservartionState(
    reservations: reservations ?? this.reservations,
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error
  );

}