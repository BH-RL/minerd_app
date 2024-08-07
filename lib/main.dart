import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/incidencia_provider.dart';
import 'providers/tecnico_provider.dart';
import 'providers/visita_provider.dart';
import 'screens/home_screen.dart';
import 'screens/registro_incidencia_screen.dart';
import 'screens/lista_incidencias_screen.dart' as incidencias;
import 'screens/lista_visitas_screen.dart' as visitas;
import 'screens/detalle_incidencia_screen.dart';
import 'screens/detalle_visita_screen.dart';
import 'screens/consulta_escuelas_screen.dart';
import 'screens/consulta_director_screen.dart';
import 'screens/acerca_de_screen.dart';
import 'screens/configuracion_screen.dart';
import 'screens/mapa_visitas_screen.dart';
import 'screens/noticias_screen.dart';
import 'screens/estado_clima_screen.dart';
import 'screens/horoscopo_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/tipos_visitas_screen.dart';
import 'screens/registro_visita_screen.dart';
import 'utils/theme.dart';

import 'models/visita_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => IncidenciaProvider()),
      ChangeNotifierProvider(create: (_) => TecnicoProvider()),
      ChangeNotifierProvider(create: (_) => VisitaProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MINERD App',
      theme: CustomTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/registro-incidencia': (context) => RegistroIncidenciaScreen(),
        '/lista-incidencias': (context) => incidencias.ListaIncidenciasScreen(),
        '/lista-visitas': (context) => visitas.ListaVisitasScreen(),
        '/detalle-incidencia': (context) => DetalleIncidenciaScreen(),
        '/registro-visita': (context) =>
            RegistroVisitaScreen(), 
        '/consulta-escuela': (context) => ConsultaEscuelaScreen(),
        '/consulta-director': (context) => ConsultaDirectorScreen(),
        '/acerca-de': (context) => AcercaDeScreen(),
        '/configuracion': (context) => ConfiguracionScreen(),
        '/mapa-visitas': (context) => MapaVisitasScreen(),
        '/noticias': (context) => NoticiasScreen(),
        '/estado-clima': (context) => EstadoClimaScreen(),
        '/horoscopo': (context) => HoroscopoScreen(),
        '/tipos-visitas': (context) => TiposVisitasScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detalle-incidencia') {
          return MaterialPageRoute(
            builder: (context) => DetalleIncidenciaScreen(),
            settings: settings,
          );
        } else if (settings.name == '/detalle-visita') {
          final visita = settings.arguments as Visita;
          return MaterialPageRoute(
            builder: (context) => DetalleVisitaScreen(visita: visita),
          );
        }
        return null;
      },
    );
  }
}
