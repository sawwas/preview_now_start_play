// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

// flutter pub run pigeon --input pigeons/messages.dart --package_name=preview_play

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/snappy_android.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/app/src/main/kotlin/com/previewplay/preview_play/SnappyAndroid.kt',
    kotlinOptions: KotlinOptions(),
    swiftOut: 'ios/Runner/SnappyiOS.swift',
    swiftOptions: SwiftOptions(),
    dartPackageName: 'preview_play',
    copyrightHeader: 'pigeons/copyright.txt',
  ),
)
// A simple data class that will be passed between Flutter and native platforms
class SnappyData {
  final Uint8List? data;

  const SnappyData({this.data});
}

// A simple response class
class SnappyResponse {
  final bool? success;
  final String? message;
  final SnappyData? sd;

  const SnappyResponse({this.success, this.message, this.sd});
}

// The API that will be implemented on the native side and called from Flutter
@HostApi()
abstract class SnappyApi {
  // Get user information from the native side
  SnappyData getMaxCompressedLength();

  // SnappyData isValidCompressedBuffer();

  // Save user information to the native side
  SnappyResponse compress(SnappyData data);
}

// The API that will be implemented on the Flutter side and called from native
@FlutterApi()
abstract class SnappyNativeCallbackApi {
  // Notify Flutter when user data changes on the native side
  void onUncompress(SnappyData data);
}
