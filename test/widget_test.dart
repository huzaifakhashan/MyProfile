import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:profile_web_app/main.dart';

void main() {
  testWidgets('Profile page renders main sections', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const ProfileApp());

    expect(find.text('Huzaifa Abdulrahman Khashan'), findsOneWidget);
    expect(find.text('About Me'), findsOneWidget);
    expect(find.text('Skills'), findsWidgets);
  });
}
