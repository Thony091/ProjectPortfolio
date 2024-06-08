import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portafolio_project/presentation/pages/admin_pages/component/admin_card_reservation.dart';
import 'package:portafolio_project/presentation/presentation_container.dart';

import '../../../config/config.dart';

class ConfigReservationsPage extends StatelessWidget {
  
  static const name = 'ConfigReservationsPage';

  const ConfigReservationsPage({Key? key});

  @override
  Widget build(BuildContext context) {

    final color = AppTheme().getTheme().colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion de  reservas'),
        backgroundColor: color.primary,
      ),
      body: const BackgroundImageWidget(
        opacity: 0.1,
        child: _ReservationsPage(),
      ),
    );
  }
}

class _ReservationsPage extends ConsumerStatefulWidget {
  const _ReservationsPage();

  @override
  _ReservationsPageState createState() => _ReservationsPageState();
}

class _ReservationsPageState extends ConsumerState<_ReservationsPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read( reservationProvider.notifier ).getReservations();
    });
  }

@override
  Widget build(BuildContext context) {

    final reservationState = ref.watch( reservationProvider );
    
    return Padding(
      padding: const EdgeInsets.only( left: 20, top: 10, bottom: 15),
      child:  ListView.builder(
        itemCount: reservationState.reservations.length,
        itemBuilder: ( context, index) {
          final reservation = reservationState.reservations[index];
          return Column(
            children:
              [
                ReservationsCardService(
                  reservation: reservation,
                  // onTapdEdit: () => context.push('/service-edit/${service.id}'),
                  onTapDelete: () {
                    showDialog(
                      context: context, 
                      builder: (context){
                        return PopUpPreguntaWidget(
                          pregunta: '¿Estas seguro de eliminar el servicio?', 
                          // confirmar: () {},
                          confirmar: () => ref.read(servicesProvider.notifier).deleteService(reservation.id).then((value) => context.pop()), 
                          cancelar: () => context.pop()
                        );
                      }
                    );
                  } 
                ),
                const SizedBox(height: 10),
              ] 
          );
        },        
      ),
    );
  }
}