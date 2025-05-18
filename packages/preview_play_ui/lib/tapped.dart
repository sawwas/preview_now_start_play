import 'package:flutter/material.dart';

class Tapped extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final bool? animateEnable;

  const Tapped({
    super.key,
    this.onTap,
    this.onLongTap,
    this.child,
    this.animateEnable,
  });

  @override
  TappedState createState() => TappedState();
}

class TappedState extends State<Tapped> with TickerProviderStateMixin {
  bool _isChangeAlpha = false;

  AnimationController? _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(value: 1, vsync: this);
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOutCubic,
    );
    _animation.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  bool _tapDown = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = const Duration(milliseconds: 50);
    Duration showDuration = const Duration(milliseconds: 660);

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongTap,
      onTapDown: (detail) async {
        _tapDown = true;
        _isChangeAlpha = true;
        if (widget.animateEnable ?? true) {
          await _controller!.animateTo(0.4, duration: duration);
          if (!_tapDown) {
            await _controller!.animateTo(1, duration: showDuration);
          }
        }
        _tapDown = false;
        _isChangeAlpha = false;
      },
      onTapUp: (detail) async {
        _tapDown = false;
        if (_isChangeAlpha == true) {
          return;
        }
        if (widget.animateEnable ?? true) {
          await _controller!.animateTo(1, duration: showDuration);
        }
        _isChangeAlpha = false;
      },
      onTapCancel: () async {
        _tapDown = false;
        if (widget.animateEnable ?? true) {
          _controller!.value = 1;
        }
        _isChangeAlpha = false;
      },
      child: AnimatedOpacity(
        opacity: _animation.value,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
        child: Container(
          color: const Color(0x00FFFFFF),
          child: widget.child,
        ),
      ),
    );
  }
}
