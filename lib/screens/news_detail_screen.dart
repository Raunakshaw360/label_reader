import 'package:flutter/material.dart';
import '../utils/news.dart'; // Adjust import path

class NewsDetailPage extends StatelessWidget {
  final NewsArticle article;

  NewsDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
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
          // Determine the screen width
          final isWideScreen = constraints.maxWidth > 800; // Adjust threshold as needed

          return Padding(
            padding: EdgeInsets.all(isWideScreen ? 32.0 : 16.0), // Adjust padding for large screens
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (article.urlToImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        article.urlToImage!,
                        width: double.infinity,
                        height: isWideScreen ? 400 : 200, // Adjust image height for large screens
                        fit: BoxFit.cover,
                      ),
                    ),
                  SizedBox(height: isWideScreen ? 32.0 : 16.0), // Adjust spacing for large screens
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: isWideScreen ? 36.0 : 24.0, // Adjust font size for large screens
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    article.description,
                    style: TextStyle(
                      fontSize: isWideScreen ? 20.0 : 16.0, // Adjust font size for large screens
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
