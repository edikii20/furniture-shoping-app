import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:furniture_shoping_app/domain/hive_db/data_provider/box_manager.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/user.dart';
import 'package:furniture_shoping_app/error_screens/navigation_error_page_widget.dart';
import 'package:furniture_shoping_app/main_screens/cart_page/ui/congrats_page_widget.dart';
import 'package:furniture_shoping_app/main_screens/page_picker/ui/page_picker_widget.dart';
import 'package:furniture_shoping_app/main_screens/product_detail_page/ui/product_detail_page_widget.dart';
import 'package:furniture_shoping_app/main_screens/profile_page/profile_page_rows/orders_page/orders_page_widget.dart';
import 'package:furniture_shoping_app/main_screens/profile_page/profile_page_rows/payment_method_page/payment_method_page_widget.dart';
import 'package:furniture_shoping_app/main_screens/profile_page/profile_page_rows/shipping_address_page/add%20_shipping_address_page_widget.dart';
import 'package:furniture_shoping_app/main_screens/profile_page/profile_page_rows/shipping_address_page/shipping_address_page_widget.dart';
import 'package:furniture_shoping_app/start_screens/autorization_page/bloc/authorization_bloc.dart';
import 'package:furniture_shoping_app/start_screens/boarding_page_widget.dart';
import 'package:furniture_shoping_app/start_screens/autorization_page/ui/autorization_page_widget.dart';
import 'package:furniture_shoping_app/start_screens/loader_page/loader_page_widget.dart';
import 'package:furniture_shoping_app/start_screens/registration_page/ui/registration_page_widget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'domain/repositories/authorization_repository.dart';
import 'start_screens/registration_page/bloc/registration_bloc.dart';

// await Hive.deleteBoxFromDisk('home_catalog');
// await Hive.deleteBoxFromDisk('home_categories');
// await Hive.deleteBoxFromDisk('favorites');
// print(Hive.isAdapterRegistered(0));
// print(Hive.isAdapterRegistered(1));
// print(Hive.isAdapterRegistered(2));
// print(Hive.isAdapterRegistered(3));

// final box = await BoxManager.instance.openUsersBox();
//   await box.add(User(
//       id: 0,
//       name: 'Eduard',
//       email: 'edikii20@mail.ru',
//       password: 'jhNF8u47LH',
//       image: 'image'));

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture Shoping App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(const Color(0xFF303030)),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        tabBarTheme: const TabBarTheme(
          labelStyle: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          labelColor: Color(0xFF242424),
          unselectedLabelColor: Color(0xFF999999),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF242424),
          unselectedItemColor: Color(0xFF999999),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 20,
        ),
      ),
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                RepositoryProvider(
              create: (context) => AuthorisationRepository(),
              lazy: false,
              child: const LoaderPageWidget(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 100),
          );
        } else if (settings.name == "/boarding") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const BoardingPageWidget(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 100),
          );
        } else if (settings.name == "/login") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                BlocProvider(
              create: (_) => AuthorizationBloc(),
              lazy: false,
              child: const AutorizationPageWidget(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 100),
          );
        } else if (settings.name == "/signup") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                BlocProvider(
              create: (_) => RegistrationBloc(),
              lazy: false,
              child: const RegistrationPageWidget(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 100),
          );
        } else if (settings.name == "/page_picker") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const PagePickerWidget(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final tween =
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          );
        } else if (settings.name == "/product_detail") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ProductDetailPageWidget(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 350),
          );
        } else if (settings.name == "/profile/orders") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OrdersPageWidget(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final tween =
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          );
        } else if (settings.name == "/profile/shipping_address") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ShippingAddressPageWidget(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final tween =
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          );
        } else if (settings.name ==
            "/profile/shipping_address/add_shipping_address") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AddShipingAddressPageWidget(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final tween = Tween(begin: 0.0, end: 1.0);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              );

              return ScaleTransition(
                scale: tween.animate(curvedAnimation),
                alignment: const Alignment(0.8, 0.9),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          );
        } else if (settings.name == "cart/check_out/congrats") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CongratsPageWidget(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final tween =
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          );
        } else if (settings.name == "/profile/payment_method") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const PaymentMethodPageWidget(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final tween =
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          );
        } else if (settings.name ==
            "/profile/payment_method/add_payment_method") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AddShipingAddressPageWidget(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final tween = Tween(begin: 0.0, end: 1.0);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              );

              return ScaleTransition(
                scale: tween.animate(curvedAnimation),
                alignment: const Alignment(0.8, 0.9),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          );
        } else {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const NavigationErrorPageWidget(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 100),
          );
        }
      },
      initialRoute: '/',
    );
  }
}
