

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/our_works/our_works_container.dart';
import '../../presentation/presentation_container.dart';
import 'router.dart';


final goRouterProvider = Provider( (ref) {

  final goRouterNotifier = ref.read( goRouterNotifierProvider );

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: 
      [
        GoRoute(
          path: '/splash', 
          name: CheckAuthStatusScreen.name, 
          builder: (context, state) => const CheckAuthStatusScreen()
        ),
        //* Home
        GoRoute(
          path: '/',
          name: HomePage.name,
          builder: (context, state) => const HomePage(),
        ),

        //* Login
        GoRoute(
          path: '/login',
          name: LoginPage.name,
          builder: (context, state) => const LoginPage(),
        ),

        //* Register
        GoRoute(
          path: '/register',
          name: RegisterPage.name,
          builder: (context, state) => const RegisterPage(),
        ),

        //* Pago
        GoRoute(
          path: '/pago',
          name: PagoPage.name,
          builder: (context, state) => const PagoPage(),
        ),

        //* Products
        GoRoute(
          path: '/products',
          name: ProductsPage.name,
          builder: (context, state) => const ProductsPage(),
        ),
          // routes: 
          //   [
              //* Product Detail
        GoRoute(
          path: '/product/:id',
          name: ProductDetailPage.name,
          builder: (context, state) => ProductDetailPage(
            productId: state.params['id'] ?? 'no-id'
          ),
        ),
          //   ],

        //* Reservations
        GoRoute(
          path: '/reservations',
          name: ReservationsPage.name,
          builder: (context, state) => const ReservationsPage(),
        ),

        //* Services
        GoRoute(
          path: '/services',
          name: ServicesPage.name,
          builder: (context, state) => const ServicesPage(),
        ),
        //* Service Detail
        GoRoute(
          path: '/service/:id',
          name: ServiceDetailPage.name,
          builder: (context, state) => ServiceDetailPage(
            serviceId: state.params['id'] ?? 'no-id'
          ),
        ),
        //* Service Edit
        GoRoute(
          path: '/service-edit/:id',
          name: ServiceEditPage.name,
          builder: (context, state) => ServiceEditPage(
            serviceId: state.params['id'] ?? 'no-id'
          ),
        ),

        //* Profile
        GoRoute(
          path: '/profile-user',
          name: ProfileUserPage.name,
          builder: (context, state) => const ProfileUserPage(),
        ),
        //* Edit Profile
        GoRoute(
          path: '/edit-user-profile',
          name: EditUserProfilePage.name,
          builder: (context, state) => const EditUserProfilePage(),
        ),

        //* Shoping Cart
        GoRoute(
          path: '/shoping-cart',
          name: ShopingCartPage.name,
          builder: (context, state) => const ShopingCartPage(),
        ),

        //* Our Works
        GoRoute(
          path: '/our-works',
          name: OurWorksPage.name,
          builder: (context, state) => const OurWorksPage(),
        ),
        //* Work Edit
        GoRoute(
          path: '/work-edit/:id',
          name: OurWorkEditPage.name,
          builder: (context, state) => OurWorkEditPage(
            workId: state.params['id'] ?? 'no-id'
          ),
        ),

        //* AdminZone
        //* ConfigMessagesPage
        GoRoute(
          path: '/messages',
          name:  MessagesPage.name,
          builder: (context, state) => const MessagesPage(),
        ),
        //* ConfigMessagesResponsePage
        GoRoute(
          path: '/messages',
          name:  MessageResponsePage.name,
          builder: (context, state) =>  MessageResponsePage(
            messageId: state.params['id'] ?? 'no-id'
          ),
        ),

        //* ConfigServicesPage
        GoRoute(
          path: '/admin-config-services',
          name: ConfigServicesPage.name,
          builder: (context, state) => const ConfigServicesPage(),
        ),
        
        //* ConfigWorksPage
        GoRoute(
          path: '/admin-config-works',
          name: ConfigWorksPage.name,
          builder: (context, state) => const ConfigWorksPage(),
        ),

        //* ContactTicketsPage
        GoRoute(
          path: '/admin-contact-tickets',
          name: ContactTicketsPage.name,
          builder: (context, state) => const ContactTicketsPage(),
        ),

        //* ReservaionPage
        GoRoute(
          path: '/reservas-config',
          name: ConfigReservationsPage.name,
          builder: (context, state) => const ConfigReservationsPage(),
        ),


        
      ],

    redirect: (context, state) {

      final isGoingTo = state.subloc;
      final authStatus = goRouterNotifier.authStatus;

      if ( isGoingTo == '/splash' && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/services' || isGoingTo == '/service/:id' || isGoingTo == '/our-works' || isGoingTo == '/reservations' ) return null;

        return '/';
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash' ){
          return '/';
        }
      }

      return null;
    }
  );
});