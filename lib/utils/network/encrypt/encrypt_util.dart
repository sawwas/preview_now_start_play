import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptUtil {
  static final EncryptUtil _instance = EncryptUtil._internal();

  factory EncryptUtil() => _instance;

  EncryptUtil._internal();

  String decryptAesCbc(String encryptedHex, String keyBase64, String ivBase64) {
    // Base64解码密钥和IV
    final keyBytes = base64.decode(keyBase64);
    final ivBytes = base64.decode(ivBase64);

    // 创建密钥和IV
    final key = encrypt.Key(keyBytes);
    final iv = encrypt.IV(ivBytes);

    // 将十六进制字符串转换为字节
    final encryptedBytes = hexToBytes(encryptedHex);

    // 创建AES加密器，使用CBC模式和PKCS7填充
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );

    // 解密
    final decrypted = encrypter.decrypt64(
      base64.encode(encryptedBytes),
      iv: iv,
    );
    return decrypted;
  }

  // 十六进制字符串转字节数组
  Uint8List hexToBytes(String hex) {
    var result = Uint8List(hex.length ~/ 2);
    for (var i = 0; i < hex.length; i += 2) {
      result[i ~/ 2] = int.parse(hex.substring(i, i + 2), radix: 16);
    }
    return result;
  }
}
