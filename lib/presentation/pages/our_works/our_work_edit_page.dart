import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../domain/domain.dart';
import '../../presentation_container.dart';
import '../../providers/forms/work_form_provider.dart';
import '../../shared/widgets/custom_product_field.dart';

class OurWorkEditPage extends ConsumerWidget{

  final String workId;
  static const String name = 'OurWorkEditPage';

  const OurWorkEditPage({super.key, required this.workId});

  void showSnackbar( BuildContext context ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Trabajo Actualizado'))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final workState = ref.watch( workProvider( workId ) );
    final color = AppTheme().getTheme().colorScheme;
    
    return GestureDetector(
      onTap: () => FocusScope.of( context ).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text( workState.work?.name ?? ' Cargando...'),
          backgroundColor: color.primary,
          actions: [
            IconButton(onPressed: () async {
              final photoPath = await CameraGalleryServiceImpl().selectPhoto();
              if ( photoPath == null ) return;

              ref.read( workFormProvider(workState.work!).notifier )
                .updateWorkImage(photoPath);
    
            }, 
            icon: const Icon( Icons.photo_library_outlined )),

            IconButton(onPressed: () async{
              final photoPath = await CameraGalleryServiceImpl().takePhoto();
              if ( photoPath == null ) return;

              ref.read( workFormProvider( workState.work!).notifier )
                .updateWorkImage(photoPath);
            }, 
            icon: const Icon( Icons.camera_alt_outlined ))
          ],
        ),
        body: workState.isLoading
          ? const FullScreenLoader()
          : _WorkDetailBodyPage( work: workState.work! ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text( 'Guardar' ),
          icon: const Icon( Icons.save_outlined, ),
          onPressed: () {
            if ( workState.work == null) return;
            ref.read(
              workFormProvider( workState.work! ).notifier
            ).onFormSubmit()
            .then((value) {
              if ( !value ) return;
              showSnackbar(context);
              context.pushReplacement('/');
            });
          },
        )
      )
    );
  }
}

class _WorkDetailBodyPage extends ConsumerWidget {

  final Works work;

  const _WorkDetailBodyPage({ required this.work });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final workForm = ref.watch( workFormProvider( work ) );
    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [

        SizedBox(
          height: 250,
          width: 600,
          child: CustomImageGallery(image: workForm.image),
        ),

        const SizedBox( height: 20 ),

        Center( child: Text( workForm.name.value, style: textStyles.titleSmall )),

        const SizedBox( height: 20 ),

        _WorkInformation(work: work),

      ],
    );
  }
}


class _WorkInformation extends ConsumerWidget {

  final Works work;
  
  const _WorkInformation({required this.work});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final workForm = ref.watch( workFormProvider( work ) );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15 ),
          CustomProductField(
            isTopField: true,
            label: 'Nombre',
            initialValue: workForm.name.value,
            onChanged: ref.read( workFormProvider( work ).notifier ).onNameChange,
            errorMessage: workForm.name.errorMessage,
          ),

          const SizedBox(height: 15 ),

          CustomProductField(
            maxLines: 6,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: workForm.description.value,
            onChanged: ref.read( workFormProvider( work ).notifier ).onDescriptionChange,
            errorMessage: workForm.description.errorMessage,
          ),


          const SizedBox(height: 30 ),
        ],
      ),
    );
  }
}
