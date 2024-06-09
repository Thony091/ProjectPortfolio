import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../presentation_container.dart';
import 'components/work_card.dart';
import 'components/work_user_card.dart';

class OurWorksPage extends ConsumerWidget {
  static const String name = 'OurWorksPage';
  const OurWorksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final color = AppTheme().getTheme().colorScheme;
    final authState   = ref.watch( authProvider );
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: AppBar(
        title: Text( authState.authStatus != AuthStatus.authenticated
          ? "Nuestros Trabajos" 
          :( !authState.userData!.isAdmin )
            ? "Nuestros Trabajos" 
            : "Trabajos disponibles"
        ),
        backgroundColor: color.primary,
      ),
      body:  BackgroundImageWidget(
        opacity: 0.1, 
        child: ( authState.authStatus != AuthStatus.authenticated)
          ? const _OurWorksBodyPage()
          : ( authState.userData!.isAdmin )
            ? const _OurWorksAdminBodyPage()
            : const _OurWorksBodyPage(),
      ),
      floatingActionButton: ( authState.authStatus != AuthStatus.authenticated)
        ? null 
        : ( authState.userData!.isAdmin ) 
          ? 
            FloatingActionButton.extended(
              label: const Text('Crear Trabajo'),
              icon: const Icon( Icons.add ),
              onPressed: () {
                context.pushReplacement('/work/new');
              },
            )
          : null,
      drawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class _OurWorksBodyPage extends ConsumerWidget {

  const _OurWorksBodyPage();

  initState(WidgetRef ref){
    ref.read(worksProvider.notifier).getWorks();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final worksState = ref.watch( worksProvider );

    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 10 ),
      child: MasonryGridView.count(
        crossAxisCount: 1, 
        mainAxisSpacing: 20,
        itemCount: worksState.works.length,
        itemBuilder: (context, index) {
          final work = worksState.works[index];
          return GestureDetector(
            onTap: (){},
            child: WorkUserCard( 
              work: work 
              
            )
          );
        },
      ),
    );
  }
}


//* Vista de los Trabajos para el administrador
class _OurWorksAdminBodyPage extends ConsumerStatefulWidget {
  const _OurWorksAdminBodyPage();

  @override
  _OurWorksAdminBodyPageState createState() => _OurWorksAdminBodyPageState();
}

class _OurWorksAdminBodyPageState extends ConsumerState {


  @override
  Widget build(BuildContext context) {

    final worksState = ref.watch( worksProvider );
    
    return Padding(
      padding: const EdgeInsets.only( left: 20, top: 10),
      child:  ListView.builder(
        itemCount: worksState.works.length,
        itemBuilder: ( context, index) {
          final work = worksState.works[index];
          return Column(
            children:
              [
                WorkCard( 
                  work: work,
                  onTapdEdit: () => context.push('/work-edit/${work.id}'),
                  onTapDelete: () {
                    showDialog(
                      context: context, 
                      builder: (context){
                        return PopUpPreguntaWidget(
                          pregunta: '¿Estas seguro de eliminar el Trabajo?', 
                          // confirmar: () {},
                          confirmar: () => ref.read( worksProvider.notifier ).deleteWork(work.id).then((value) => context.pop()), 
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