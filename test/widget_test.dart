import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Movie catalog renders all items', (WidgetTester tester) async {
    await tester.pumpWidget(const WidgetPlaygroundApp());

    expect(find.text('Movie Catalog'), findsOneWidget);
    expect(find.text('Sakamoto Days'), findsOneWidget);
    expect(find.text('One Piece'), findsOneWidget);
    expect(find.text('Black Clover'), findsOneWidget);
    expect(find.text('Solo Leveling'), findsOneWidget);
    expect(find.text('One Punch Man'), findsOneWidget);
  });
}
