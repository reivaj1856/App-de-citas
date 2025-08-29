import 'package:flutter/material.dart';
import 'package:actividad7v2/services/auth_service.dart';
import 'package:actividad7v2/screens/booking_screen.dart';
import 'package:actividad7v2/screens/appointment_history_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingScreen()),
                );
              },
              child: Text('Reservar Cita'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentHistoryScreen()),
                );
              },
              child: Text('Ver Historial de Citas'),
            ),
          ],
        ),
      ),
    );
  }
}