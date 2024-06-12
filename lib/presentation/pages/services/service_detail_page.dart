import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../domain/domain.dart';
import '../../presentation_container.dart';
import '../../shared/widgets/custom_product_field.dart';

class ServiceDetailPage extends ConsumerWidget{

  final String serviceId;
  static const String name = 'ServiceDetailPage';

  const ServiceDetailPage({super.key, required this.serviceId});
    
  void showSnackbar( BuildContext context ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto Actualizado'))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final authState = ref.watch( authProvider );
    final serviceState = ref.watch( serviceProvider( serviceId ) );
    final color = AppTheme().getTheme().colorScheme;
    
    return GestureDetector(
      onTap: () => FocusScope.of( context ).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: serviceState.service?.id != 'new' 
            ? Text( serviceState.service?.name ?? ' Cargando...')
            : const Text( 'Nuevo Servicio'),
          backgroundColor: color.primary,
        ),
        body: serviceState.isLoading
          ? const FullScreenLoader()
          : BackgroundImageWidget(opacity: 0.1, child: _ServiceDetailBodyPage( service: serviceState.service! )),
        floatingActionButton:  ( authState.authStatus != AuthStatus.authenticated)
          ? null 
          : (authState.userData!.isAdmin) 
            ? 
              FloatingActionButton.extended(
                label: const Text('Guardar'),
                icon: const Icon( Icons.save_as_outlined ),
                onPressed: () {
                  if ( serviceState.service == null) return;
                  ref.read(
                    serviceFormProvider( serviceState.service! ).notifier
                  ).onFormSubmit()
                  .then((value) {
                    if ( !value ) return;
                    showSnackbar(context);
                    context.push('/services');
                  });
                },
              )
            : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
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
        const SizedBox( height: 20 ),
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
      )
    );
  }
}
