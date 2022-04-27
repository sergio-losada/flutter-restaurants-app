import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controller/settings_controller.dart';

/// Intefaz de la ventana de ajustes del usuario 
class SettingsView extends StatelessWidget {

  /// Constructor que requiere una instancia del controlador para actualizar la vista
  const SettingsView({
    Key? key,
    required this.controller
  }) : super(key: key);

  // Nombre de la ruta
  static const routeName = '/settings';

  // Instancia del controlador
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 75,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Boton para cambiar al tema claro
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // MediaQuery devuelve el ancho de la pantalla, tanto portrait como landscape
                      minimumSize: Size(MediaQuery.of(context).size.width - 64, 55),
                      maximumSize: Size(MediaQuery.of(context).size.width - 64, 55)),
                    onPressed: () {
                      // El controlador actualiza la aplicacion al tema claro
                      controller.updateThemeMode(ThemeMode.light);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.light_mode),
                        Text(" " + AppLocalizations.of(context)!.lightTheme)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 75,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Boton para cambiar al tema oscuro
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // MediaQuery devuelve el ancho de la pantalla, tanto portrait como landscape
                      minimumSize: Size(MediaQuery.of(context).size.width - 64, 55),
                      maximumSize: Size(MediaQuery.of(context).size.width - 64, 55)),
                    onPressed: () {
                      // El controlador actualiza la aplicacion al tema oscuro
                      controller.updateThemeMode(ThemeMode.dark);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.dark_mode),
                        Text(" " + AppLocalizations.of(context)!.darkTheme)
                      ],
                    ),
                  ),
                ],
              )
            ),
            SizedBox(
              height: 75,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Boton para cambiar al tema del sistema
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // MediaQuery devuelve el ancho de la pantalla, tanto portrait como landscape
                      minimumSize: Size(MediaQuery.of(context).size.width - 64, 55),
                      maximumSize: Size(MediaQuery.of(context).size.width - 64, 55)),
                    onPressed: () {
                      // El controlador actualiza la aplicacion al tema del sistema
                      controller.updateThemeMode(ThemeMode.system);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.system_update),
                        Text(" " + AppLocalizations.of(context)!.systemTheme)
                      ]
                    ),
                  ),
                ],
              )
            ),
          ],
        )
      ),
    );
  }

}
