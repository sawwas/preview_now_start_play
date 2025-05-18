import '../constants/common_libs.dart';
import 'app_svg.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
    this.title,
    this.titleWidget,
    this.showBackButton = true,
    this.action,
    this.collect,
    this.padding,
    this.titleStyle,
    this.themeColor,
    this.actionWidth,
    this.backButton,
    this.titleAlign,
    this.onClose,
    this.height = 52,
  });

  final String? title;
  final Widget? titleWidget;
  final bool showBackButton;
  final Widget? backButton;
  final Widget? action;
  final Widget? collect;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleStyle;
  final Color? themeColor;
  final double? actionWidth;
  final TextAlign? titleAlign;
  final VoidCallback? onClose;
  final double height;

  factory AppTitle.close({
    required String title,
    EdgeInsetsGeometry? padding,
    Color? themeColor,
  }) {
    return AppTitle(
      title: title,
      padding: padding,
      action: Tapped(
        onTap: Get.back,
        child: Icon(
          Icons.close,
          color: themeColor ?? sty.colors.black,
          size: 24,
        ),
      ),
      showBackButton: false,
      themeColor: themeColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      child: Row(
        children: [
          if (showBackButton)
            Tapped(
              onTap: onClose ?? () => Get.back(),
              child: Container(
                alignment: Alignment.centerLeft,
                width: actionWidth ?? 36,
                child: Visibility(
                  visible: showBackButton,

                  ///style: new profile
                  child:
                      backButton ??
                      AppSvg.iconBack.svg(
                        color: sty.colors.text,
                        width: 24,
                        height: 24,
                      ),
                ),
              ),
            ),
          Expanded(
            child:
                titleWidget ??
                Text(
                  title ?? '',
                  style:
                      titleStyle ??
                      ///style: new profile
                      /// 11-22 UI 调整
                      sty.text.t1Medium.copyWith(
                        // sty.text.title1Semibold.copyWith(
                        // sty.text.heading1Semibold.copyWith(
                        color: sty.colors.t1,
                      ),
                  textAlign: titleAlign ?? TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
          Row(
            children: [
              if (collect != null) collect ?? const SizedBox.shrink(),

              if (collect == null)
                SizedBox(
                  width: actionWidth ?? 24,
                  child: UnconstrainedBox(
                    child: action ?? const SizedBox.shrink(),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppCloseTitle extends StatelessWidget {
  const AppCloseTitle({
    super.key,
    this.alignment = Alignment.centerRight,
    this.onClose,
  });

  final AlignmentGeometry alignment;
  final Function? onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      alignment: alignment,
      child: Tapped(
        child: Icon(Icons.close, color: sty.colors.black, size: 32),
        onTap: () => onClose == null ? Get.back() : onClose?.call(),
      ),
    );
  }
}

class AppTopTitle extends StatelessWidget {
  const AppTopTitle({
    super.key,
    required this.leftText,
    required this.children,
  });

  final List<Widget> children;
  final String leftText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: app.paddingTop),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                leftText,
                style: sty.text.display3.copyWith(color: sty.colors.t1),
              ),
              Row(children: children),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
