import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:label_scan/screens/recipe_screen.dart';
import 'news_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _showImageSourceDialog(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          actions: <Widget>[
            TextButton(
              child: const Text('Camera'),
              onPressed: () async {
                Navigator.of(context).pop();
                final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  // Handle the image from the camera
                  print('Image from camera: ${image.path}');
                }
              },
            ),
            TextButton(
              child: const Text('Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  // Handle the image from the gallery
                  print('Image from gallery: ${image.path}');
                }
              },
            ),
          ],
        );
      },
    );
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
              print('History icon pressed');
            },
          ),IconButton(
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
              }
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
                height: screenHeight / 4,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewsListScreen(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Food News",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: Color(0xFFFEB340)),
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
                  height: 200.0, // Adjust size as needed
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
                        shape: BoxShape.circle, color: Colors.white),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Color(0xFF5D7EFC),
                          size: 56,
                        ),
                        Text(
                          "Scan\nLabel",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Color(0xFF5D7EFC)),
                        )
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
