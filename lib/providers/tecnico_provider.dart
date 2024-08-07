import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/tecnico_model.dart';

class TecnicoProvider with ChangeNotifier {
  Tecnico? _loggedInTecnico;
  String _token = '';
  

  Tecnico? get loggedInTecnico => _loggedInTecnico;
  String get token => _token;

Future<bool> registerTecnico(
  String cedula,
  String nombre,
  String apellido,
  String clave,
  String correo,
  String telefono,
  String fechaNacimiento
) async {
  final url = Uri.parse('https://adamix.net/minerd/def/registro.php');
  final response = await http.post(url, body: {
    'cedula': cedula,
    'nombre': nombre,
    'apellido': apellido,
    'clave': clave,
    'correo': correo,
    'telefono': telefono,
    'fecha_nacimiento': fechaNacimiento,
  });

  print('Respuesta de la API: ${response.body}');

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data['exito'] == true) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

  Future<bool> loginTecnico(String cedula, String clave) async {
    final url = Uri.parse('https://adamix.net/minerd/def/iniciar_sesion.php');
    final response = await http.post(url, body: {
      'cedula': cedula,
      'clave': clave,
    });

    print('Respuesta de la API: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['exito'] == true) {
        _loggedInTecnico = Tecnico.fromMap(data['datos']);
        _token = data['datos']['token'];
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
  
  void logout() {
    _loggedInTecnico = null;
    _token = '';
    notifyListeners();
  }
}