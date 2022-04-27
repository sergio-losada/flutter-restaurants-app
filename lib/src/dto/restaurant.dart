class Restaurant {
  
  // Atributos
  String name;
  String email;
  String postalCode;
  String description;
  String address;
  String district;
  String opHours;
  String image;
  String location;
  String buses;
  String telephone;
  String web;
  String tags;
  String facebook;
  String twitter;
  String instagram;
  
  // Constructor
  Restaurant({
    required this.name,
    required this.email,
    required this.postalCode,
    required this.description,
    required this.address,
    required this.district,
    required this.opHours,
    required this.image,
    required this.location,
    required this.buses,
    required this.telephone,
    required this.web,
    required this.tags,
    required this.facebook,
    required this.twitter,
    required this.instagram,
  });

  /// Convertir la lista de datos dinamicos obtenida del JSON recibido
  /// en una lista parseada de objetos Restaurant con atributos definidos
  static List<Restaurant> parseRestaurants(List<dynamic> data) {
    Set<Restaurant> restaurants = {};
    for (var element in data) {
      // Evitar duplicados
      if(!restaurants.map((e) => e.name).contains(element["titulo"])){
        restaurants.add(Restaurant(
          name: element["titulo"].toString().replaceAll("&quot;", "\""),
          email: element["correo_electronico"],
          postalCode: element["codigo_postal"],
          description: element["descripcion"],
          address: element["direccion"],
          district: element["distrito"],
          opHours: element["horario"],
          image: element["imagen"],
          location: element["localizacion"],
          buses: element["lineas_bus"],
          telephone: element["telefono"],
          web: element["web"],
          tags: element["etiquetas"],
          facebook: element["facebook"],
          twitter: element["twitter"],
          instagram: element["instagram"],));
      }    
    }
    return List.from(restaurants);
  }

  /// Devuelve las posibles distritos de un restaurante para filtros
  static List<String> getDistricts() {
    return List<String>.from(["Centro", "Este", "Sur", "Oeste", "Rural", "Llano"]);
  }

  /// Devuelve las posibles etiquetas de un restaurante para filtros 
  static List<String> getTags() {
    return List<String>.from(["Restaurante", "Gijón Convention Bureau", "Gijón con Calidad", "Bar", "Sidrería",
                              "Gijón card. Tarjeta turística", "Descuento Gijón", "Cafetería", "Turismo",
                              "Gijón accesible", "Gijón Gourmet"]);
  }
}
