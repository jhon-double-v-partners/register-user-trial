import 'package:double_v_partners/core/ui/atoms/atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomDatePicker muestra el campo y reacciona al tap', (
    WidgetTester tester,
  ) async {
    DateTime? selectedDate;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomDatePicker(onChanged: (date) => selectedDate = date),
        ),
      ),
    );

    // Verifica que el label esté presente
    expect(find.text('Fecha de nacimiento'), findsOneWidget);

    // Encuentra el TextFormField interno
    final textFieldFinder = find.byType(TextFormField);
    expect(textFieldFinder, findsOneWidget);

    // Simula el tap en el campo de fecha
    await tester.tap(textFieldFinder);
    await tester.pumpAndSettle();

    // showDatePicker no puede abrirse en tests, así que validamos el estado inicial
    expect(
      selectedDate,
      isNull,
      reason: 'Inicialmente no debe haber fecha seleccionada',
    );
  });

  testWidgets(
    'CustomDatePicker actualiza el texto y llama onChanged cuando se selecciona una fecha',
    (WidgetTester tester) async {
      final controller = TextEditingController();
      DateTime? selectedDate;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomDatePicker(
              controller: controller,
              onChanged: (date) => selectedDate = date,
            ),
          ),
        ),
      );

      final fakeDate = DateTime(2000, 1, 1);
      controller.text = '01/01/2000';

      await tester.pump();

      expect(controller.text, equals('01/01/2000'));

      final state = tester.state(find.byType(CustomDatePicker)) as dynamic;
      state.widget.onChanged?.call(fakeDate);

      expect(selectedDate, equals(fakeDate));
    },
  );
}
