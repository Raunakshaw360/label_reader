import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:label_scan/screens/recipe_screen.dart';
import 'food_details_screen.dart';
import 'news_screen.dart'; // Import the new screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false; // Flag to manage loading state

  Future<void> _showImageSourceDialog(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff212121),
          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(1))),
          title: const Text('Choose Image Source',style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            TextButton(
              child: const Text('Camera',style: TextStyle(color: Colors.white),),
              onPressed: () async {
                Navigator.of(context).pop();
                final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  await _getFoodDetails(image);
                }
              },
            ),
            TextButton(
              child: const Text('Gallery',style: TextStyle(color: Colors.white),),
              onPressed: () async {
                Navigator.of(context).pop();
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  await _getFoodDetails(image);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getFoodDetails(XFile image) async {
    setState(() {
      _isLoading = true; // Start loading
    });

    const apiKey = 'AIzaSyA9AGR12qZa4q0FB5YBEBGfbOnWPaPXzLA'; // Replace with your actual API key

    if (apiKey.isEmpty) {
      // print('API Key is empty');
      setState(() {
        _isLoading = false; // Stop loading
      });
      return;
    }

    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      final prompt = TextPart("I am providing a label of food item, is the item healthy for consumption? Give it a score and also tell during which illness or disease should people not consume it? Provide answer in tabular format. Also tell if the item is vegetarian, non vegetarian or vegan or other type.");
      final imagePart = DataPart('image/jpeg', bytes);

      final response = await model.generateContent([
        Content.multi([prompt, imagePart])
      ]);

      if (response.text != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetailsScreen(
              details: response.text!,
            ),
          ),
        );
      } else {
        // print('Failed to get food details.');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to get food details.')),
          );
        }
      }
    } catch (e) {
      // print('Error occurred: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('ConverseWith Labels'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.history,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle the history icon press
              // print('History icon pressed');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.fastfood_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeListScreen(),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: kToolbarHeight,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: screenHeight / 2,
                width: screenWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/bg.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1),
                      BlendMode.dstATop,
                    ),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF5D7EFC), Color(0xFF9F4BFB)],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeListScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth / 5),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: const Color(0xFF242426),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.fastfood_rounded, color: Color(0xFFFEB340)),
                          Text(
                            'Explore Healthy Recipes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 300,
                  height: 180,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF242426),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Food News",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Color(0xFFFEB340),
                            ),
                          ),
                          Icon(Icons.open_in_new_rounded, color: Color(0xFFFEB340)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 180,
                                height: 50,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              );
                            },
                            itemCount: 5,
                            viewportFraction: 0.8,
                            scale: 0.9,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF5D7EFC), Color(0xFF9F4BFB)],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showImageSourceDialog(context),
                  child: Container(
                    height: 180.0, // Adjust size as needed
                    width: 180.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child:   Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _isLoading // Show progress indicator when loading
                            ? const CircularProgressIndicator(color: Color(0xFF5D7EFC),)
                            : const Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Color(0xFF5D7EFC),
                          size: 56,
                        ),
                        const Text(
                          "Scan\nLabel",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Color(0xFF5D7EFC),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
