import 'package:flutter/material.dart';

class InstructionsView extends StatelessWidget {
  final String instructions;

  const InstructionsView({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    // Improve readability by splitting instructions into steps.
    final steps =
        instructions
            .split(RegExp(r'\.\s*'))
            .where((s) => s.trim().isNotEmpty)
            .toList();

    return ListView.builder(
      itemCount: steps.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1}.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${steps[index]}.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
