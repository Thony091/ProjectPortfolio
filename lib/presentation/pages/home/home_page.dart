import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portafolio_project/presentation/pages/home/components/body_home.dart';

import '../../../config/theme/theme.dart';
import '../../presentation_container.dart';

class HomePage extends ConsumerStatefulWidget {

  static const name = 'HomePage';

  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage>{
  @override
  Widget build(BuildContext context ) {

    final authStatusProvider  = ref.watch( authProvider );
    final scaffoldKey         = GlobalKey<ScaffoldState>();
    final text                = AppTheme().getTheme().textTheme;

    return  SafeArea(
      bottom: false,
      child: Scaffold(
        drawer:  SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: Text( (authStatusProvider.authStatus == AuthStatus.authenticated)
            ? 'Hola ${authStatusProvider.userData!.nombre}'
            : 'Hola Invitado',
            style: text.titleLarge,
          ),
          elevation: 4.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppTheme.goldGradientColors,
                stops: AppTheme.goldGradientStops,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            )
          ),
        ),
        body: const BackgroundImageWidget(
          opacity: 0.1,
          child: HomeBody()
        ),
      
      ),
    );
  }
}
