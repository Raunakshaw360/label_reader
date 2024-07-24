import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart'; // Add this dependency to your pubspec.yaml
import '../utils/recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  final RecipeDetails recipeDetails;

  RecipeDetailPage({required this.recipeDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeDetails.title),
        backgroundColor: Color(0xFF5D7EFC),
        elevation: 0,
        toolbarHeight: kToolbarHeight,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                recipeDetails.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Ingredients:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            MarkdownBody(
              data: recipeDetails.ingredients
                  .map((ingredient) => '- $ingredient')
                  .join('\n'),
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(fontSize: 16),
                listBullet: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Instructions:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            MarkdownBody(
              data: recipeDetails.instructions,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
