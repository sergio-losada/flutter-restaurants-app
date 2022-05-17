import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantes_gijon/src/controller/settings_controller.dart';
import 'package:restaurantes_gijon/src/dto/restaurant.dart';
import 'package:restaurantes_gijon/src/service/restaurant_service.dart';
import 'package:restaurantes_gijon/src/service/settings_service.dart';
import 'package:restaurantes_gijon/src/view/restaurant_detail_view.dart';
void main() {
  group('main Widget', () {
    testWidgets('Tests para el widget de restaurantes', (WidgetTester tester) async {
      
      // Asegurar que los widgets se hayan inicializado previamente a ejecutar el test
      WidgetsFlutterBinding.ensureInitialized();

      // Cargar los ajustes y preferencias del sistema 
      final settingsController = SettingsController(SettingsService());
      settingsController.loadSettings();
      
      // Mockear la lista de restaurantes para simular la petición HTTP
      var restaurants = List<Restaurant>.empty(growable: true);
      var restaurant = Restaurant(
        name: "Restaurante Ambigú Lounge",
        email: "eventos@bellavista-gijon.com",
        postalCode: "33203",
        description: "Frente a la Playa San Lorenzo, anexo al Restaurante Bellavista. Diferentes espacios en una terraza con un emplazamiento único. Ambigú es tu lugar de encuentro, de diversión, de sonrisas, de charlas, de baile. Ambigú es su público, su gente. Ambigú eres tú. La mejor música. La tuya. La mejor y más potente tecnología de sonido. Siéntelo. Para disfrutar con la familia y los más pequeños en  Ambigü se puede elegir entre una variada oferta gastronómica más divertida e informal, con las mismas vistas que en el resto del complejo.",
        address: "Avda. José García Bernardo, 256.",
        district: "Este",
        opHours: "",
        image: "https://www.gijon.es/sites/default/files/2019-08/DSC_6405.jpg",
        location: "Lon:-5.645886361599, Lat:43.543396183285",
        buses: "Línea 14 Sotiello - Pol. Somonte - Tremañes - Infanzón, Línea 20 Nuevo Roces - Montevil - Somió (La Pipa), Línea 25 Tremañes - Infanzón",
        telephone: "985 36 73 77",
        web: "http://ambigu-gijon.com",
        tags: "Restaurante, Bar, Gijón card. Tarjeta turística, Descuento Gijón",
        facebook: "https://www.facebook.com/ambigu.gijon",
        twitter: "https://twitter.com/ambigu_gijon",
        instagram: "https://www.instagram.com/ambigu_gijon",
      );
      restaurants.add(restaurant);

      // Asociar ese restaurante a la lista del widget
      RestaurantService.restaurants = restaurants;

      // Espera encontrar texto en el widget ListView, pues los atributos de Restaurant son string
      expect(find.byType(Text), findsOneWidget);
      
      // Invocar al widget al primer plano de la UI
      await tester.pump();
      var restaurantDetail = RestaurantDetailView(restaurant: restaurants[0]);

      // Tests para el widget DetailView
      expect(restaurantDetail.restaurant.name, "Restaurante Ambigú Lounge");
      expect(restaurantDetail.restaurant.email, "eventos@bellavista-gijon.com");
      expect(restaurantDetail.restaurant.postalCode, "33203");
      expect(restaurantDetail.restaurant. description, "Frente a la Playa San Lorenzo, anexo al Restaurante Bellavista. Diferentes espacios en una terraza con un emplazamiento único. Ambigú es tu lugar de encuentro, de diversión, de sonrisas, de charlas, de baile. Ambigú es su público, su gente. Ambigú eres tú. La mejor música. La tuya. La mejor y más potente tecnología de sonido. Siéntelo. Para disfrutar con la familia y los más pequeños en  Ambigü se puede elegir entre una variada oferta gastronómica más divertida e informal, con las mismas vistas que en el resto del complejo.",);
      expect(restaurantDetail.restaurant.address, "Avda. José García Bernardo, 256.");
      expect(restaurantDetail.restaurant.district, "Este");
      expect(restaurantDetail.restaurant.opHours, "");
      expect(restaurantDetail.restaurant.image, "https://www.gijon.es/sites/default/files/2019-08/DSC_6405.jpg");
      expect(restaurantDetail.restaurant.location, "Lon:-5.645886361599, Lat:43.543396183285");
      expect(restaurantDetail.restaurant.buses, "Línea 14 Sotiello - Pol. Somonte - Tremañes - Infanzón, Línea 20 Nuevo Roces - Montevil - Somió (La Pipa), Línea 25 Tremañes - Infanzón");
      expect(restaurantDetail.restaurant.telephone, "985 36 73 77");
      expect(restaurantDetail.restaurant.web, "http://ambigu-gijon.com");
      expect(restaurantDetail.restaurant. tags, "Restaurante, Bar, Gijón card. Tarjeta turística, Descuento Gijón");
      expect(restaurantDetail.restaurant.facebook, "https://www.facebook.com/ambigu.gijon");
      expect(restaurantDetail.restaurant.twitter, "https://twitter.com/ambigu_gijon");
      expect(restaurantDetail.restaurant.instagram, "https://www.instagram.com/ambigu_gijon");
      
      // Espera encontrar texto en el widget DetailView, pues los atributos de Restaurant son string
      expect(find.byType(Text), findsOneWidget);

    });
  });
}
