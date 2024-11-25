
# Documentación del Proyecto: To-Do List en Flutter

## 1. Descripción del Proyecto

Este proyecto consiste en una aplicación móvil desarrollada con Flutter que permite a los usuarios gestionar una lista de tareas. La aplicación permite a los usuarios:

- Iniciar sesión y cerrar sesión mediante **Firebase Authentication**.
- Crear nuevas tareas con un título y descripción.
- Ver, eliminar y gestionar las tareas almacenadas en **Firebase Firestore**.
- Utiliza el patrón **BLoC** (Business Logic Component) para la gestión del estado de la aplicación, proporcionando una arquitectura limpia y escalable.

La aplicación proporciona una interfaz sencilla y efectiva para gestionar tareas, asegurando la persistencia de los datos mediante Firebase y el uso de una arquitectura reactiva con **BLoC**.

## 2. Estructura del Proyecto

La estructura de directorios y archivos de este proyecto sigue una convención clara para facilitar la navegación y el mantenimiento del código. A continuación se detalla la organización de los archivos principales en el proyecto.
```
/lib
/features
/authentication
auth_bloc.dart           # Maneja la lógica de BLoC para la autenticación
auth_event.dart          # Define los eventos relacionados con la autenticación (e.g., iniciar sesión)
auth_state.dart          # Define los estados de la autenticación (e.g., cargando, éxito)
auth_service.dart        # Contiene la lógica de interacción con FirebaseAuth para la autenticación
login.dart               # Pantalla de inicio de sesión donde los usuarios ingresan sus credenciales
welcome_screen.dart      # Pantalla de bienvenida después del inicio de sesión
/to_do
to_do_model.dart         # Define el modelo de datos de las tareas (título, descripción, fecha)
to_do_repository.dart    # Lógica de interacción con la base de datos de Firestore
to_do_bloc.dart          # Gestiona la lógica del BLoC para las tareas
to_do_event.dart         # Define los eventos relacionados con las tareas (e.g., obtener tareas, agregar tarea)
to_do_state.dart         # Define los estados de las tareas (e.g., cargando, cargadas, error)
to_do_list.dart          # Pantalla que muestra la lista de tareas
add_task_dialog.dart     # Diálogo emergente para agregar una nueva tarea
empty_state.dart         # Widget que se muestra cuando no hay tareas disponibles
to_do_card.dart          # Widget para mostrar las tareas en formato tarjeta
/core
/widgets
custom_button.dart       # Componente reutilizable para botones estilizados
custom_loading_widget.dart # Widget para mostrar un indicador de carga
/utils
keyboard_actions_configs.dart # Configuración de las acciones del teclado
/theme.dart                # Define la configuración global de los estilos (colores, tamaños, fuentes)
/colors.dart               # Archivo con la definición de los colores de la aplicación
/sizes.dart                # Archivo con la definición de los tamaños de los elementos
/fonts.dart                # Archivo con la definición de las fuentes utilizadas
/navigation.dart            # Configuración de la navegación en la aplicación con GoRouter
/firestore_db.dart          # Lógica de interacción con Firestore (base de datos)
main.dart                    # Punto de entrada de la aplicación Flutter
/pubspec.yaml               # Archivo de configuración de dependencias y metadatos del proyecto
```

### **Descripción de los Archivos Principales**

- **`pubspec.yaml`**: Gestor de dependencias y configuraciones del proyecto Flutter.
- **`main.dart`**: Configuración del enrutamiento y la inicialización de Firebase.
- **`auth_service.dart`**: Lógica de autenticación con **FirebaseAuth**.
- **`auth_bloc.dart`, `auth_event.dart`, `auth_state.dart`**: Lógica del flujo de autenticación utilizando **BLoC**.
- **`login.dart`**: Pantalla de inicio de sesión para el ingreso de credenciales.
- **`to_do_model.dart`**: Modelo para las tareas.
- **`to_do_repository.dart`**: Interacción con **Firestore** para obtener y almacenar tareas.
- **`to_do_bloc.dart`, `to_do_event.dart`, `to_do_state.dart`**: Lógica de gestión de tareas con **BLoC**.
- **`to_do_list.dart`**: Pantalla principal para ver y gestionar las tareas.
- **`add_task_dialog.dart`**: Diálogo emergente para agregar nuevas tareas.
- **`empty_state.dart`**: Widget cuando no hay tareas disponibles.
- **`to_do_card.dart`**: Componente visual para mostrar las tareas.

