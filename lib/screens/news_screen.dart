import 'package:flutter/material.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of news items
    final List<String> newsItems = List.generate(20, (index) => 'News Item $index');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food News'),
        backgroundColor: Color(0xFFFEB340),
        elevation: 0,
        toolbarHeight: kToolbarHeight,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(newsItems[index]),
            leading: Icon(Icons.article, color: Colors.blue),
            onTap: () {
              // Handle news item tap
              print('Tapped on ${newsItems[index]}');
            },
          );
        },
      ),
    );
  }
}
