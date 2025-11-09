import 'package:double_v_partners/core/ui/atoms/atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ContainerTop renderiza el título y aplica el color del tema', (
    WidgetTester tester,
  ) async {
    const testTitle = 'Bienvenido';
    const testPrimaryColor = Colors.blue;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: testPrimaryColor),
        ),
        home: Scaffold(body: ContainerTop(title: testTitle)),
      ),
    );

    final textFinder = find.text(testTitle);
    final clipPathFinder = find.byType(ClipPath);
    final containerFinder = find.byType(Container);

    expect(
      textFinder,
      findsOneWidget,
      reason: 'Debe mostrar el título recibido',
    );

    expect(
      clipPathFinder,
      findsOneWidget,
      reason: 'Debe estar envuelto en un ClipPath',
    );

    expect(
      containerFinder,
      findsOneWidget,
      reason: 'Debe contener un Container interno',
    );

    final container = tester.widget<Container>(containerFinder);
    final decoration = container.decoration as BoxDecoration;

    final theme = Theme.of(tester.element(find.byType(ContainerTop)));

    expect(
      decoration.color,
      equals(theme.colorScheme.primary),
      reason:
          'El color del contenedor debe coincidir con el color primario del tema actual',
    );
  });

  test('BottomCurveClipper genera un path con curva inferior', () {
    final clipper = BottomCurveClipper();
    const size = Size(200, 100);

    final path = clipper.getClip(size);

    expect(path, isA<Path>());

    expect(
      path.contains(const Offset(100, 50)),
      isTrue,
      reason: 'El path debe contener puntos dentro del rango esperado',
    );

    expect(
      clipper.shouldReclip(clipper),
      isFalse,
      reason: 'shouldReclip debe retornar false',
    );
  });
}
