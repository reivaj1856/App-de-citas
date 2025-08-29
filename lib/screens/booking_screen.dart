import 'package:flutter/material.dart';
import 'package:actividad7v2/models/appointment.dart';
import 'package:actividad7v2/services/firestore_service.dart';
import 'package:actividad7v2/services/auth_service.dart';
import 'package:actividad7v2/services/notification_service.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  final NotificationService _notificationService = NotificationService();
  final TextEditingController _reasonController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _bookAppointment() async {
    if (_selectedDate == null || _selectedTime == null || _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    final DateTime appointmentDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final String? userId = _authService.getCurrentUser()?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Usuario no autenticado.')),
      );
      return;
    }

    final newAppointment = Appointment(
      id: '', // Firestore generará el ID
      userId: userId,
      date: appointmentDateTime,
      reason: _reasonController.text,
    );

    await _firestoreService.saveAppointment(newAppointment);

    // Programar notificación 15 minutos antes
    final DateTime notificationTime = appointmentDateTime.subtract(Duration(minutes: 15));
    if (notificationTime.isAfter(DateTime.now())) {
      _notificationService.scheduleNotification(
        notificationTime,
        'Recordatorio de Cita',
        'Tu cita para "${_reasonController.text}" es en 15 minutos.',
        appointmentDateTime.millisecondsSinceEpoch ~/ 1000, // ID único
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cita reservada con éxito!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservar Cita')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(_selectedDate == null
                  ? 'Seleccionar Fecha'
                  : 'Fecha: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              title: Text(_selectedTime == null
                  ? 'Seleccionar Hora'
                  : 'Hora: ${_selectedTime!.format(context)}'),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: 'Motivo de la cita'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _bookAppointment,
              child: Text('Guardar Cita'),
            ),
          ],
        ),
      ),
    );
  }
}