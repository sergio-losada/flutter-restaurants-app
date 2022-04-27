import 'package:flutter/material.dart';

import '../service/settings_service.dart';

/// Clase del controlador de las preferencias del usuario. En concreto, se
/// monitoriza el tema elegido por el usuario (claro, oscuro o el del sistema)
class SettingsController with ChangeNotifier {

  // Constructor cuyo parametro es una instancia del servicio
  SettingsController(this._settingsService);

  // Instancia de la clase del servicio de las prefernecias del usuario
  final SettingsService _settingsService;

  // Atributo para monitorizar el tema preferido del usuario
  late ThemeMode _themeMode;

  // Inicializacion del atributo que monitoriza el tema preferido del usuario
  ThemeMode get themeMode => _themeMode;

  /// Cargar los ajustes a traves del servicio
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();

    // Notificar a los listeners para actualizar el tema
    notifyListeners();
  }

  /// Actualizacion y persistencia del tema preferido
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;

    // Actualizacion del nuevo tema preferido
    _themeMode = newThemeMode;

    // Notificar a los listeners para actualizar el tema
    notifyListeners();

    // Persistencia del nuevo tema preferido a traves del servicio
    await _settingsService.updateThemeMode(newThemeMode);
  }

}
