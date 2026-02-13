import 'package:flutter_test/flutter_test.dart';

import 'package:driver_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DriverApp());
    await tester.pump();

    // Splash screen should render
    expect(find.textContaining('Driver'), findsAny);
  });
}
