//
//  Generated code. Do not modify.
//  source: protos/ws.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use packageKindDescriptor instead')
const PackageKind$json = {
  '1': 'PackageKind',
  '2': [
    {'1': 'NONE', '2': 0},
    {'1': 'NEW_INSITE_NOTICE', '2': 1},
  ],
};

/// Descriptor for `PackageKind`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List packageKindDescriptor = $convert.base64Decode(
    'CgtQYWNrYWdlS2luZBIICgROT05FEAASFQoRTkVXX0lOU0lURV9OT1RJQ0UQAQ==');

@$core.Deprecated('Use packageDescriptor instead')
const Package$json = {
  '1': 'Package',
  '2': [
    {'1': 'kind', '3': 1, '4': 1, '5': 14, '6': '.ws.PackageKind', '10': 'kind'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `Package`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List packageDescriptor = $convert.base64Decode(
    'CgdQYWNrYWdlEiMKBGtpbmQYASABKA4yDy53cy5QYWNrYWdlS2luZFIEa2luZBISCgRkYXRhGA'
    'IgASgMUgRkYXRh');

@$core.Deprecated('Use pushNewInsiteNoticeDescriptor instead')
const PushNewInsiteNotice$json = {
  '1': 'PushNewInsiteNotice',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `PushNewInsiteNotice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pushNewInsiteNoticeDescriptor = $convert.base64Decode(
    'ChNQdXNoTmV3SW5zaXRlTm90aWNlEhwKCXRpbWVzdGFtcBgBIAEoA1IJdGltZXN0YW1w');

