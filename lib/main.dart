import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/config.dart';

void main() async {
  
  await Enviroment.initEnvironment();
  
  WidgetsFlutterBinding.ensureInitialized();
  
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
