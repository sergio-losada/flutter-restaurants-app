import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantes_gijon/src/service/restaurant_service.dart';

void main() {
  group('Tests unitarios', () {
    test('Tests para la lista de restaurantes', () async {
      // Tests para la lista de restaurantes
      var restaurants = await RestaurantService.getRestaurants();
      expect(restaurants.isNotEmpty, true);
      expect(restaurants.length, 50);      
    });

    test('Tests para el detalle de un restaurante', () async {
      // Tests para el detalle del primer restaurante de la lista
      var restaurants = await RestaurantService.getRestaurants();
      expect(restaurants.first.name, "Restaurante Real Club Astur de Regatas");
      expect(restaurants.first.address, "Avda. de la Salle, 2-4");
      expect(restaurants.first.district, "Centro");
      expect(restaurants.first.postalCode, "33201");
      expect(restaurants.first.email, "info@rcar.es");
      expect(restaurants.first.web, "https://www.rcar.es/");
      expect(restaurants.first.telephone, "+34 985 34 42 02");
      expect(restaurants.first.opHours, "Día de descanso: en invierno los lunes");
      expect(restaurants.first.tags, "Restaurante, Gijón Convention Bureau");
      expect(restaurants.first.image, "https://www.gijon.es/sites/default/files/2021-02/Club%20desde%20la%20piscina.jpg");
      expect(restaurants.first.location, "Lon:-5.6599794731867, Lat:43.547216436218");
      expect(restaurants.first.buses, "Línea 4 El Lauredal - Campus Universitario, Línea 6 El Musel - Pol. Porceyo/Porceyo");

      expect(restaurants.first.facebook, "");
      expect(restaurants.first.twitter, "");
      expect(restaurants.first.instagram, "");
    });

    test('Tests para el detalle de otro restaurante', () async {
      // Tests para el detalle del ultimo restaurante de la lista
      var restaurants = await RestaurantService.getRestaurants();
      expect(restaurants.last.name, "Sidrería Marisquería Poniente");
      expect(restaurants.last.address, "Avda. de Juan Carlos I, 13");
      expect(restaurants.last.district, "Oeste");
      expect(restaurants.last.postalCode, "33212");
      expect(restaurants.last.web, "http://www.marisqueriaponiente.com");
      expect(restaurants.last.telephone, "985322349");
      expect(restaurants.last.opHours, "De 11:00 a cierre.");
      expect(restaurants.last.tags, "Gijón con Calidad, Sidrería");
      expect(restaurants.last.image, "https://www.gijon.es/sites/default/files/2019-06/poniente01.JPG");
      expect(restaurants.last.location, "Lon:-5.6840837001801, Lat:43.537458283587");
      expect(restaurants.last.buses, "Línea 1 El Cerillero - Hospital de Cabueñes, Línea 4 El Lauredal - Campus Universitario");
      expect(restaurants.last.facebook, "https://www.facebook.com/marisqueria-poniente-179636638755626/");
      
      expect(restaurants.last.email, "");
      expect(restaurants.last.twitter, "");
      expect(restaurants.last.instagram, "");
    });

    test('Tests para el metodo de parseo de las lineas de bus', () async {
      // Tests para el metodo que parsea la cadena que indica las lineas de bus
      var restaurants = await RestaurantService.getRestaurants();
      var bus = restaurants.first.buses;
      var buses = RestaurantService.getBusLine(bus);
      expect(buses.length, 3);
      expect(buses[0], "Línea 4");
      expect(buses[1], "El Lauredal ");
      expect(buses[2], "Campus Universitario");
    });
  });

}
