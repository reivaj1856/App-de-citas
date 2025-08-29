import 'package:flutter/material.dart';
import 'package:actividad7v2/models/appointment.dart';
import 'package:actividad7v2/services/firestore_service.dart';
import 'package:intl/intl.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historial de Citas')),
      body: StreamBuilder<List<Appointment>>(
        stream: _firestoreService.getUserAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tienes citas programadas.'));
          }

          final appointments = snapshot.data!;
          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fecha: ${DateFormat('dd/MM/yyyy HH:mm').format(appointment.date)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Motivo: ${appointment.reason}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}