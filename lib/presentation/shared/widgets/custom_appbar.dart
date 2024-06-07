import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppbar extends ConsumerStatefulWidget {
  
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppbar({
    super.key,
    required this.scaffoldKey,
  });

  @override
  CustomAppbarState createState() => CustomAppbarState();
}

class CustomAppbarState extends ConsumerState<CustomAppbar> {
  
  int navDrawerIndex = 0;
  
  @override 
  Widget build(BuildContext context) {

  final color = Theme.of(context).colorScheme;
  final titleStyle = Theme.of(context).textTheme.titleMedium; 

    return SafeArea(
      child: Scaffold(
        backgroundColor: color.primary,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xfff2f2f2),
          centerTitle: true,
          title: Text(
            'Cafetería Virtual',
            textAlign: TextAlign.center,
            style: titleStyle?.copyWith(
              color: color.onPrimary,
              fontSize: 22
            ),
          ),
          actions: [
            IconButton(
              iconSize: 160,
              icon: Image.asset(
                'assets/icons/topBar/logoDuoc.png',
                height: 20,
                // color: color.onPrimary,
              ),
              tooltip: 'Cafeteria Virtual',
              onPressed: null,
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  color.primary,
                  color.secondary,
                ],
              ),
            ),
          ),
        ),
        drawer: const _CustomDrawer(),
        
      ),
    );
  }
}

class _CustomDrawer extends StatelessWidget {
  const _CustomDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 2, 13, 230),
            ),
            child: Text(
              'Mi Cafeteria Virtual', 
              style: TextStyle(
                color: Colors.white
              )
            ),
          ),

          //* Historial de compras
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.mugSaucer,
              color: Color(0xff4981be),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.black54,
            ),
            title: const Text(
              'Mis Compras',
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontSize: 18
              ),
            ),
            onTap: () {
              // Navigator.pushNamed(context, CafeteriasScreen.name);
            },
          ),
          //* Cafeterias
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.mugSaucer,
              color: Color(0xff4981be),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.black54,
            ),
            title: const Text(
              'Cafeterias',
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontSize: 18
              ),
            ),
            onTap: () {
              // Navigator.pushNamed(context, CafeteriasScreen.name);
            },
          ),

          const Divider(
            color: Colors.black12,
          ),

          //* CONFIGURACIÓN PERFIL
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Color(0xff4981be),
              size: 26,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.black54,
            ),
            title: const Text(
              'Configuración perfil',
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontSize: 17
              ),
            ),
            onTap: () {
              // Navigator.pushNamed(context, ProfileSettingsScreen.name);
            },
          ),
          const Divider(color: Colors.black12),

          //* SOBRE Cafeteria Virtual
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Color(0xff4981be),
            ),
            title: const Text(
              'Sobre Cafetería Virtual',
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontSize: 17
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.black54,
            ),
            onTap: (){
              // Navigator.pushNamed(context, AboutScreen.name);
            },
          ),
          const Divider(
            color: Colors.black54,
            height: 0,
          ),
          //* CERRAR SESIÓN
          TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xfff2f2f2)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            ),
            icon: const Icon(
              Icons.exit_to_app_rounded,
              size: 29, 
              color: Colors.red
            ),
            label: const Text(
              'Cerrar Sesión',
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
            onPressed: () async {
              // await _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
