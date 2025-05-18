import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:oktoast/oktoast.dart';

import 'earn_eth_toasts.dart';

const veryShortDuration = Duration(milliseconds: 2300); // theme.duration : 2300
const shortDuration = Duration(milliseconds: 3000);
const longDuration = Duration(milliseconds: 5000);

enum ToastType { info, success, warn, error, loading, none }

class ToastV2 {
  static void show(
    String message, {
    String? subtitle,
    ToastType? type,
    Duration? duration,
    VoidCallback? onTap,
    Widget? subWidget,
    bool? dismissOtherToast,
    TextStyle? textStyle,
  }) {
    ToastFuture? toastFuture;
    bool isDismiss = false;

    void onDismiss() {
      if (!isDismiss) {
        if (toastFuture?.dismissed == false) {
          toastFuture?.dismiss(showAnim: true);
        }
        isDismiss = true;
      }
    }

    Widget widget = ToastWidgetV2(
      message,
      type: type ?? ToastType.info,
      subtitle: subtitle,
      onDismiss: onDismiss,
      subWidget: subWidget,
      textStyle: textStyle,
      onTap: () {
        ///评论通知 - 点击可关闭
        onDismiss();
        if (onTap != null) {
          onTap();
        }
      },
    );
    final showDuration = duration ?? veryShortDuration;
    toastFuture = showToastWidget(
      widget,
      handleTouch: true,
      animationDuration: const Duration(milliseconds: 240),
      dismissOtherToast: dismissOtherToast,
      duration: showDuration,
      animationBuilder: (context, child, animation, _) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(animation),
            child: child,
          ),
        );
      },
    );
    Future.delayed(showDuration, onDismiss);
  }

  static void showSuccess(String message, {Duration? duration}) {
    show(message, type: ToastType.success, duration: duration);
  }

  static void showWarn(String message, {Duration? duration}) {
    show(message, type: ToastType.warn, duration: duration);
  }

  static void showError(String message, {Duration? duration}) {
    show(message, type: ToastType.error, duration: duration);
  }

  static void showEarnETHToast(String message) {
    ToastFuture? toastFuture;
    bool isDismiss = false;

    void onDismiss() {
      if (!isDismiss) {
        toastFuture?.dismiss(showAnim: true);
        isDismiss = true;
      }
    }

    toastFuture = showToastWidget(
      Dismissible(
        key: Key('earn_eth_message_${DateTime.now().millisecond}'),
        onDismissed: (_) => onDismiss(),
        child: ToastEarnETHWidgets(message, onDismissed: () => onDismiss()),
      ),
      handleTouch: true,
      duration: Duration.zero,
      position: const ToastPosition(align: Alignment.topCenter, offset: 0.0),
    );
    Future.delayed(longDuration, onDismiss);
  }

  static void showTransactionSubmitted(String txHash) {
    ToastFuture? toastFuture;
    toastFuture = showToastWidget(
      ToastWidgetV2(
        '',
        // '${str.transactionToastTitle}, ${str.transactionToastDes}',
        type: ToastType.loading,
        onDismiss: () {
          toastFuture?.dismiss();
        },
      ),
      handleTouch: true,
      animationDuration: const Duration(milliseconds: 240),
      dismissOtherToast: true,
      duration: const Duration(seconds: 5),
      animationBuilder: (context, child, animation, _) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(animation),
            child: child,
          ),
        );
      },
    );
  }

  static void showTransactionCompleted({
    required String txHash,
    required String explorerUrl,
    required bool success,
    String? fromTokenName,
    String? toTokenName,
    Decimal? fromAmount,
    Decimal? toAmount,
  }) {
    String message = '';
    if (toAmount == null) {
      //  send 交易 暂时这样处理
      message =
          '${success ? 'Successfully traded $fromAmount$fromTokenName' : 'Transaction failed'}!';
    } else {
      message = '${success ? 'Successfully traded $fromAmount$fromTokenName '
          'for $toAmount $toTokenName' : 'Transaction failed'}!';
    }

    show(
      message,
      subtitle: 'Check on Explorer',
      // subtitle: 'Tap to view the transaction',
      type: success ? ToastType.success : ToastType.error,

      ///交易tost，提交成功和交易成功/失败
      duration: const Duration(seconds: 5),
      // duration: Duration(milliseconds: 3000),
      dismissOtherToast: true,
      onTap: () {
        // LaunchUtils.launchTransaction(txHash, explorerUrl: explorerUrl);
      },
    );
  }
}

class ToastWidgetV2 extends StatelessWidget {
  const ToastWidgetV2(this.message,
      {super.key,
      this.subtitle,
      this.type = ToastType.success,
      this.onDismiss,
      this.onTap,
      this.subWidget,
      this.textStyle});

  final VoidCallback? onDismiss;
  final VoidCallback? onTap;
  final String message;
  final String? subtitle;
  final ToastType type;
  final Widget? subWidget;
  final TextStyle? textStyle;

  Color get backgroundColor {
    return Colors.white;
    // return sty.colors.t1;
    // switch (type) {
    //   case ToastType.info:
    //     return sty.colors.neutral9;
    //   case ToastType.success:
    //     return app.currentThemeModel.value.isDark() ? const Color(0xff0A5737) : const Color(0xFFEDFBF5);
    //   case ToastType.warn:
    //     return  const Color(0xFFFFF4E4);
    //   case ToastType.error:
    //     return app.currentThemeModel.value.isDark() ? Color(0xff660C23) : const Color(0xFFFEEEF3);
    // }
  }

  Widget get icon {
    switch (type) {
      case ToastType.info:
      // return TomoSvg.infoTip.svg(size: 24);
      case ToastType.success:
      // return app.currentThemeModel.value.isDark()
      //     ? TomoSvg.swapSubmitSuccessDarkIcon.svg(size: 18)
      //     : TomoSvg.swapSubmitSuccessLightIcon.svg(size: 18);
      // return TomoSvg.successTip.svg(size: 24);
      case ToastType.warn:
      // return TomoSvg.warnTip.svg(size: 24);
      case ToastType.error:
      // return TomoSvg.errorTip.svg(size: 24, color: Color(0xFFEB4B6D));
      case ToastType.loading:
      // return app.currentThemeModel.value.isDark()
      //     ? TomoSvg.swapSubmitDarkIcon.svg(size: 17)
      //     : TomoSvg.swapSubmitLightIcon.svg(size: 17);
      case ToastType.none:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (_) {
        onDismiss?.call();
      },
      onTap: onTap,
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Material(
              elevation: 4.0,
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: subtitle == null
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin:
                                EdgeInsets.only(top: subtitle != null ? 1 : 0),
                            child: icon),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(message,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: textStyle
                              // ??
                              // sty.text.t3Medium.copyWith(
                              //   color: sty.colors.bg1,
                              // ),
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: type == ToastType.success ? 26 : 24 + 8,
                        ),
                        if (subWidget != null) Expanded(child: subWidget!),
                        if (subtitle != null)
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Row(
                              children: [
                                Text(
                                  subtitle!,
                                  // style: sty.text.t5Regular.copyWith(
                                  //   color: Color(0xFF4989FF),
                                  //   fontSize: 13
                                  // ),
                                ),
                                if (type == ToastType.success ||
                                    type == ToastType.error)
                                  Container(
                                    margin: const EdgeInsets.only(left: 2),
                                    // child: TomoSvg
                                    //     .swapSubmitSuccessArrowDarkIcon
                                    //     .svg(size: 17),
                                  )
                              ],
                            ),
                          ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ).animate(),
      ),
    );
  }
}
