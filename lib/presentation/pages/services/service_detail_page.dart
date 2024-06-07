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
          actions: serviceState.service?.id != 'new'
            ? null
            : [
            IconButton(onPressed: () async {
              final photoPath = await CameraGalleryServiceImpl().selectPhoto();
              if ( photoPath == null ) return;

              ref.read( serviceFormProvider(serviceState.service!).notifier )
                .updateServiceImage(photoPath);
              }, 
              icon: const Icon( Icons.photo_library_outlined )
            ),

            IconButton(onPressed: () async{
              final photoPath = await CameraGalleryServiceImpl().takePhoto();
              if ( photoPath == null ) return;

              ref.read( serviceFormProvider( serviceState.service!).notifier )
                .updateServiceImage(photoPath);
            }, 
            icon: const Icon( Icons.camera_alt_outlined ))
          ],
        ),
        body: serviceState.isLoading
          ? const FullScreenLoader()
          : _ServiceDetailBodyPage( service: serviceState.service! ),
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

    final serviceForm = ref.watch( serviceFormProvider( service ) );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      
      child: service.id != 'new'
      ? Column(
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
       
      : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15 ),
          CustomProductField(
            isTopField: true,
            label: 'Nombre',
            initialValue: serviceForm.name.value,
            onChanged: ref.read( serviceFormProvider( service ).notifier ).onNameChange,
          ),

          CustomProductField( 
            isTopField: true,
            label: 'Precio Minimo',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: serviceForm.minPrice.value.toString(),
            onChanged: (value) => ref.read( serviceFormProvider( service ).notifier )
              .onMinPriceChange( int.parse(value) ?? -1),
            errorMessage: serviceForm.minPrice.errorMessage,
          ),
          CustomProductField( 
            isBottomField: true,
            label: 'Precio Maximo',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: serviceForm.maxPrice.value.toString(),
            onChanged: (value) => ref.read( serviceFormProvider( service ).notifier )
              .onMaxPriceChange( int.parse(value) ?? -1 ),
            errorMessage: serviceForm.minPrice.errorMessage,
          ),
          const SizedBox(height: 15 ),
          
          CustomProductField(
            maxLines: 6,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: serviceForm.description.value,
            onChanged: ref.read( serviceFormProvider( service ).notifier ).onDescriptionChange,
            hint: 'Descripción del servicio',
          ),

          const SizedBox(height: 30 ),
        ],
      ),
    );
  }
}
