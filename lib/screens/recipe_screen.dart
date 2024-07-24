import 'package:flutter/material.dart';
import 'package:label_scan/screens/recipe_detail_screen.dart';

import '../utils/recipe.dart';

class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late Future<List<Recipe>> _recipes;
  final RecipeService recipeService = RecipeService();
  String _diet = ''; // Can be 'vegetarian', 'non-vegetarian', 'vegan', or ''
  String _query = ''; // Search query
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text;
        _fetchRecipes();
      });
    });
  }

  void _fetchRecipes() {
    setState(() {
      _recipes = recipeService.fetchRecipes(
        _query,
        diet: _diet.isNotEmpty ? _diet : null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        backgroundColor: Color(0xFF5D7EFC),
        elevation: 0,
        toolbarHeight: kToolbarHeight,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for recipes...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.search, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Diet:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: _diet.isEmpty ? null : _diet,
                  items: [
                    DropdownMenuItem(value: '', child: Text('All')),
                    DropdownMenuItem(value: 'vegetarian', child: Text('Vegetarian')),
                    DropdownMenuItem(value: 'non-vegetarian', child: Text('Non-Vegetarian')),
                    DropdownMenuItem(value: 'vegan', child: Text('Vegan')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _diet = value ?? '';
                      _fetchRecipes();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: _recipes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No recipes found'));
                } else {
                  final recipes = snapshot.data!;
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[300]),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            recipe.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(recipe.title, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Tap for details', style: TextStyle(color: Colors.grey[600])),
                        onTap: () async {
                          final recipeDetails = await recipeService.fetchRecipeDetails(recipe.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailPage(recipeDetails: recipeDetails),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
