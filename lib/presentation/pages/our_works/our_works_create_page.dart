import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';
import '../../../domain/domain.dart';
import '../../presentation_container.dart';
import '../../shared/widgets/custom_product_field.dart';

class WorkCreatePage extends ConsumerWidget{

  final String workId;
  static const String name = 'WorkCreatePage';

  const WorkCreatePage({super.key, required this.workId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final authState = ref.watch( authProvider );
    final workState = ref.watch( workProvider( workId ) );
    final color = AppTheme().getTheme().colorScheme;
    
    return GestureDetector(
      onTap: () => FocusScope.of( context ).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text( workState.work?.name ?? ' Cargando...'),
          backgroundColor: color.primary,
        ),
        body: workState.isLoading
          ? const FullScreenLoader()
          : _WorkDetailBodyPage( work: workState.work! ),
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

class _WorkDetailBodyPage extends ConsumerWidget {

  final Works work;

  const _WorkDetailBodyPage({ required this.work });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [

        SizedBox(
          height: 250,
          width: 600,
          child: CustomImageGallery(image: work.image),
        ),

        const SizedBox( height: 20 ),

        Center( child: Text( work.name, style: textStyles.titleSmall )),

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
            initialValue: work.name,
          ),

          const SizedBox(height: 15 ),

          CustomProductField( 
            readOnly: true,
            maxLines: 6,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: work.description,
          ),


          const SizedBox(height: 30 ),
        ],
      ),
    );
  }
}
