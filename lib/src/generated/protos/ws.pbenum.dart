//
//  Generated code. Do not modify.
//  source: protos/ws.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class PackageKind extends $pb.ProtobufEnum {
  static const PackageKind NONE = PackageKind._(0, _omitEnumNames ? '' : 'NONE');
  static const PackageKind NEW_INSITE_NOTICE = PackageKind._(1, _omitEnumNames ? '' : 'NEW_INSITE_NOTICE');

  static const $core.List<PackageKind> values = <PackageKind> [
    NONE,
    NEW_INSITE_NOTICE,
  ];

  static final $core.Map<$core.int, PackageKind> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PackageKind? valueOf($core.int value) => _byValue[value];

  const PackageKind._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
