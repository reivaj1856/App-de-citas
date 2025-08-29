import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:actividad7v2/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:actividad7v2/screens/home_screen.dart';
import 'package:actividad7v2/services/notification_service.dart'; // Importar el servicio

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotifications(); // Inicializar notificaciones
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Citas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return HomeScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}