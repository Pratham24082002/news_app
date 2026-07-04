import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(title: const Text('News App')),
        body: const Center(child: Text('Setup Complete')),
      ),
    );
  }
}
