// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurantes_gijon/src/service/restaurant_service.dart';
import 'package:restaurantes_gijon/src/view/settings_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:restaurantes_gijon/src/dto/restaurant.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RestaurantDetailView extends StatelessWidget {
  // Instancia del objeto Restaurant a mostrar en detalle
  final Restaurant restaurant;

    // Constructor que requiere una instancia de Restaurant
  const RestaurantDetailView({Key? key, required this.restaurant})
      : super(key: key);

  // Nombre de la ruta
  static const routeName = '/sample_item';

  /// Ejecuta el launch o muestra un Toast en caso de error
  void launchUrl(BuildContext context, String url) async {
    try {
      await launch(url);
    } 
    catch (platformException) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.launchError,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lista de marcadores para el Google Map
    List<Marker> _markers = [];

    _markers.add(Marker(
      markerId: MarkerId(restaurant.name),
      position: LatLng(
        // Obtener las coordenadas (Lat, Long) del objeto Restaurant
        double.parse(restaurant.location.split(',')[1].split(':')[1]),
        double.parse(restaurant.location.split(',')[0].split(':')[1])
        ),
        infoWindow: InfoWindow(
          // La ventana informativa sera la direccion para que al hacer clic
          // sobre el marcador nos redirija a una busqueda en Google Maps
          title: restaurant.address
        )
      )
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navegacion a la ventana de ajustes, recuperando el contexto
              // (posicion en la lista en la que se encontraba el usuario)
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      // el OrientationBuilder determinara si la orientacion es portrait o landscape
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientationResolver(
            context, _markers, orientation == Orientation.portrait
          );
        }
      )
    );
  }

  Widget orientationResolver(BuildContext context, List<Marker> _markers, bool isPortrait) {
    if (isPortrait) {
      // Layout para posicion vertical
      return SingleChildScrollView(
        child: Column(
          children: [
            // Muestra la imagen y el detail Widget con el ancho completo
            Image.network(restaurant.image),
            detailWidget(context, _markers, MediaQuery.of(context).size.width)
          ]
        )
      );
    } 
    else {
      // Layout para posicion horizontal
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Muestra la imagen a la izquierda 
          Image.network(restaurant.image, width: MediaQuery.of(context).size.width / 2),
          // Muestra el detail Widget con la mitad del ancho a la derecha
          SingleChildScrollView(
            child: detailWidget(context, _markers, MediaQuery.of(context).size.width / 2),
          )
        ],
      );
    }
  }

  Widget detailWidget(BuildContext context, List<Marker> _markers, double width) {
    // El entero que se resta en el atributo width es el padding aplicado
    return Column(children: [
      SizedBox(
        width: width - 36,
        // Renderizar el codigo HTML de la descripcion del objeto Restaurant
        child: Html(
          data: restaurant.description, 
          style: {
            "body": Style(
              textAlign: TextAlign.justify,
              fontSize: FontSize.large,
              margin: const EdgeInsets.all(9.0)
            )
          }
        ),
      ),
      SizedBox(
        height: 50,
        width: width - 36,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Boton de llamada en una Row de ancho completo
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(width - 48, 45),
                  maximumSize: Size(width - 48, 45)),
              onPressed: () {
                // Al pulsarlo, copia el numero de telefono al dialer para llamar
                launchUrl(context, 'tel:' + restaurant.telephone);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.phone),
                  Text(" " + AppLocalizations.of(context)!.call)
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 65,
        width: width - 36,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Boton de enviar un email con acceso al correo en una Row de medio ancho
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width /2 - 28, 45),
                maximumSize: Size(width / 2 - 28, 45)),
              onPressed: () {
                // Al pulsarlo, copia la direccion de correo en el campo del destinatario
                launchUrl(context, 'mailto:' + restaurant.email);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.email),
                  Text(
                    " " + AppLocalizations.of(context)!.email,
                    style: const TextStyle(fontSize: 12)
                  )
                ],
              ),
            ),
            // Boton de acceder al sitio web del restaurante en una Row de medio ancho
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width / 2 - 28, 45),
                maximumSize: Size(width / 2 - 28, 45)),
              onPressed: () {
                // Al pulsarlo, redirige a la pagina web indicada por URL
                launchUrl(context, restaurant.web);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.web),
                  Text(" " + AppLocalizations.of(context)!.web)
                ]
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: width - 36,
        child: Column(children: <Widget>[
          Text(
            // Titulo de la seccion Acerca de
            AppLocalizations.of(context)!.about,
            style: const TextStyle(
              height: 2, fontSize: 24, fontWeight: FontWeight.bold)
            ),
            SizedBox(
              height: 30,
              width: width - 36,
              child:
                Html(
                  // Subtitulo del campo Direccion
                  data: AppLocalizations.of(context)!.address, 
                  style: {
                  "body": Style(
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.justify,
                    fontSize: FontSize.larger,
                    margin: const EdgeInsets.all(9.0)
                  )
                }
              )
            ),
            SizedBox(
              height: 60,
              width: width - 36,
              child: Html(
                // Valor del campo Direccion
                data: restaurant.address + (restaurant.district.isNotEmpty
                  ? ", Distrito " + restaurant.district + ", " 
                  : ", ") 
                  + restaurant.postalCode,
                style: {
                  "body": Style(
                    textAlign: TextAlign.justify,
                    fontSize: FontSize.large,
                    margin: const EdgeInsets.all(9.0)
                  )
                }
              )
            ),
            SizedBox(
              height: 30,
              width: width - 36,
              child: Html(
                // Subtitulo del campo Horario
                data: AppLocalizations.of(context)!.schedule, 
                style: {
                  "body": Style(
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.justify,
                    fontSize: FontSize.larger,
                    margin: const EdgeInsets.all(9.0)
                  )
                }
              )
            ),
            SizedBox(
              width: width - 36,
              child: Html(
                // Valor del campo Horario
                data: restaurant.opHours.isNotEmpty
                  ? restaurant.opHours 
                  : "No disponible",
                style: {
                  "body": Style(
                    textAlign: TextAlign.justify,
                    fontSize: FontSize.large,
                    margin: const EdgeInsets.all(9.0)
                  )
                }
              )
            ),
          ]
        )
      ),
      SizedBox(
        height: 50,
        width: width - 36,
        child: Html(
          // Subtitulo del campo Etiquetas
          data: AppLocalizations.of(context)!.tags,
          style: {
            "body": Style(
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.justify,
              fontSize: FontSize.larger,
              margin: const EdgeInsets.only(bottom: 9.0, left: 9.0, right: 9.0, top: 26.0)
            )
          }
        )
      ),
      SizedBox(
          width: width - 36,
          child: Html(
            // Valor del campo Etiquetas
            data: restaurant.tags, style: {
            "body": Style(
              textAlign: TextAlign.justify,
              fontSize: FontSize.large,
              margin: const EdgeInsets.all(9.0)
            )
          }
        )
      ),
      Text(
        // Titulo de la seccion Redes Sociales
        AppLocalizations.of(context)!.socialMedia,
        style: const TextStyle(height: 2, fontSize: 24, fontWeight: FontWeight.bold)
      ),
      SizedBox(
        height: 65,
        width: width - 36,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Boton de acceder al Facebook del restaurante en una Row de un tercio de ancho
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width / 3 - 18, 45),
                maximumSize: Size(width / 3 - 18, 45)),
              onPressed: () {
                // Al pulsarlo, redirige a la pagina de Facebook indicada por URL
                launchUrl(context, restaurant.facebook);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.facebook),
                  Text(
                    " Facebook", 
                    style: TextStyle(fontSize: 12)
                  )
                ],
              ),
            ),
            // Boton de acceder al Twitter del restaurante en una Row de un tercio de ancho
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width / 3 - 18, 45),
                maximumSize: Size(width / 3 - 18, 45)),
              onPressed: () {
                // Al pulsarlo, redirige via Twitter o navegador a la pagina de Twitter indicada por URL
                launchUrl(context, restaurant.twitter);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(FontAwesomeIcons.twitter),
                  Text(" Twitter", style: TextStyle(fontSize: 12))
                ],
              ),
            ),
            // Boton de acceder al Instagram del restaurante en una Row de un tercio de ancho
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width / 3 - 18, 45),
                maximumSize: Size(width / 3 - 18, 45)),
              onPressed: () {
                // Al pulsarlo, redirige via Instagram o navegador a la pagina de Instagram indicada por URL
                launchUrl(context, restaurant.instagram);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(FontAwesomeIcons.instagram),
                  Text(" Instagram", style: TextStyle(fontSize: 12))
                ]
              ),
            ),
          ],
        ),
      ),
      Text(
        // Titulo de la seccion Ubicacion
        AppLocalizations.of(context)!.location,
        style: const TextStyle(height: 2, fontSize: 24, fontWeight: FontWeight.bold)
      ),
      Column(
        children: <Widget>[
          SizedBox(
            width: width - 48,
            height: 300.0,
            // Widget de Google Maps
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  // Establecer la posicion inicial de la camara en las coordenadas del restaurante
                  double.parse(restaurant.location.split(',')[1].split(':')[1]),
                  double.parse(restaurant.location.split(',')[0].split(':')[1])),
                zoom: 15,
              ),
              // Añadir el marcador en las coordenadas del restaurante
              markers: Set<Marker>.of(_markers),
            )
          )
        ],
      ),
      if (restaurant.buses.isNotEmpty)
        // Titulo de la seccion Cómo llegar
        Text(AppLocalizations.of(context)!.directions,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 3)
        ),
      if (restaurant.buses.isNotEmpty)
        SizedBox(
          width: width - 36,
          // Tabla para mostrar las lineas de bus
          child: Table(
            border: TableBorder.all(), 
            children: [
              if (restaurant.buses.isNotEmpty)
                buildRow([
                  // Cabeceras de la tabla
                  AppLocalizations.of(context)!.line,
                  AppLocalizations.of(context)!.initStop,
                  AppLocalizations.of(context)!.lastStop
                ], isHeader: true),
              if (restaurant.buses.isNotEmpty)
                for (var i in restaurant.buses.split(","))
                  buildRow(
                    // Construir una fila con los datos previamente parseados
                    RestaurantService.getBusLine(
                      restaurant.buses.split(",")[
                        restaurant.buses.split(",").indexOf(i)
                      ]
                    ),
                  )
              ]
            )
        ),
        SizedBox(
          // Margen inferior
          height: 26,
          width: width - 36,
        )
      ]
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => 
    TableRow(
      children: cells.map(
        (cell) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              // Inicializar cada celda con los datos de los autobuses
              child: Text(
                cell,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal
                )
              )
            )
          );
        }
      ).toList()
    );

}
