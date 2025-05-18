import 'dart:math';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum UsdFormat { k, m, b, n }

class AdaptiveDecimalDisplay extends StatelessWidget {
  factory AdaptiveDecimalDisplay.dollarPrice({
    Decimal? value,
    TextStyle? style,
    UsdFormat format = UsdFormat.n,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return AdaptiveDecimalDisplay(
      value: value,
      prefix: '\$',
      style: style,
      format: format,
      zeroValue: '0.00',
      compressZero: true,
      useSignificantFigures: true,
      fixedLength: value == null ? 2 : (value >= Decimal.one ? 2 : 4),
      alignment: alignment,
    );
  }

  factory AdaptiveDecimalDisplay.dollarValue({
    Decimal? value,
    TextStyle? style,
    UsdFormat format = UsdFormat.n,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return AdaptiveDecimalDisplay(
      value: value,
      prefix: '\$',
      style: style,
      format: format,
      zeroValue: '0.00',
      compressZero: false,
      fixedLength: value == null ? 2 : (value >= Decimal.one ? 2 : 4),
      alignment: alignment,
    );
  }

  //默认无前缀、后缀、数量级单位
  const AdaptiveDecimalDisplay({
    super.key,
    this.value,
    this.style,
    this.prefix = '',
    this.symbol = '',
    this.format = UsdFormat.n,
    this.compressZero = false,
    this.zeroValue = '0',
    this.fixedLength = 4,
    this.useSignificantFigures = false,
    this.alignment = Alignment.center,
  });

  final Decimal? value;
  final TextStyle? style;
  final UsdFormat format;
  final String prefix;
  final String symbol;
  final bool compressZero; //压缩小数点后0角标显示
  final String zeroValue;
  final int fixedLength;
  final bool useSignificantFigures;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: alignment,
      child: _DecimalText(
          key: key,
          value: value,
          style: style,
          prefix: prefix,
          symbol: symbol,
          format: format,
          zeroValue: zeroValue,
          compressZero: compressZero,
          fixedLength: fixedLength,
          useSignificantFigures: useSignificantFigures),
    );
  }
}

class _DecimalText extends StatelessWidget {
  const _DecimalText({
    super.key,
    this.value,
    this.style,
    required this.prefix,
    required this.symbol,
    required this.format,
    required this.compressZero,
    required this.zeroValue,
    required this.fixedLength,
    this.useSignificantFigures = false,
  });

  final Decimal? value;
  final TextStyle? style;
  final UsdFormat format;
  final String prefix;
  final String symbol;
  final bool compressZero;
  final bool useSignificantFigures;
  final String zeroValue;
  final int fixedLength;

  @override
  Widget build(BuildContext context) {
    final realValue = value;

    final realStyle = style;
    if (realValue == null) return Text('-', style: realStyle);

    if (realValue.isZero) {
      return Text(
        '$prefix$zeroValue$symbol',
        style: realStyle,
      );
    }

    if (realValue < Decimal.parse('0.00001') && compressZero) {
      final temp = realValue.toString().split('.');

      var index = 0;
      for (; index < temp[1].length; index++) {
        if (temp[1][index] != '0') {
          break;
        }
      }
      final remain = temp[1].replaceRange(0, index, '');
      final resultStr = remain
          .substring(0, min(remain.length, 4))
          .replaceAll(RegExp(r'0+$'), '');
      return Text.rich(
        TextSpan(
          text: '${prefix}0.0',
          children: [
            WidgetSpan(
              baseline: TextBaseline.ideographic,
              child: Transform.translate(
                offset: const Offset(0, 3),
                child: Text(
                  '$index',
                  style: realStyle?.copyWith(
                      fontSize: realStyle.fontSize == null
                          ? null
                          : realStyle.fontSize! * 2 / 3),
                ),
              ),
            ),
            TextSpan(
              text: resultStr,
            ),
            TextSpan(
              text: symbol,
            ),
          ],
        ),
        style: realStyle,
      );
    }

    var realValueStr = '-';
    if (realValue >= Decimal.fromInt(1000000000) &&
        format.index <= UsdFormat.b.index) {
      final currentValue =
          (realValue / Decimal.fromInt(1000000000)).toDecimal();
      int realFixedLength = getRealFixedLength(currentValue);
      realValueStr = '${currentValue.formatValue_(realFixedLength)}B';
    } else if (realValue >= Decimal.fromInt(1000000) &&
        format.index <= UsdFormat.m.index) {
      final currentValue = (realValue / Decimal.fromInt(1000000)).toDecimal();
      int realFixedLength = getRealFixedLength(currentValue);
      realValueStr = '${currentValue.formatValue_(realFixedLength)}M';
    } else if (realValue >= Decimal.fromInt(1000) &&
        format.index <= UsdFormat.k.index) {
      final currentValue = (realValue / Decimal.fromInt(1000)).toDecimal();
      int realFixedLength = getRealFixedLength(currentValue);
      realValueStr = '${currentValue.formatValue_(realFixedLength)}K';
    } else {
      int realFixedLength = getRealFixedLength(realValue);
      realValueStr = realValue.formatValue_(realFixedLength);
    }
    return Text('$prefix$realValueStr$symbol', style: realStyle);
  }

