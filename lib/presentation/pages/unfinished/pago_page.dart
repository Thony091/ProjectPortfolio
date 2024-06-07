import 'package:flutter/material.dart';

import '../../presentation_container.dart';


class PagoPage extends StatelessWidget {

  static const name = 'pagoPage';
  
  const PagoPage({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pago Page"),),
      body: const BackgroundImageWidget(
        opacity: 0.1,
        child: Center(
          child: _PagoBodyPage(),
        ),
      ),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class _PagoBodyPage extends StatelessWidget {
  const _PagoBodyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Pago Page');
  }
}