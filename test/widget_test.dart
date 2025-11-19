import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coffe_shop/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Coffee Shop app loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const CoffeeShopApp());
    await tester.pumpAndSettle();

    // Cek teks utama
    expect(find.text('Coffee Shop'), findsOneWidget);

    // Cek grid
    expect(find.byType(GridView), findsOneWidget);

    // Cek card tersedia
    expect(find.byType(Card), findsWidgets);

    // Cek image ada
    expect(find.byType(Image), findsWidgets);
  });
}
