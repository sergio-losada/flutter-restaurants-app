import 'dart:convert';

import 'package:restaurantes_gijon/src/dto/restaurant.dart';
import 'package:http/http.dart' as http;

class RestaurantService {
  
  // La antigua URL del ayuntamiento de Gijon esta caida
  //static const String url = 'https://opendata.gijon.es/descargar.php?id=810&tipo=JSON';
  
  // Consumo el JSON desde mi propia pagina de GitHub Pages
  static const String url = 'https://sergio-losada.github.io/restaurants.json';
  
  // Lista de objetos Restaurant donde se carga la respuesta de la peticion GET
  static List<Restaurant> restaurants = [];

  /// Ejecuta la peticion GET para consumir la API REST
  static Future<List<Restaurant>> getRestaurants() async {
    // GET Request
    var response = await http.get(Uri.parse(url));

	  if(response.statusCode != 200) {
	    return [];
	  }
    // Parsea el JSON al formato definido en la clase DTO Restaurant.dart
    RestaurantService.restaurants = Restaurant.parseRestaurants(json.decode(response.body));

    return RestaurantService.restaurants;    
  }

  /// Tratamiento del atributo de lineas y paradas de bus 
  static List<String> getBusLine(String bus) {
    // Eliminar espacios en blanco iniciales
    if(bus.startsWith(" ")) {
      bus = bus.substring(1);
    }
    List<String> result = [];

    // Obtener el numero de linea de bus
    var line = bus.split(" ")[0] + " " + bus.split(" ")[1];
    var stops = "";
    if(line.length.isOdd) {
      stops = bus.substring(bus.indexOf(" ") + 3);
    } 
    else {
      stops = bus.substring(bus.indexOf(" ")+4);
    }

    // Obtener la parada inicial y final del trayecto
    var initStop = stops.split("-")[0];
    var lastStop = stops.split("-")[1].split(",")[0];
    if(lastStop.startsWith(" ")) {
      lastStop = lastStop.substring(1);
    }

    // Devolver la informacion en el formato adecuado para el Widget TableRow
    result.add(line);
    result.add(initStop);
    result.add(lastStop);
    return result;
  }
  
}