import 'package:flutter/material.dart';

import 'app_scroll_behaviors.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.safeTop,
    this.safeBottom,
    this.safeLeft,
    this.safeRight,
    this.resizeToAvoidBottomInset,
  });

  final Widget child;
  final bool? safeTop;
  final bool? safeBottom;
  final bool? safeLeft;
  final bool? safeRight;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    void onFocus() {
      if (FocusManager.instance.primaryFocus?.hasFocus == true) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }

    final scaffold = Scaffold(
      // backgroundColor: sty.colors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      body: DefaultTextStyle(
        style: const TextStyle(fontSize: 14),
        // style: sty.text.bodyMedium.copyWith(color: sty.colors.text),
        child: ScrollConfiguration(
          behavior: AppScrollBehaviors(),
          child: SafeArea(
            top: safeTop ?? true,
            bottom: safeBottom ?? true,
            left: safeLeft ?? true,
            right: safeRight ?? true,

            /// https://github.com/flutter/flutter/issues/14842#issuecomment-371344881
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: child,
            ),
          ),
        ),
      ),
    );

    return KeyedSubtree(
      key: const ValueKey('AppScaffold'),
      child: GestureDetector(
        onTap: onFocus,
        child: scaffold,
      ),
    );
  }
}
