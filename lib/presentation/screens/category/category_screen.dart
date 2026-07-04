
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/bloc/news/news_bloc.dart';
import 'package:news_app/presentation/bloc/news/news_event.dart';
import 'package:news_app/presentation/bloc/news/news_state.dart';
import 'package:news_app/presentation/widgets/article_card.dart';
import 'package:news_app/presentation/widgets/article_shimmer.dart';

class CategoryScreen extends StatefulWidget {
  final Map<String, dynamic> category;

  const CategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<NewsBloc>().add(
      FetchNews(
        category: widget.category['apiValue'],
      ),
    );

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<NewsBloc>().add(
        LoadMoreNews(
          category: widget.category['apiValue'],
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<NewsBloc>().add(
      RefreshNews(
        category: widget.category['apiValue'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category['title']),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
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
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: state.articles.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.articles.length) {
                    return state.hasReachedMax
                        ? const SizedBox.shrink()
                        : const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final article = state.articles[index];

                  return ArticleCard(
                    article: article,
                    onTap: () {
                      // article screen navigation
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}