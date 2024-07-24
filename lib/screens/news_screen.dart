import 'package:flutter/material.dart';
import '../utils/news.dart'; // Adjust import path
import 'news_detail_screen.dart'; // Adjust import path

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<NewsArticle>> _newsArticles;
  final NewsService _newsService = NewsService();

  @override
  void initState() {
    super.initState();
    _newsArticles = _newsService.fetchFoodNews(); // Fetch food-related news
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food News'),
        backgroundColor: Color(0xFF5D7EFC),
        elevation: 0,
        toolbarHeight: kToolbarHeight,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: _newsArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No food news available'));
          }

          final articles = snapshot.data!;

          return ListView.separated(
            itemCount: articles.length,
            separatorBuilder: (context, index) => Divider(
              height: 1.0,
              color: Colors.grey[300],
            ),
            itemBuilder: (context, index) {
              final article = articles[index];
              return ListTile(
                contentPadding: EdgeInsets.all(8.0),
                leading: article.urlToImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    article.urlToImage!,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                )
                    : null,
                title: Text(
                  article.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(article.description),
                isThreeLine: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailPage(article: article),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
