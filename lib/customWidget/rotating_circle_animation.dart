import 'dart:math';
import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';

import '../constant/dimensions.dart';

class RotatingCircleAnimation extends StatefulWidget {
  const RotatingCircleAnimation({super.key});

  @override
  State<RotatingCircleAnimation> createState() => _RotatingCircleAnimationState();
}

class _RotatingCircleAnimationState extends State<RotatingCircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _handleTimedAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTimedAnimation() async {
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      _controller.stop();
    }
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double outerRadius = deviceAvgScreenSize * 0.12523;
    double dotRadius = circleSize6px;
    double padding = commonPadding20px;
    double pathRadius = outerRadius - padding;

    return Center(
      child: SizedBox(
        width: outerRadius * 2,
        height: outerRadius * 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer Circle
            Container(
              width: outerRadius * 2,
              height: outerRadius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colorPrimary, width: borderSide7px),
              ),
            ),

            // Rotating Dot Inside Circle
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
          ],
        ),
      ),
    );
  }
}
