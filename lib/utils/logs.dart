import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../env/config.dart';

final logger = Logger(
  level: kDebugMode ? Level.info : (config.isProd ? Level.off : Level.info),
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);
