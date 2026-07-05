import 'package:flutter/material.dart';
import 'package:news_app/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _positionAnimation = Tween<double>(
      begin: -110,
      end: 110,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      _controller.stop();

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDottedLine() {
    return SizedBox(
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          30,
          (index) => Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.white38,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1565C0),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),

              const Icon(
                Icons.newspaper_rounded,
                color: Colors.white,
                size: 90,
              ),

              const SizedBox(height: 20),

              const Text(
                'NewsPulse',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Stay Updated Anytime',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const Spacer(),

              SizedBox(
                width: 280,
                height: 45,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildDottedLine(),

                    AnimatedBuilder(
                      animation: _positionAnimation,
                      builder: (_, child) {
                        return Transform.translate(
                          offset: Offset(_positionAnimation.value, 0),
                          child: Transform.rotate(
                            angle: _positionAnimation.value * 0.003,
                            child: child,
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.newspaper,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