  int getRealFixedLength(Decimal realValue) {
    int realFixedLength = fixedLength;
    if (realValue < Decimal.one && useSignificantFigures) {
      List<String> numList = realValue.toString().split('.');
      if (numList.length == 2) {
        int leadingZerosLength = countLeadingZeros(numList[1]);
        realFixedLength += leadingZerosLength;
      }
    }
    return realFixedLength;
  }

  int countLeadingZeros(String str) {
    RegExp leadingZeros = RegExp(r'^0+');
    Match? match = leadingZeros.firstMatch(str);
    return match?.group(0)?.length ?? 0;
  }
}

extension DecimalExtension on Decimal {
  bool get isZero {
    return compareTo(Decimal.zero) == 0;
  }

  String fixed_(int fractionDigits) {
    String result;
    if (this > Decimal.fromInt(-1) && this < Decimal.one) {
      result = toStringAsPrecisionNoRound(fractionDigits);
    } else {
      result = toStringAsFixedNoRound(fractionDigits);
    }
    if (result.indexOf('.') > 0) {
      return result
          .replaceAll(RegExp(r'0+?$'), '')
          .replaceAll(RegExp(r'[.]$'), '');
    }
    return result;
  }

  String toStringAsPrecisionNoRound(int precision) {
    assert(precision > 0);

    if (this == Decimal.zero) {
      return <String>[
        '0',
        if (precision > 1) '.',
        for (var i = 1; i < precision; i++) '0',
      ].join();
    }
    final limit = Decimal.ten.pow(precision).toDecimal();
    var shift = Decimal.one;
    final absValue = abs();
    var pad = 0;
    while (absValue * shift < limit) {
      pad++;
      shift *= Decimal.ten;
    }
    while (absValue * shift >= limit) {
      pad--;
      shift = (shift / Decimal.ten).toDecimal();
    }
    final value = ((this * shift).floor() / shift).toDecimal();
    return pad <= 0 ? value.toString() : value.toStringAsFixed(pad);
  }

  String toStringAsFixedNoRound(int fractionDigits) {
    assert(fractionDigits >= 0);
    if (fractionDigits == 0) return floor().toBigInt().toString();
    final value = floor(scale: fractionDigits);
    final intPart = value.toBigInt().abs();
    final decimalPart =
        (Decimal.one + value.abs() - intPart.toDecimal()).shift(fractionDigits);
    return '${value < Decimal.zero ? '-' : ''}$intPart.${decimalPart.toString().substring(1)}';
  }

  String formatValue_([int fixedLength = 2]) {
    return NumberFormat("#,##0.${'#' * fixedLength}")
        .format(double.tryParse(fixed_(fixedLength)));
  }
}
