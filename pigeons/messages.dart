// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

// flutter pub run pigeon --input pigeons/messages.dart --package_name=preview_play

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/app/src/main/kotlin/com/previewplay/preview_play/Messages.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/Messages.swift',
  dartPackageName: 'preview_play',
  swiftOptions: SwiftOptions(),
  copyrightHeader: 'pigeons/copyright.txt',
))

// A simple data class that will be passed between Flutter and native platforms
class User {
  final String? name;
  final int? age;
  final String? email;

  const User({this.name, this.age, this.email});
}

// A simple response class
class ApiResponse {
  final bool? success;
  final String? message;
  final User? user;

  const ApiResponse({this.success, this.message, this.user});
}

// The API that will be implemented on the native side and called from Flutter
@HostApi()
abstract class UserApi {
  // Get user information from the native side
  User getUser();
  
  // Save user information to the native side
  ApiResponse saveUser(User user);
}

// The API that will be implemented on the Flutter side and called from native
@FlutterApi()
abstract class UserCallbackApi {
  // Notify Flutter when user data changes on the native side
  void onUserChanged(User user);
}
