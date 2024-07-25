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
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine if the screen width is wide
          final isWideScreen = constraints.maxWidth > 800; // Adjust this threshold as needed

          return Padding(
            padding: EdgeInsets.all(isWideScreen ? 32.0 : 16.0), // Adjust padding for wide screens
            child: ListView(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    recipeDetails.imageUrl,
                    width: double.infinity,
                    height: isWideScreen ? 400 : 200, // Adjust image height for wide screens
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: isWideScreen ? 32.0 : 16.0), // Adjust spacing for wide screens
                Text(
                  'Ingredients:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isWideScreen ? 24.0 : 18.0, // Adjust font size for wide screens
                  ),
                ),
                SizedBox(height: 8.0),
                MarkdownBody(
                  data: recipeDetails.ingredients
                      .map((ingredient) => '- $ingredient')
                      .join('\n'),
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(fontSize: isWideScreen ? 18.0 : 16.0), // Adjust text size for wide screens
                    listBullet: TextStyle(fontSize: isWideScreen ? 18.0 : 16.0), // Adjust text size for wide screens
                  ),
                ),
                SizedBox(height: isWideScreen ? 32.0 : 16.0), // Adjust spacing for wide screens
                Text(
                  'Instructions:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isWideScreen ? 24.0 : 18.0, // Adjust font size for wide screens
                  ),
                ),
                SizedBox(height: 8.0),
                MarkdownBody(
                  data: recipeDetails.instructions,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(fontSize: isWideScreen ? 18.0 : 16.0), // Adjust text size for wide screens
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
