import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/config.dart';

void main() async {
  
  await Enviroment.initEnvironment();
  
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 100), () => HttpOverrides.global = new MyHttpOverrides());
  
  /// Initialize Firebase
  await FirebaseService.init();

  runApp(
    const ProviderScope(child: MainApp())
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appRouter = ref.watch( goRouterProvider );

    return  MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}