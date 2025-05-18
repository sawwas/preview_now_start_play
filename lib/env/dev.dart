import 'config.dart';

class DConfig extends BaseConfig {
  @override
  String get stripePublishableKey => 'pk_test_51N4v2fK0x1X3Y5g7J6';

  @override
  String get appBackendAddress => 'http://43.199.222.3:8000/api/';

  @override
  String get appBackendSocket => 'ws://43.199.222.3:8000/wskio';

  @override
  String get ivBase64 => 'pQl8nTdZ4WcK7bE2vH1xSg==';

  @override
  String get keyBase64 => '9Yg9Lk2qRfX7sP1mNv6jBw==';
}
