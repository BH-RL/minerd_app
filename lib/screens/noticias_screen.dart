import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoticiasScreen extends StatefulWidget {
  @override
  _NoticiasScreenState createState() => _NoticiasScreenState();
}

class _NoticiasScreenState extends State<NoticiasScreen> {
  List<dynamic> _noticias = [];

  @override
  void initState() {
    super.initState();
    _fetchNoticias();
  }

  void _fetchNoticias() async {
    final url = Uri.parse('https://adamix.net/minerd/def/noticias.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _noticias = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar noticias')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias MINERD'),
      ),
      body: ListView.builder(
        itemCount: _noticias.length,
        itemBuilder: (context, index) {
          final noticia = _noticias[index];
          return ListTile(
            title: Text(noticia['title']),
            subtitle: Text(noticia['description']),
            leading: Image.network(noticia['image']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalleNoticiaScreen(url: noticia['link']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetalleNoticiaScreen extends StatelessWidget {
  final String url;

  DetalleNoticiaScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Noticia'),
      ),
      body: Center(
        child: Text('Abre el siguiente enlace en el navegador: $url'),
      ),
    );
  }
}