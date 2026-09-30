import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manajemen_data_mahasiswa/main.dart';

void main() {
  testWidgets('menampilkan daftar mahasiswa awal', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Data Mahasiswa'), findsOneWidget);
    expect(find.text('Total Mahasiswa: 5'), findsOneWidget);
    expect(find.text('Andi Saputra'), findsOneWidget);
    expect(find.text('Budi Santoso'), findsOneWidget);
  });

  testWidgets('mencari mahasiswa berdasarkan NIM', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField), '231003');
    await tester.pump();

    expect(find.text('Citra Lestari'), findsOneWidget);
    expect(find.text('Andi Saputra'), findsNothing);
  });
}
