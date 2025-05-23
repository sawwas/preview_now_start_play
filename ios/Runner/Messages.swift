// // Copyright 2023 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
// Autogenerated from Pigeon (v25.3.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif



private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let pigeonError = error as? PigeonError {
    return [
      pigeonError.code,
      pigeonError.message,
      pigeonError.details,
    ]
  }
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func createConnectionError(withChannelName channelName: String) -> PigeonError {
  return PigeonError(code: "channel-error", message: "Unable to establish connection on channel: '\(channelName)'.", details: "")
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

func deepEqualsMessages(_ lhs: Any?, _ rhs: Any?) -> Bool {
  let cleanLhs = nilOrValue(lhs) as Any?
  let cleanRhs = nilOrValue(rhs) as Any?
  switch (cleanLhs, cleanRhs) {
  case (nil, nil):
    return true

  case (nil, _), (_, nil):
    return false

  case is (Void, Void):
    return true

  case let (cleanLhsHashable, cleanRhsHashable) as (AnyHashable, AnyHashable):
    return cleanLhsHashable == cleanRhsHashable

  case let (cleanLhsArray, cleanRhsArray) as ([Any?], [Any?]):
    guard cleanLhsArray.count == cleanRhsArray.count else { return false }
    for (index, element) in cleanLhsArray.enumerated() {
      if !deepEqualsMessages(element, cleanRhsArray[index]) {
        return false
      }
    }
    return true

  case let (cleanLhsDictionary, cleanRhsDictionary) as ([AnyHashable: Any?], [AnyHashable: Any?]):
    guard cleanLhsDictionary.count == cleanRhsDictionary.count else { return false }
    for (key, cleanLhsValue) in cleanLhsDictionary {
      guard cleanRhsDictionary.index(forKey: key) != nil else { return false }
      if !deepEqualsMessages(cleanLhsValue, cleanRhsDictionary[key]!) {
        return false
      }
    }
    return true

  default:
    // Any other type shouldn't be able to be used with pigeon. File an issue if you find this to be untrue.
    return false
  }
}

func deepHashMessages(value: Any?, hasher: inout Hasher) {
  if let valueList = value as? [AnyHashable] {
     for item in valueList { deepHashMessages(value: item, hasher: &hasher) }
     return
  }

  if let valueDict = value as? [AnyHashable: AnyHashable] {
    for key in valueDict.keys { 
      hasher.combine(key)
      deepHashMessages(value: valueDict[key]!, hasher: &hasher)
    }
    return
  }

  if let hashableValue = value as? AnyHashable {
    hasher.combine(hashableValue.hashValue)
  }

  return hasher.combine(String(describing: value))
}

    

/// Generated class from Pigeon that represents data sent in messages.
struct User: Hashable {
  var name: String? = nil
  var age: Int64? = nil
  var email: String? = nil


  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> User? {
    let name: String? = nilOrValue(pigeonVar_list[0])
    let age: Int64? = nilOrValue(pigeonVar_list[1])
    let email: String? = nilOrValue(pigeonVar_list[2])

    return User(
      name: name,
      age: age,
      email: email
    )
  }
  func toList() -> [Any?] {
    return [
      name,
      age,
      email,
    ]
  }
  static func == (lhs: User, rhs: User) -> Bool {
    return deepEqualsMessages(lhs.toList(), rhs.toList())  }
  func hash(into hasher: inout Hasher) {
    deepHashMessages(value: toList(), hasher: &hasher)
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct ApiResponse: Hashable {
  var success: Bool? = nil
  var message: String? = nil
  var user: User? = nil


  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> ApiResponse? {
    let success: Bool? = nilOrValue(pigeonVar_list[0])
    let message: String? = nilOrValue(pigeonVar_list[1])
    let user: User? = nilOrValue(pigeonVar_list[2])

    return ApiResponse(
      success: success,
      message: message,
      user: user
    )
  }
  func toList() -> [Any?] {
    return [
      success,
      message,
      user,
    ]
  }
  static func == (lhs: ApiResponse, rhs: ApiResponse) -> Bool {
    return deepEqualsMessages(lhs.toList(), rhs.toList())  }
  func hash(into hasher: inout Hasher) {
    deepHashMessages(value: toList(), hasher: &hasher)
  }
}

private class MessagesPigeonCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 129:
      return User.fromList(self.readValue() as! [Any?])
    case 130:
      return ApiResponse.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class MessagesPigeonCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? User {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? ApiResponse {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class MessagesPigeonCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return MessagesPigeonCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return MessagesPigeonCodecWriter(data: data)
  }
}

class MessagesPigeonCodec: FlutterStandardMessageCodec, @unchecked Sendable {
  static let shared = MessagesPigeonCodec(readerWriter: MessagesPigeonCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol UserApi {
  func getUser() throws -> User
  func saveUser(user: User) throws -> ApiResponse
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class UserApiSetup {
  static var codec: FlutterStandardMessageCodec { MessagesPigeonCodec.shared }
  /// Sets up an instance of `UserApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: UserApi?, messageChannelSuffix: String = "") {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    let getUserChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.preview_play.UserApi.getUser\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getUserChannel.setMessageHandler { _, reply in
        do {
          let result = try api.getUser()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getUserChannel.setMessageHandler(nil)
    }
    let saveUserChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.preview_play.UserApi.saveUser\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      saveUserChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let userArg = args[0] as! User
        do {
          let result = try api.saveUser(user: userArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      saveUserChannel.setMessageHandler(nil)
    }
  }
}
/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol UserCallbackApiProtocol {
  func onUserChanged(user userArg: User, completion: @escaping (Result<Void, PigeonError>) -> Void)
}
class UserCallbackApi: UserCallbackApiProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  private let messageChannelSuffix: String
  init(binaryMessenger: FlutterBinaryMessenger, messageChannelSuffix: String = "") {
    self.binaryMessenger = binaryMessenger
    self.messageChannelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
  }
  var codec: MessagesPigeonCodec {
    return MessagesPigeonCodec.shared
  }
  func onUserChanged(user userArg: User, completion: @escaping (Result<Void, PigeonError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.preview_play.UserCallbackApi.onUserChanged\(messageChannelSuffix)"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([userArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(PigeonError(code: code, message: message, details: details)))
      } else {
        completion(.success(()))
      }
    }
  }
}
