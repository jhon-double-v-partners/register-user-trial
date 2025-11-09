import 'package:double_v_partners/core/ui/atoms/container_bottom/container_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'ContainerBottom se renderiza correctamente con el color del tema',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Stack(children: const [ContainerBottom()])),
        ),
      );

      final containerFinder = find.byType(Container);

      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      final boxDecoration = container.decoration as BoxDecoration;

      expect(boxDecoration.color, equals(ThemeData().colorScheme.primary));

      final positionedFinder = find.byType(Positioned);
      expect(positionedFinder, findsOneWidget);
    },
  );
}
