# 🧩 Prueba Técnica — Registro de Usuario con Flutter

Esta prueba técnica consiste en el desarrollo de un flujo completo de registro de usuario utilizando Flutter, aplicando principios de arquitectura modular, buenas prácticas en UI y gestión de estado con Riverpod.

El flujo contempla la captura de datos personales, direcciones, fecha de nacimiento y una pantalla final de confirmación, integrando animaciones suaves y una estructura escalable y mantenible.

## 🚀 Ejecución

Para ejecutar el proyecto, siga los siguientes pasos:

1. Clonar el repositorio.
2. Ejecutar `flutter pub get` desde la carpeta raíz del proyecto.
3. Ejecutar `flutter run` desde la carpeta raíz del proyecto.

## 🧪 Pruebas y Calidad de Código

Uno de los focos principales fue la implementación de tests automatizados para asegurar la calidad de los componentes.

Se realizaron pruebas unitarias y de widgets para verificar:

- Renderizado de los widgets personalizados (CustomTextFormField, NavigationControls, etc).

- Validaciones de formularios.
- Interacción del usuario (inputs, botones, animaciones).
- Estados del flujo de registro.

Para ejecutar los tests, ejecuta el siguiente comando desde la carpeta raíz del proyecto:

```bash
flutter test
```

🧭 Estas pruebas garantizan que cada parte del sistema funcione correctamente, incluso ante cambios futuros.

<img width="270" height="600" alt="Screenshot_1762705203" src="https://github.com/user-attachments/assets/4eedad64-75bd-46ba-9c77-e9db9076052c" />
<img width="270" height="600" alt="Screenshot_1762705214" src="https://github.com/user-attachments/assets/079dbdc4-0126-4947-8115-399d715ca0f7" />
<img width="270" height="600" alt="Screenshot_1762705232" src="https://github.com/user-attachments/assets/f68775a9-59d8-49bd-970a-70f7716a281b" />
<img width="270" height="600" alt="Screenshot_1762705236" src="https://github.com/user-attachments/assets/6fecf232-f1ea-449b-a0d0-d78a6987965e" />
<img width="270" height="600" alt="Screenshot_1762705262" src="https://github.com/user-attachments/assets/8f6c859c-1eb2-461e-862f-f7d8973f314b" />
<img width="270" height="600" alt="Screenshot_1762705266" src="https://github.com/user-attachments/assets/ca5079dd-41ea-46f7-91d3-4756e85ad58b" />
<img width="270" height="600" alt="Screenshot_1762705276" src="https://github.com/user-attachments/assets/724ea565-a08c-46f1-a582-d19c956476cb" />

---

## 🎬 Video demostrativo

📽️ [Ver en Google Drive](https://drive.google.com/file/d/1ta7uHxmwtf46JqSkgZjHRT6u_k5NM-co/view?usp=sharing)

---

## 🚀 Tecnologías y Librerías Principales

| Tecnología / Librería | Descripción                                                                                                           |
| --------------------- | --------------------------------------------------------------------------------------------------------------------- |
| **Flutter**           | Framework principal para la construcción de interfaces nativas multiplataforma.                                       |
| **Riverpod**          | Manejo de estado reactivo, predecible y escalable, ideal para arquitecturas limpias.                                  |
| **Animate_do**        | Librería utilizada para animaciones suaves y declarativas, como transiciones entre vistas o aparición de componentes. |
| **Flutter Test**      | Framework nativo de pruebas unitarias y de widgets, utilizado extensivamente para asegurar la calidad del código.     |

## 🧠 Arquitectura y Organización del Proyecto

El proyecto sigue una estructura modular inspirada en arquitectura limpia, separando la lógica de presentación, dominio y datos.

### 📂 Estructura de Carpetas

```
lib/
├── core/
│ └── ui/
│ ├── atoms/
│ └── molecules/
├── presentation/
│ ├── views/
│ │ ├── personal_data.dart
│ │ ├── address_view.dart
│ │ └── done_view.dart
│ ├── screens/
│ │ └── home_screen.dart
│ └── providers/
├── domain/
│ └── entities/
├── config/
│ ├── database/
│ └── theme/


```

### 🧩 Uso del patrón Atomic Design

Se empleó una estructura basada en átomos y moléculas para mantener la UI organizada y reutilizable:

Átomos: componentes básicos como CustomTextFormField, CustomButton, etc.

Moléculas: combinaciones de átomos, como NavigationControls o CustomDatePicker.

Esta estrategia sigue un enfoque ordenado y escalable, muy usado en frontend moderno.

### 🔄 Navegación: PageView vs go_router

Para esta prueba técnica, se optó por utilizar un PageView en lugar de un router más complejo como go_router.

💡 Esto sigue el principio KISS (“Keep It Simple, Stupid”),
priorizando soluciones simples, claras y fáciles de mantener.

En este caso, el flujo es lineal y controlado, por lo que PageView ofrece:

- Mayor control sobre el desplazamiento entre pasos.
- Mejor rendimiento.
- Menor complejidad innecesaria.

## 🧩 Conclusión

Este proyecto refleja un enfoque sólido de desarrollo frontend en Flutter, priorizando:

- Orden,
- Escalabilidad,
- Legibilidad,
- y Calidad técnica.

A través del uso de buenas prácticas, pruebas automatizadas y componentes reutilizables, se logra un flujo fluido, intuitivo y mantenible que demuestra un alto nivel de profesionalismo en el desarrollo móvil.
