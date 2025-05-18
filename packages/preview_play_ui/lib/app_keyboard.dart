import 'package:flutter/material.dart';

import 'tapped.dart';

const _decimalInputInitialValue = '0.';

class AppKeyboard extends StatelessWidget {
  final double keyWidth;
  final double spacing;
  final double runSpacing;
  final TextStyle textStyle;
  final Widget deleteIcon;
  final ValueNotifier<String> controller;

  const AppKeyboard({
    super.key,
    required this.controller,
    required this.deleteIcon,
    this.keyWidth = 44,
    this.spacing = 72,
    this.runSpacing = 12,
    this.textStyle = const TextStyle(
      color: Color(0xFF222222),
      fontSize: 42,
      height: 1.2,
      fontWeight: FontWeight.w600,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: keyWidth * 3 + spacing * 2,
      child: Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: _KeyType.values
            .map((e) => _ItemKey(
                  type: e,
                  onKeyTap: _onKeyTap,
                  style: textStyle,
                  deleteIcon: deleteIcon,
                  width: keyWidth,
                ))
            .toList(),
      ),
    );
  }

  _onKeyTap(_KeyType type) {
    final inputText = controller.value;
    switch (type) {
      case _KeyType.one:
      case _KeyType.two:
      case _KeyType.three:
      case _KeyType.four:
      case _KeyType.five:
      case _KeyType.six:
      case _KeyType.seven:
      case _KeyType.eight:
      case _KeyType.nine:
        controller.value = inputText + type.text;
        break;
      case _KeyType.zero:
        if (inputText.isEmpty) {
          controller.value = _decimalInputInitialValue;
        } else {
          controller.value = inputText + type.text;
        }
        break;
      case _KeyType.dot:
        if (inputText.isEmpty) {
          controller.value = _decimalInputInitialValue;
        } else if (!inputText.contains('.')) {
          controller.value = '$inputText.';
        }
        break;
      case _KeyType.delete:
        if (inputText.isNotEmpty) {
          if (inputText == _decimalInputInitialValue) {
            controller.value = '';
          } else {
            controller.value = inputText.substring(0, inputText.length - 1);
          }
        }
        break;
    }
  }
}

class AppInputDisplay extends StatelessWidget {
  final String text;
  final String? prefixText;
  final String? suffixText;
  final String hintText;
  final double maxWidth;
  final double minHeight;
  final TextStyle textStyle;
  final TextStyle hintTextStyle;
  final Widget? cursor;

  const AppInputDisplay({
    super.key,
    required this.text,
    this.prefixText,
    this.suffixText,
    this.cursor,
    this.maxWidth = 240,
    this.minHeight = 62,
    this.hintText = '0',
    this.textStyle = const TextStyle(
      color: Color(0xFF222222),
      fontSize: 42,
      height: 1.2,
      fontWeight: FontWeight.w600,
    ),
    this.hintTextStyle = const TextStyle(
      color: Color(0xFFDFDFE8),
      fontSize: 42,
      height: 1.2,
      fontWeight: FontWeight.w500,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth, minHeight: minHeight),
      child: FittedBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixText != null) Text(prefixText!, style: hintTextStyle),
            if (prefixText != null) const SizedBox(width: 2),
            Text(
              text.isEmpty ? hintText : text,
              style: text.isEmpty ? hintTextStyle : textStyle,
            ),
            if (text.isNotEmpty)
              cursor ??
                  Container(
                    width: 2,
                    height: 42,
                    color: const Color(0xFF222222),
                  ),
            const SizedBox(width: 8),
            if (suffixText != null) Text(suffixText!, style: hintTextStyle),
          ],
        ),
      ),
    );
  }
}

enum _KeyType {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  dot,
  zero,
  delete;

  get text {
    if (index < 9) {
      return '${index + 1}';
    } else if (index == 9) {
      return '.';
    } else if (index == 10) {
      return "0";
    }
    return 'delete';
  }
}

class _ItemKey extends StatelessWidget {
  final _KeyType type;
  final TextStyle style;
  final Widget deleteIcon;
  final double width;
  final ValueSetter<_KeyType> onKeyTap;

  const _ItemKey(
      {required this.type,
      required this.onKeyTap,
      required this.style,
      required this.deleteIcon,
      required this.width});

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (type) {
      case _KeyType.one:
      case _KeyType.two:
      case _KeyType.three:
      case _KeyType.four:
      case _KeyType.five:
      case _KeyType.six:
      case _KeyType.seven:
      case _KeyType.eight:
      case _KeyType.nine:
      case _KeyType.zero:
      case _KeyType.dot:
        child = Text(type.text, textAlign: TextAlign.center, style: style);
        break;
      case _KeyType.delete:
        child = deleteIcon;
        break;
    }

    return Tapped(
      onTap: () => onKeyTap(type),
      child: SizedBox(
        width: width,
        child: child,
      ),
    );
  }
}
