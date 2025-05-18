
import 'package:preview_play/src/features/data/models/response_model.dart';

extension ResponseModelExtension on ResponseModel {
  bool get success => code == 200;
}
