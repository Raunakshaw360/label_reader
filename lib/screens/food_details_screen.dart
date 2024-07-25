import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class FoodDetailsScreen extends StatelessWidget {
  final String details;

  const FoodDetailsScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Details'),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details:',
                // style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16),
              MarkdownBody(
                data: details,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
