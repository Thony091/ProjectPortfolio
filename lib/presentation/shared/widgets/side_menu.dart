import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../presentation_container.dart';

class SideMenu extends ConsumerStatefulWidget {
  
  final GlobalKey<ScaffoldState> scaffoldKey;
  
  const SideMenu({
    super.key,
    required this.scaffoldKey,
    });

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {


  int navDrawerIndex = 0;
  final color = AppTheme().getTheme().colorScheme;
  final bool inicioSesion = false;
  
  @override
  Widget build(BuildContext context) {
    
    final authStatus = ref.read( authProvider ).authStatus;
    
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
      },
        
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: color.primary,
            ),
            child: const Text(
              'AR Detailing', 
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                
              )
              
            ),
          ),



          //* Iniciar Sesion
          if  ( authStatus != AuthStatus.authenticated ) 
            ListTile(
              leading: const Icon(
                size: 33,
                Icons.person,
                color: Color(0xff4981be),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Colors.black54,
              ),
              title: const Text(
                'Inicio Sesion',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 18
                ),
              ),
              onTap: () {
                context.push('/login');
              },
            ),

          //* Home
            ListTile(
              leading: const Icon(
                size: 33,
                Icons.home_outlined,
                color: Color(0xff4981be),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Colors.black54,
              ),
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 18
                ),
              ),
              onTap: () {
                context.push('/');
              },
            ),
            

          //* Servicios
          ListTile(
            leading: const Icon(
              size: 33,
              Icons.car_repair,
              color: Color(0xff4981be),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.black54,
            ),
            title: const Text(
              'Servicios',
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontSize: 18
              ),
            ),
            onTap: () {
              context.push('/services');
              // context.push('/services');
            },
          ),

          //* Agenda tu hora
          ListTile(
            leading: const Icon(
              size: 33,
              Icons.calendar_month_outlined,
              // FontAwesomeIcons.calendarAlt,
              color: Color(0xff4981be),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.black54,
            ),
            title: const Text(
              'Agenda tu hora',
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontSize: 18
              ),
            ),
            onTap: () {
              context.push('/reservations');
            },
          ),

          //* Nuestros Trabajos
          ListTile(
            leading: const Icon(
              size: 33,
              Icons.diamond_outlined,
              color: Color(0xff4981be),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.black54,
            ),
            title: const Text(
              'Nuestros trabajos',
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontSize: 18
              ),
            ),
            onTap: () {
              context.push('/our-works');
            },
          ),

          // //* Products
          // ListTile(
          //   leading: const Icon(
          //     size: 33,
          //     Icons.help,
          //     color: Color(0xff4981be),
          //   ),
          //   title: const Text(
          //     'Productos',
          //     style: TextStyle(
          //       color: Colors.black54,
          //       fontFamily: 'Montserrat',
          //       fontWeight: FontWeight.w400,
          //       fontSize: 17
          //     ),
          //   ),
          //   trailing: const Icon(
          //     Icons.arrow_forward_ios_rounded,
          //     size: 15,
          //     color: Colors.black54,
          //   ),
          //   onTap: (){
          //     context.push('/products');
          //   },
          // ),

          //* Cerrar Sesión
          if  ( authStatus == AuthStatus.authenticated )
             ListTile(
              leading: const Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.signOut,
                color: Color(0xff4981be),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Colors.black54,
              ),
              title: const Text(
                'Salir',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 18
                ),
              ),
              onTap: () {
                ref.read( authProvider.notifier ).logOut().then( (_) => context.push('/'));
                // context.push('/');
              },
            ),
          

            // const Divider(
            //   color: Colors.black12,
            // ),

          const SizedBox(height: 50,),

          Row( 
            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[


            if  ( authStatus == AuthStatus.authenticated )  
              //* Configuración
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xfff2f2f2)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                ),
                icon: const Icon(
                  Icons.settings,
                  size: 29, 
                  color: Color(0xff4981be),
                ),
                label: const Text(
                  'Configuración',
                  style: TextStyle(color: Colors.red, fontSize: 15),
                ),
                onPressed: () async {
                  context.push('/profile-user');
                },
              ),

              // //* Carro de Compra
              // TextButton.icon(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(const Color(0xfff2f2f2)),
              //     padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              //   ),
              //   icon: const Icon(
              //     Icons.shopping_cart_checkout_rounded,
              //     size: 29, 
              //     color: Color(0xff4981be),
              //   ),
              //   label: const Text(
              //     'Carro de Compra',
              //     style: TextStyle(color: Colors.red, fontSize: 15),
              //   ),
              //   onPressed: () async {
              //     context.push('/shoping-cart');
              //   },
              // ),


              if ( authStatus != AuthStatus.authenticated )
              //* REGISTRAR
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xfff2f2f2)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                ),
                icon: const Icon(
                  Icons.person_add,
                  size: 29, 
                  color: Color(0xff4981be),
                ),
                label: const Text(
                  'Registrar',
                  style: TextStyle(color: Colors.red, fontSize: 15),
                ),
                onPressed: () async {
                  context.push('/register');
                },
              ),
            ]
          ),
        ],
      
    );
  }
}
