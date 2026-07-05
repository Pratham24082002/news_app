import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/routes/app_routes.dart';
import 'package:news_app/presentation/bloc/news/news_bloc.dart';
import 'package:news_app/presentation/bloc/news/news_event.dart';
import 'package:news_app/presentation/bloc/news/news_state.dart';
import 'package:news_app/presentation/widgets/article_card.dart';
import 'package:news_app/domain/entities/article.dart';
import 'package:news_app/presentation/widgets/article_shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 500),
          () {
        context.read<NewsBloc>().add(
          SearchNews(query: value),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: "Search latest news...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsInitial) {
                    return const Center(
                      child: Text(
                        "Start typing to search...",
                      ),
                    );
                  }

                  if (state is NewsLoading) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const ArticleShimmer();
                      },
                    );
                  }

                  if (state is NewsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  if (state is NewsLoaded) {
                    if (state.articles.isEmpty) {
                      return const Center(
                        child: Text(
                          "No articles found.",
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.articles.length,
                      itemBuilder: (_, index) {
                        final Article article =
                        state.articles[index];

                        return Padding(
                          padding:
                          const EdgeInsets.only(bottom: 12),
                          child: ArticleCard(
                            article: article,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.article,
                                arguments: article,
                              );
                            },
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}