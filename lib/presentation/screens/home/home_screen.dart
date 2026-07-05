import 'package:flutter/material.dart';
import 'package:news_app/core/routes/app_routes.dart';
import 'package:news_app/presentation/widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Top Headlines',
      'apiValue': 'general',
      'icon': Icons.article,
    },
    {
      'title': 'Business',
      'apiValue': 'business',
      'icon': Icons.business,
    },
    {
      'title': 'Technology',
      'apiValue': 'technology',
      'icon': Icons.computer,
    },
    {
      'title': 'Sports',
      'apiValue': 'sports',
      'icon': Icons.sports_soccer,
    },
    {
      'title': 'Entertainment',
      'apiValue': 'entertainment',
      'icon': Icons.movie,
    },
    {
      'title': 'Health',
      'apiValue': 'health',
      'icon': Icons.favorite,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('NewsPulse'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.search,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              const Text(
                'Discover Latest News',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Text(
                'Browse by category',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(
                      title: category['title'],
                      icon: category['icon'],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.category,
                          arguments: category,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
