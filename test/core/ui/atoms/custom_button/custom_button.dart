import 'package:double_v_partners/core/ui/atoms/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'CustomButton muestra el texto y ejecuta onPressed correctamente',
    (WidgetTester tester) async {
      bool pressed = false;
      const buttonText = 'Continuar';

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: CustomButton(
              text: buttonText,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(ElevatedButton);
      final textFinder = find.text(buttonText);

      expect(
        buttonFinder,
        findsOneWidget,
        reason: 'Debe mostrar un ElevatedButton',
      );

      expect(
        textFinder,
        findsOneWidget,
        reason: 'Debe mostrar el texto proporcionado',
      );

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(pressed, isTrue, reason: 'Debe ejecutar la función onPressed');
    },
  );

  testWidgets('CustomButton renderiza el ícono si se proporciona', (
    WidgetTester tester,
  ) async {
    const buttonText = 'Guardar';
    const testIcon = Icon(Icons.save);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(text: buttonText, icon: testIcon),
        ),
      ),
    );

    expect(find.text(buttonText), findsOneWidget);
    expect(find.byIcon(Icons.save), findsOneWidget);
  });
}
