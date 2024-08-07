import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tecnico_provider.dart';

class LoginScreen extends StatelessWidget {
  final _cedulaController = TextEditingController();
  final _claveController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 150,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _cedulaController,
              decoration: InputDecoration(labelText: 'Cédula'),
            ),
            TextField(
              controller: _claveController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final tecnicoProvider =
                    Provider.of<TecnicoProvider>(context, listen: false);
                final cedula = _cedulaController.text;
                final clave = _claveController.text;

                print('Enviando datos: cedula=$cedula, clave=$clave');

                bool isAuthenticated =
                    await tecnicoProvider.loginTecnico(cedula, clave);

                if (isAuthenticated) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Cédula o contraseña incorrectos'),
                  ));
                }
              },
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
