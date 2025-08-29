import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:actividad7v2/models/appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveAppointment(Appointment appointment) async {
    await _db.collection('appointments').add(appointment.toFirestore());
  }

  Stream<List<Appointment>> getUserAppointments() {
    User? user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]);
    }
    return _db
        .collection('appointments')
        .where('userId', isEqualTo: user.uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Appointment.fromFirestore(doc))
            .toList());
  }
}