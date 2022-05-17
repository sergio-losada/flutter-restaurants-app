import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/settings_repository.dart';

/// Clase del servicio de las preferencias del usuario. En concreto, se
/// monitoriza el tema elegido por el usuario (claro, oscuro o el del sistema)
class SettingsService {

  /// Carga el tema preferido del usuario localmente desde las SharedPreferences
  Future<ThemeMode> themeMode() async => SettingsRepository.getThemeMode(await SharedPreferences.getInstance());

  /// Persistencia del tema preferido
  Future<void> updateThemeMode(ThemeMode theme) async {
    
    // Almacenar en las SharedPreferences el nuevo tema a traves del metodo estatico del repositorio 
    SettingsRepository.setThemeMode(theme);
  }
  
}
