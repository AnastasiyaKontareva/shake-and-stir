import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isSmall;

  const LoadingIndicator({super.key, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    if (isSmall) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
