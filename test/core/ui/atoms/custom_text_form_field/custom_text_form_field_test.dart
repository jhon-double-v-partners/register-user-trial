import 'package:double_v_partners/core/ui/atoms/custom_text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomTextFormField', () {
    testWidgets('Muestra el label y el hint correctamente', (tester) async {
      final labelText = 'Nombre';
      final hintText = 'Ingresa tu nombre';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(labelText: labelText, hint: hintText),
          ),
        ),
      );

      expect(find.text(labelText), findsOneWidget);
      expect(find.text(hintText), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('Ejecuta onChanged cuando se cambia el texto', (tester) async {
      String? changedValue;
      final labelText = 'Nombre';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              labelText: labelText,
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Jhon');
      expect(changedValue, equals('Jhon'));
    });

    testWidgets('Ejecuta onTap cuando se toca el campo', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              labelText: 'Tocar',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextFormField));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('Muestra error cuando errorText está definido', (tester) async {
      final labelText = 'Correo';
      final errorText = 'Correo inválido';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              labelText: labelText,
              errorText: errorText,
            ),
          ),
        ),
      );

      expect(find.text(errorText), findsOneWidget);
    });

    testWidgets('Usa validator correctamente', (tester) async {
      final formKey = GlobalKey<FormState>();
      final textRequired = 'Requerido';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: CustomTextFormField(
                labelText: 'Campo obligatorio',
                validator: (value) =>
                    (value == null || value.isEmpty) ? textRequired : null,
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text(textRequired), findsOneWidget);
    });

    testWidgets('No permite edición si readOnly es true', (tester) async {
      final readOnlyText = "Solo lectura";
      final controller = TextEditingController(text: readOnlyText);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              labelText: 'Lectura',
              controller: controller,
              readOnly: true,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Nuevo texto');
      expect(controller.text, equals(readOnlyText));
    });
  });
}
