import 'package:double_v_partners/core/ui/molecules/navigation_controls/navigation_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NavigationControls', () {
    testWidgets('Muestra solo el botón "Continuar" cuando currentPage = 0', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NavigationControls(
              currentPage: 0,
              nextPage: () {},
              previousPage: () {},
            ),
          ),
        ),
      );

      // I installed animate_do, which is not working in tests so we need to wait a bit to make sure
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Continuar'), findsOneWidget);
      expect(find.text('Volver'), findsNothing);

      await tester.pumpAndSettle();
    });

    testWidgets(
      'Muestra ambos botones cuando currentPage > 0 y ejecuta callbacks',
      (tester) async {
        bool nextCalled = false;
        bool previousCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NavigationControls(
                currentPage: 1,
                nextPage: () => nextCalled = true,
                previousPage: () => previousCalled = true,
              ),
            ),
          ),
        );

        // Ambos botones deben estar presentes
        expect(find.text('Continuar'), findsOneWidget);
        expect(find.text('Volver'), findsOneWidget);

        // Tap en "Continuar"
        await tester.tap(find.text('Continuar'));
        await tester.pumpAndSettle();
        expect(nextCalled, isTrue);

        // Tap en "Volver"
        await tester.tap(find.text('Volver'));
        await tester.pumpAndSettle();
        expect(previousCalled, isTrue);
      },
    );

    testWidgets('Desactiva el botón "Volver" cuando currentPage = 0', (
      tester,
    ) async {
      bool previousCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NavigationControls(
              currentPage: 0,
              nextPage: () {},
              previousPage: () => previousCalled = true,
            ),
          ),
        ),
      );

      // I installed animate_do, which is not working in tests so we need to wait a bit to make sure
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Volver'), findsNothing);
      expect(previousCalled, isFalse);

      await tester.pumpAndSettle();
    });
  });
}
