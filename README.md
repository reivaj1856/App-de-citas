📅 Flutter Appointment App

Aplicación móvil desarrollada en Flutter que permite a los usuarios registrarse, iniciar sesión y reservar citas, almacenando la información en Firebase.
Además, envía una notificación push programada 15 minutos antes de la cita como recordatorio.

✨ Características principales

🔐 Autenticación de usuarios (Firebase Auth: correo/contraseña).

☁️ Conexión con Firebase Firestore para almacenar las citas.

📅 Selector de fecha y hora para elegir la cita.

🔔 Notificaciones push programadas (Firebase Cloud Messaging + flutter_local_notifications).

📜 Historial de citas del usuario autenticado.

📲 Tecnologías utilizadas

Flutter (SDK cross-platform).

Firebase (Auth, Firestore, Cloud Messaging).

Dart como lenguaje principal.

flutter_local_notifications para recordatorios locales.

⚙️ Instalación y configuración
1️⃣ Clonar el repositorio
git clone https://github.com/usuario/flutter-appointment-app.git
cd flutter-appointment-app

2️⃣ Instalar dependencias
flutter pub get

3️⃣ Configurar Firebase

Crear un proyecto en Firebase Console
.

Registrar la app de Android/iOS en Firebase.

Descargar y colocar los archivos de configuración:

google-services.json → en android/app/

GoogleService-Info.plist → en ios/Runner/

Instalar la CLI de Firebase y configurar FlutterFire:

dart pub global activate flutterfire_cli
flutterfire configure

4️⃣ Ejecutar la app
flutter run

📌 Uso

El usuario se registra o inicia sesión.

Accede a la pantalla de Reservar Cita.

Selecciona la fecha 
y hora con el DateTimePicker.

Ingresa el motivo de la cita.

Se guarda la cita en Firestore.

15 minutos antes, recibe una notificación push.

Puede consultar el historial de citas.

Capturas del programa 
<img src="https://github.com/user-attachments/assets/4d069e19-0381-436d-915c-8483bcc55397" width="300" />
<img src="https://github.com/user-attachments/assets/a832383f-cf44-4357-b21a-6fdccd328467" width="300" />
<img src="https://github.com/user-attachments/assets/c0628da1-d4b2-4b5a-8d2e-5ba9104df3c2" width="300" />
<img src="https://github.com/user-attachments/assets/ccd18fec-07c1-4abb-b7b2-516f215de2ec" width="300" />
<img src="https://github.com/user-attachments/assets/f2ecb70c-87cc-447b-97c5-7221f56f6c34" width="300" />
<img src="https://github.com/user-attachments/assets/5386d024-1947-4d8e-b644-7ec0f041efb7" width="300" />
<p align="center">
  <img src="https://github.com/user-attachments/assets/4d069e19-0381-436d-915c-8483bcc55397" width="250" />
  <img src="https://github.com/user-attachments/assets/a832383f-cf44-4357-b21a-6fdccd328467" width="250" />
  <img src="https://github.com/user-attachments/assets/c0628da1-d4b2-4b5a-8d2e-5ba9104df3c2" width="250" />
</p>


