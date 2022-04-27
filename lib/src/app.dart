import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restaurantes_gijon/src/dto/restaurant.dart';
import 'package:restaurantes_gijon/src/view/restaurant_detail_view.dart';
import 'package:restaurantes_gijon/src/view/restaurant_list_view.dart';

import 'controller/settings_controller.dart';
import 'view/settings_view.dart';

/// Widget de configuracion de la aplicacion
class MyApp extends StatelessWidget {
  
  // Constructor que requiere una instancia del controlador y una instancia de Restaurant
  const MyApp({
    Key? key,
    required this.settingsController,
    required this.restaurant,
  }) : super(key: key);

  // Instancia del controlador
  final SettingsController settingsController;

  // Instancia del objeto Restaurant
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    // El Widget AnimatedBuilder escuchara los cambios de tema que le indique el controlador
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Para retomar la navegacion tras reactivar la actividad en background
          restorationScopeId: 'app',

          // Agrega a la aplicacion las AppLocalizations para internacionalizacion (i18n) 
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // Idiomas soportados
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('es', ''), // Spanish, no country code
          ],

          // Titulo de la aplicacion en el Locale correcto
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Definicion de los temas y asignacion del preferido
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Navegacion y manejo de rutas
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case RestaurantDetailView.routeName:
                    return RestaurantDetailView(restaurant: restaurant);
                  case RestaurantListView.routeName:
                  default:
                    return const RestaurantListView();
                }
              },
            );
          },
        );
      },
    );
  }
}
