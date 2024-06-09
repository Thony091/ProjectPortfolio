import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';
import '../../../domain/domain.dart';
import '../../presentation_container.dart';
import '../../shared/widgets/custom_product_field.dart';

class ServiceCreatePage extends ConsumerWidget{

  final String serviceId;
  static const String name = 'ServiceCreatePage';

  const ServiceCreatePage({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final authState = ref.watch( authProvider );
    final serviceState = ref.watch( serviceProvider( serviceId ) );
    final color = AppTheme().getTheme().colorScheme;
    
    return GestureDetector(
      onTap: () => FocusScope.of( context ).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text( serviceState.service?.name ?? ' Cargando...'),
          backgroundColor: color.primary,
        ),
        body: serviceState.isLoading
          ? const FullScreenLoader()
          : _ServiceDetailBodyPage( service: serviceState.service! ),
        floatingActionButton:  ( authState.authStatus != AuthStatus.authenticated)
          ? null 
          : (authState.userData!.isAdmin) 
            ? 
              FloatingActionButton.extended(
                label: const Text('Guardar Servicio'),
                icon: const Icon( Icons.save_as_outlined ),
                onPressed: () {
                  // context.push('/product/new');
                },
              )
            : null,
      )
    );
  }
}

class _ServiceDetailBodyPage extends ConsumerWidget {

  final Services service;

  const _ServiceDetailBodyPage({ required this.service });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [

        SizedBox(
          height: 250,
          width: 600,
          child: CustomImagesGallery(images: service.images),
        ),

        const SizedBox( height: 20 ),

        Center( child: Text( service.name, style: textStyles.titleSmall )),

        const SizedBox( height: 20 ),

        _ServiceInformation(service: service),

      ],
    );
  }
}


class _ServiceInformation extends ConsumerWidget {

  final Services service;
  
  const _ServiceInformation({required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15 ),
          CustomProductField(
            readOnly: true,
            isTopField: true,
            label: 'Nombre',
            initialValue: service.name,
          ),

          CustomProductField( 
            readOnly: true,
            isBottomField: true,
            label: 'Precio',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: 'Entre ${service.minPrice.toString()} - ${service.maxPrice.toString()}',
          ),

          const SizedBox(height: 15 ),


          CustomProductField( 
            readOnly: true,
            maxLines: 6,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: service.description,
          ),


          const SizedBox(height: 30 ),
        ],
      ),
    );
  }
}
