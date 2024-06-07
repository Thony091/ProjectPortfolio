import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portafolio_project/presentation/shared/widgets/custom_product_field.dart';


import '../../../config/config.dart';
import '../../presentation_container.dart';


//*TODO Revisar la implementación de la página de reservas*****

class ReservationsPage extends StatelessWidget {

  static const name = 'ReservationsPage';
  
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {

    // final scaffoldKey = GlobalKey<ScaffoldState>();
    final color = AppTheme().getTheme().colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservations Page"),
        backgroundColor: color.primary,
      ),
      body: const BackgroundImageWidget(
        opacity: 0.1,
        child: Center(
          child: _ReservationFormBody(),
        ),
      ),
      // drawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class _ReservationFormBody extends ConsumerWidget {

  const _ReservationFormBody();


  Future<void> _selectDate( BuildContext context, WidgetRef ref ) async {
    DateTime now = DateTime.now();
    // Asegurarnos de que la fecha inicial sea un día de lunes a sábado
    DateTime initialDate = now;
    while (initialDate.weekday == DateTime.sunday) {
      initialDate = initialDate.add(const Duration(days: 1));
    }
    DateTime firstDate = DateTime(now.year, now.month, now.day);
    DateTime lastDate = DateTime(now.year + 1, now.month, now.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDayPredicate: (day) {
        return day.weekday != DateTime.sunday;
      },
    );

    if ( pickedDate != null ) {
      ref.read(reservationFormProvider.notifier).onReservationDate(pickedDate);
    }
  }
  Future<void> _selectTime( BuildContext context, WidgetRef ref ) async {
    final state = ref.read(reservationFormProvider);
    final List<String> timeOptions = state.timeOptions;

    if ( timeOptions.isEmpty ) return;

        final String? pickedTime = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: timeOptions.map((time) {
            return ListTile(
              title: Text(time),
              onTap: () {
                Navigator.of(context).pop(time);
              },
            );
          }).toList(),
        );
      },
    );


    if (pickedTime != null) {
      final TimeOfDay parsedTime = TimeOfDay(
        hour: int.parse(pickedTime.split(':')[0]),
        minute: int.parse(pickedTime.split(':')[1]),
      );
      ref.read(reservationFormProvider.notifier).onReservationTime(parsedTime);
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    List<String> opciones = ['Opción 1', 'Opción 2', 'Opción 3'];
    final size = MediaQuery.of(context).size;
    final state = ref.watch(reservationFormProvider);

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag ,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0
        ), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Haz tu Reserva", 
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              )
            ),
      
            CustomProductField(
              isBottomField: true,
              isTopField: true,
              label: "Name",
              hint: "Nombre Completo",
              onChanged: (value) {
                ref.read( reservationFormProvider.notifier ).onNameChange(value);
              },
            ),
            const SizedBox(height: 10.0),
      
            CustomProductField(
              isBottomField: true,
              isTopField: true,
              label: "Rut",
              hint: "Rut",
              onChanged: (value) {
                ref.read( reservationFormProvider.notifier ).onRutChange(value);
              },
            ),
            const SizedBox(height: 10.0),
      
            CustomProductField(
              isBottomField: true,
              isTopField: true,
              label: "Correo Electrónico",
              hint: "Correo Electrónico",
              onChanged: (value) {
                ref.read( reservationFormProvider.notifier ).onEmailChange(value);
              },
            ),
            const SizedBox(height: 10.0),
      
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 60.0,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text('Elije una opción'),
                  value: state.serviceName.isNotEmpty
                      ? state.serviceName
                      : null,
                  items: opciones.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    ref
                        .read(reservationFormProvider.notifier)
                        .onServiceNameChange(value!);
                  },
                ),
              ),
            ), 
            const SizedBox(height: 10.0),
            if ( state.serviceName.isNotEmpty )
              CustomProductField(
                isBottomField: true,
                isTopField: true,
                label: "Fecha de Reserva",
                // initialValue: state.date.value,
                hint: state.date.value,
                onTap: () {
                  if (state.serviceName.isNotEmpty) {
                    _selectDate(context, ref);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Primero selecciona el tipo de servicio'))
                    );
                  }
                },
                readOnly: true,
              ),

              const SizedBox(height: 10.0),

              CustomProductField(
                isBottomField: true,
                isTopField: true,
                label: "Hora",
                initialValue: state.time.value,
                hint: state.time.value,
                onTap: () {
                  if (state.date.value.isNotEmpty) {
                    _selectTime(context, ref);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Primero selecciona una fecha'))
                    );
                  }
                },
                readOnly: true,
              ),
      
            const SizedBox(height: 10.0),

      
            // SizedBox(
            //   width: double.infinity,
            //   height: 80.0 ,
            //   child: DropdownButton<String>(
            //     hint: const Text("Seleccione una opción"), // Opcional: texto de sugerencia
            //     items: opciones.map((String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(value), // Muestra el texto de la opción
            //             Icon(Icons.arrow_forward_ios, size: 24, color: Colors.grey[700]), // Flecha para indicar más opciones
            //           ],
            //         ),
            //       );
            //     }).toList(),
            //     onChanged: (String? newValue) {
            //       // Acción a realizar cuando se selecciona una opción
            //       print(newValue);
            //     },
            //   )
            // ),
            
            const SizedBox(height: 20.0),
            CustomFilledButton(
              height: 65.0,
              width: size.width * 0.8,
              text: "Reservar",
              fontSize: 22.0,
              shadowColor: Colors.white,
              spreadRadius: 4,
              blurRadius: 3,
              radius: const Radius.circular(30),
              iconSeparatorWidth: 70,
              icon: Icons.calendar_month_outlined,
              buttonColor: Colors.blueAccent.shade400,

              onPressed: () {
                ref.read(reservationFormProvider.notifier).createReservation().then(
                  (value) {
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Reserva realizada con éxito"),
                          backgroundColor: Colors.green,
                        )
                      );
                      context.push('/reservations');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text( 
                            state.date.errorMessage != null 
                              ? state.date.errorMessage.toString()
                              : ( state.time.errorMessage != null ) 
                                ? state.time.errorMessage.toString()
                                : ( state.name.errorMessage != null ) 
                                  ? state.name.errorMessage.toString()
                                  : ( state.email.errorMessage != null ) 
                                    ? state.email.errorMessage.toString()
                                    : ( state.rut.errorMessage != null ) 
                                      ? state.rut.errorMessage.toString()
                                      : "Error al realizar la reserva"
                          ),
                          backgroundColor: Colors.red,
                        )
                      );
                    }
                  
                  }
                );
                // ref.read(goRouterProvider).go('/reservations');
              },
            ),
            const SizedBox(height: 20.0),
            if (state.isPosting)
              const CircularProgressIndicator(),
            const SizedBox(height: 20.0),
          ]
        )
      ),
    );
  }
}


