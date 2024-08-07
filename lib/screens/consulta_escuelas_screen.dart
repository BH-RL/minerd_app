import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConsultaEscuelaScreen extends StatefulWidget {
  @override
  _ConsultaEscuelaScreenState createState() => _ConsultaEscuelaScreenState();
}

class _ConsultaEscuelaScreenState extends State<ConsultaEscuelaScreen> {
  final TextEditingController _codigoController = TextEditingController();
  Map<String, dynamic>? _escuelaData;

  void _consultarEscuela() async {
    final codigo = _codigoController.text;
    if (codigo.isNotEmpty) {
     final url = Uri.parse(
    'https://adamix.net/minerd/minerd/centros.php');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _escuelaData = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al consultar la escuela')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Por favor ingrese un código de escuela válido')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta de Escuela'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _codigoController,
              decoration: InputDecoration(labelText: 'Código de la Escuela'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _consultarEscuela,
              child: Text('Consultar'),
            ),
            SizedBox(height: 20),
            _escuelaData != null
                ? Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          title: Text('Nombre'),
                          subtitle: Text(_escuelaData!['nombre'] ?? 'N/A'),
                        ),
                        ListTile(
                          title: Text('Dirección'),
                          subtitle: Text(_escuelaData!['direccion'] ?? 'N/A'),
                        ),
                        ListTile(
                          title: Text('Teléfono'),
                          subtitle: Text(_escuelaData!['telefono'] ?? 'N/A'),
                        ),
                        ListTile(
                          title: Text('Director'),
                          subtitle: Text(_escuelaData!['director'] ?? 'N/A'),
                        ),
                      ],
                    ),
                  )
                : Text('Ingrese un código de escuela y presione "Consultar"'),
          ],
        ),
      ),
    );
  }
}
