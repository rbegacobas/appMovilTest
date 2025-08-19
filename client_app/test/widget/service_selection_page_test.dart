import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:client_app/service_selection_page.dart';

void main() {
  testWidgets('ServiceSelectionPage shows services and packages', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ServiceSelectionPage()));

    // Verify service titles
    expect(find.text('Recargas'), findsWidgets);
    expect(find.text('Remesas'), findsWidgets);

    // Verify recommended packages header
    expect(find.text('Paquetes recomendados'), findsOneWidget);

  // Expand the first ExpansionTile to reveal package buttons
  final expansion = find.byType(ExpansionTile).first;
  expect(expansion, findsOneWidget);
  await tester.tap(expansion);
  await tester.pumpAndSettle();

  // Now the "Seleccionar" buttons should be in the tree
  final selectButtons = find.widgetWithText(ElevatedButton, 'Seleccionar');
  expect(selectButtons, findsWidgets);
  });
}
