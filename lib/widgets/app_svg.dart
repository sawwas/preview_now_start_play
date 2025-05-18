import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvg {
  final String svgXml;

  const AppSvg._(this.svgXml);

  static const AppSvg iconBack = AppSvg._('''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M10.639 11.9993L16.4724 6.16605L14.8057 4.49939L7.30566 11.9993L14.8057 19.4994L16.4724 17.8327L10.639 11.9993Z" fill="#ffffff"/>
</svg>

''');

  Widget svg({
    Key? key,
    double? size,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    ui.ColorFilter? colorFilter,
    SvgTheme? theme,
    Color? color,
  }) {
    return SvgPicture.string(
      svgXml,
      width: width ?? size,
      height: height ?? size,
      fit: fit,
      alignment: alignment,
      colorFilter: colorFilter,
      color: color,
      theme: theme,
    );
  }
}
