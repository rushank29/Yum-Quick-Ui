import 'package:flutter/material.dart';

import '../utils/wavy_border.dart';

class WavyCurveScreen extends StatelessWidget {
  const WavyCurveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Text(
              'This text fits neatly above the container. Watch out with the left margin right above it though!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                shape: const WavyBorder(radius: 32),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Look at that pretty wavy border above here!',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