## 3. Funcionalidades Principales

Este proyecto de **To-Do List** proporciona diversas funcionalidades que permiten gestionar tareas de manera eficiente y sencilla. A continuación, se describen las principales características de la aplicación:

### **Autenticación de Usuarios**
La aplicación permite que los usuarios inicien sesión utilizando su correo electrónico y contraseña a través de **Firebase Authentication**. La autenticación se gestiona utilizando el patrón **BLoC** para manejar los eventos y estados relacionados con el inicio y cierre de sesión.

- **Iniciar sesión**: Los usuarios proporcionan su correo electrónico y contraseña.
- **Cerrar sesión**: Los usuarios pueden cerrar sesión en cualquier momento.

El flujo de autenticación está completamente integrado con Firebase, lo que asegura una gestión segura y eficiente de las credenciales del usuario.

### **Gestión de Tareas (To-Do List)**
Los usuarios pueden crear, ver, actualizar y eliminar tareas a través de una interfaz sencilla y fácil de usar. Las tareas se almacenan en **Firebase Firestore**, lo que asegura que los datos sean persistentes y accesibles desde cualquier dispositivo.

- **Ver tareas existentes**: Los usuarios pueden consultar una lista de tareas almacenadas en la base de datos.
- **Crear tareas nuevas**: Los usuarios pueden agregar nuevas tareas proporcionando un título y una descripción.
- **Eliminar tareas**: Los usuarios pueden eliminar tareas desde la lista si ya no las necesitan.

### **Persistencia de Datos**
Las tareas son almacenadas en **Firebase Cloud Firestore**, lo que proporciona una solución robusta y escalable para la persistencia de datos. Las tareas son recuperadas y almacenadas de forma eficiente utilizando el repositorio de tareas.

### **Navegación**
La navegación entre las pantallas de la aplicación se gestiona con **GoRouter**, lo que facilita la transición entre las diferentes vistas de la aplicación.

## 4. Instalación y Ejecución

### **Requisitos Previos**

1. **Flutter SDK**: [Instalar Flutter](https://flutter.dev/docs/get-started/install).
2. **Xcode** (iOS): Necesario para desarrollo en dispositivos Apple.
3. **Android Studio**: Necesario para desarrollo en dispositivos Android.
4. **CocoaPods** (iOS): `sudo gem install cocoapods`.

### **Instalación**

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/tu-proyecto.git
   cd tu-proyecto
   ```

2. Instalar dependencias:
   ```bash
   flutter pub get
   ```

3. Configurar Firebase:
   - [Descargar el archivo `google-services.json` para Android](https://drive.google.com/drive/folders/1p6hk-JtYHvOccdrQkm2U_khtyoOA88MV?usp=sharing) y colocarlo en `android/app/`.
   - [Descargar el archivo `GoogleService-Info.plist` para iOS](https://drive.google.com/drive/folders/1p6hk-JtYHvOccdrQkm2U_khtyoOA88MV?usp=sharing) y colocarlo en `ios/Runner/`.

4. Configuración de iOS:
   ```ruby
   platform :ios, '15.0'
   cd ios
   pod install
   cd ..
   ```

### **Ejecución**

1. **Android**:
   ```bash
   flutter run
   ```

2. **iOS**:
   ```bash
   flutter run
   ```
## 5. Versión de Flutter Utilizada

Este proyecto fue desarrollado utilizando **Flutter 3.24.4**. A continuación se detalla la versión específica y las herramientas utilizadas en el entorno de desarrollo:

- **Flutter Version**: 3.24.4
- **Dart Version**: 3.5.4
- **Flutter Engine Revision**: db49896cf2
- **Flutter SDK Revision**: 603104015d (5 weeks ago)
- **DevTools Version**: 2.37.3

### **Comandos de Flutter**
- **Ver versión de Flutter**: Para verificar la versión instalada de Flutter, usa el siguiente comando:
  ```bash
  flutter --version


## 6. Conclusión

Esta documentación cubre las funcionalidades principales, la estructura del proyecto, y cómo instalar y ejecutar la aplicación localmente. Asegúrate de seguir los pasos de configuración de Firebase y las herramientas necesarias para comenzar a trabajar en el proyecto.

---
Para **descargar la aplicación** directamente, puedes acceder al siguiente enlace de **Firebase App Distribution**:
- (https://appdistribution.firebase.dev/i/47bbcd7a86202701)
```