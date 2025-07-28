import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../constant/colors.dart';
import '../constant/dimensions.dart';

class RotatingCircleAnimation extends StatefulWidget {
  final bool isForPaymentConfirmation;

  const RotatingCircleAnimation({super.key, required this.isForPaymentConfirmation});

  @override
  State<RotatingCircleAnimation> createState() => _RotatingCircleAnimationState();
}

class _RotatingCircleAnimationState extends State<RotatingCircleAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _tickController;
  late Animation<double> _tickScaleAnimation;
  final isAnimationCompleteSubject = BehaviorSubject<bool>.seeded(false);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _handleTimedAnimation();
    _tickController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _tickScaleAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _tickController, curve: Curves.easeInOutCirc));
  }

  @override
  void dispose() {
    _controller.dispose();
    _tickController.dispose();
    super.dispose();
  }

  void _handleTimedAnimation() async {
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      _controller.stop();
      isAnimationCompleteSubject.sink.add(true);
      _tickController.forward();
    }

    if (!widget.isForPaymentConfirmation) {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double outerRadius = deviceAvgScreenSize * 0.12523;
    double dotRadius = circleSize6px;
    double padding = commonPadding24px;
    double pathRadius = outerRadius - padding;

    return Center(
      child: SizedBox(
        width: outerRadius * 2,
        height: outerRadius * 2,
        child: StreamBuilder<bool>(
            stream: isAnimationCompleteSubject,
            builder: (context, snapIsAnimComplete) {
              bool isAnimationCompleted = snapIsAnimComplete.data ?? false;
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Circle - filled or border
                  if (!isAnimationCompleted)
                    Container(
                      width: outerRadius * 2,
                      height: outerRadius * 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (isAnimationCompleted) ? colorPrimary : Colors.transparent,
                        border: (isAnimationCompleted)
                            ? null
                            : Border.all(color: colorPrimary, width: borderSide7px),
                      ),
                    ),
                  if (isAnimationCompleted)
                    ScaleTransition(
                      scale: _tickScaleAnimation,
                      child: Container(
                        width: outerRadius * 2,
                        height: outerRadius * 2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (isAnimationCompleted) ? colorPrimary : Colors.transparent,
                          border: (isAnimationCompleted)
                              ? null
                              : Border.all(color: colorPrimary, width: borderSide7px),
                        ),
                      ),
                    ),

                  // Rotating Dot
                  if (!isAnimationCompleted)
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (_, __) {
                        double angle = _controller.value * 2 * pi;
                        double offsetX = pathRadius * cos(angle);
                        double offsetY = pathRadius * sin(angle);

                        return Transform.translate(
                          offset: Offset(offsetX, offsetY),
                          child: Container(
                            width: dotRadius * 2,
                            height: dotRadius * 2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorPrimary,
                            ),
                          ),
                        );
                      },
                    ),

                  // Tick Icon when complete & for payment confirmation
                  if (isAnimationCompleted)
                    ScaleTransition(
                      scale: _tickScaleAnimation,
                      child: Icon(
                        Icons.check,
                        color: colorWhite,
                        size: outerRadius, // adjust as needed
                      ),
                    ),
                ],
              );
            }),
      ),
    );
  }
}
