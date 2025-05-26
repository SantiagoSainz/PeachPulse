# 🩺 PeachPulse 

Bienvenido/a al código fuente de **PeachPulse**, una aplicación móvil enfocada en el monitoreo de salud y bienestar personal, desarrollada en **Flutter** con backend en **Firebase**. Este documento está diseñado para ayudarte a comprender la estructura del proyecto, cómo agregar nuevas funcionalidades y cómo escalarlo de forma ordenada y profesional.

---

## 📁 Estructura del Proyecto

```plaintext
/lib
│
├── main.dart                 → Punto de entrada de la app.
│
├── core/                    → Constantes, helpers y estilos globales.
│   ├── theme.dart           → Tema principal de la aplicación.
│   └── constants.dart       → Colores, paddings, rutas, etc.
│
├── models/                  → Modelos de datos (ej. usuarios, registros, etc.).
│   └── user_model.dart
│
├── screens/                 → Todas las pantallas de la app.
│   ├── home/                → Pantalla principal del usuario.
│   ├── profile/             → Pantalla de perfil.
│   ├── auth/                → Registro / Login.
│   └── settings/            → Configuración y preferencias.
│
├── widgets/                 → Componentes reutilizables (botones, cards, etc.).
│
├── services/                → Comunicación con Firebase y lógica de negocio.
│   ├── auth_service.dart
│   ├── user_service.dart
│   └── firestore_service.dart
│
├── providers/               → Estado global con Provider o Riverpod (si aplica).
│
└── routes/                  → Definición y control de navegación.
    └── app_routes.dart
```
**🔑 Tecnologías Clave**
Flutter: Framework principal para UI.

Firebase Auth: Autenticación de usuarios.

Cloud Firestore: Base de datos en tiempo real.

Provider o Riverpod: Gestión del estado (según implementación).

Firebase Storage (opcional): Para subir imágenes de perfil u otros documentos.

🧠 **Conceptos Clave**
🧩 Modularidad
Cada funcionalidad principal de la app está separada en pantallas, modelos, servicios y widgets, siguiendo una arquitectura clean-friendly.

📦 **Servicios**
Los archivos en /services encapsulan toda la lógica de Firebase. Ejemplo: auth_service.dart se encarga del login, logout, registro y estado del usuario.

📱 **Navegación**
Toda la navegación está centralizada en routes/app_routes.dart para evitar hardcoding de rutas y facilitar la navegación entre pantallas.

🌐 **Estado**
Usamos Provider o Riverpod para manejar el estado global. Si necesitas compartir información entre pantallas (como el usuario actual), deberías hacerlo a través del proveedor correspondiente.

🛠 **Cómo Agregar una Nueva Funcionalidad**
Ejemplo: Nueva pantalla "Historial de salud"
Crea una nueva carpeta en screens/health_history/.

Agrega la pantalla: ``health_history_screen.dart.``

Si hay datos nuevos, crea su modelo en models/.

Si necesitas lógica nueva, crea un servicio en services/.

Registra la ruta en routes/app_routes.dart.

Agrega el botón o navegación desde donde quieras acceder.

🔐 **Autenticación y Sesiones**
El usuario actual se obtiene con:

```dart
FirebaseAuth.instance.currentUser
```

Para cerrar sesión:

```dart
await FirebaseAuth.instance.signOut();
```


