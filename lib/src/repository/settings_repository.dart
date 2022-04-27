import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Clase del repositorio de las preferencias del usuario. En concreto, se
/// persiste el tema elegido por el usuario localmente en las SharedPreferences
class SettingsRepository {

  // Instancia de la clase de las preferencias locales del usuario
  static SharedPreferences? _preferences;

  // Inicializacion de la instancia de SharedPreferences 
  static Future<SharedPreferences> getSharedPreferences() async{
    return await SharedPreferences.getInstance();
  }

  /// Devuelve el tema preferido del usuario desde las SharedPreferences
  static ThemeMode getThemeMode(SharedPreferences preferences) {
    if(_preferences == null) {
      getSharedPreferences().then((value) => _preferences = value);
    }
    var theme = preferences.getString('theme');
    if(theme == "light") {
      return ThemeMode.light;
    }
    else if(theme == "dark") {
      return ThemeMode.dark;
    }
    else {
      return ThemeMode.system;
    }
  }

  /// Sobreescribe el tema preferido del usuario
  static Future setThemeMode(ThemeMode theme) async =>
    await _preferences!.setString("theme", theme.name);

}