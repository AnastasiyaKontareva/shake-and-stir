import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class IngredientsListView extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientsListView({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ingredients.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              const Icon(Icons.local_bar, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: '${ingredient.measure.trim()} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ingredient.name),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}