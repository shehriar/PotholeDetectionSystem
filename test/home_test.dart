import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:pothole_detection_system/home.dart'; // Replace with your actual file path

void main() {
  getCurrentPositionButtonTest();
}

void getCurrentPositionButtonTest(){
  const MethodChannel channel = MethodChannel('flutter.baseflow.com/geolocator');

  setUp(() {
    // Set up a mock method call handler
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getCurrentPosition') {
        return {
          'latitude': 41.8743,
          'longitude': -87.6523,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'accuracy': 100.0,
          'altitude': 0.0,
          'speed': 0.0,
          'speedAccuracy': 0.0,
          'heading': 0.0,
          'floor': 0,
          'isMocked': false,
        };
      }
      return null;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  testWidgets('Test Get Current Position button', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp(home: Home()));

    // Find the Get Current Position button
    final button = find.widgetWithText(ElevatedButton, 'Get Current Location');

    // Tap the button
    await tester.tap(button);

    // Rebuild the widget to reflect the changes
    await tester.pumpAndSettle();

    expect(find.text('Address not found'), findsOneWidget);
  });
}
