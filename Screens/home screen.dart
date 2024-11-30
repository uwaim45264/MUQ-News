import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../NewsSearchDelegate.dart';
import '../providers/news_provider.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String lastQuery = 'breaking news';

  Future<void> _refreshNews() async {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    await newsProvider.fetchNews(lastQuery.isEmpty ? 'breaking news' : lastQuery);
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MUQ NEWS',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => showSearch(
              context: context,
              delegate: NewsSearchDelegate(
                performSearch: (query) {
                  setState(() => lastQuery = query);
                  newsProvider.fetchNews(query);
                },
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent,
                Colors.black,
                Colors.blueAccent,
                Colors.yellow,
                Colors.black,
                Colors.blueAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: newsProvider.isLoading
            ? _buildLoadingState()
            : newsProvider.articles.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(12.0),
          itemCount: newsProvider.articles.length,
          itemBuilder: (context, index) {
            final article = newsProvider.articles[index];
            return _buildArticleCard(article, context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        },
        tooltip: 'Scroll to top',
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: const SizedBox(
              height: 150,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 100, color: Colors.black),
          SizedBox(height: 16.0),
          Text(
            'No articles found!',
            style: TextStyle(fontSize: 18.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(article, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(article: article),
          ),
        );
      },
      child: Hero(
        tag: article.title,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
                child: Stack(
                  children: [
                    article.imageUrl.isNotEmpty
                        ? Image.network(
                      article.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                    )
                        : const Icon(
                      Icons.image_not_supported,
                      size: 100,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                        child: Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  article.description,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
