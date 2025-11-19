import 'dart:async';
import 'package:flutter/material.dart';

class HeaderBanner extends StatefulWidget {
  const HeaderBanner({super.key});

  @override
  State<HeaderBanner> createState() => _HeaderBannerState();
}

class _HeaderBannerState extends State<HeaderBanner> {
  final PageController _controller = PageController(viewportFraction: 1);
  final List<String> banners = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/promo.jpeg',
  ];
  int current = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      current = (current + 1) % banners.length;
      if (_controller.hasClients) {
        _controller.animateToPage(current, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _controller,
        itemCount: banners.length,
        itemBuilder: (context, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(banners[i], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
