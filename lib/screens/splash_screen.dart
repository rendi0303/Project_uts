// splash_screen.dart (Coffee Art Style - Dark Brown)
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _bounceCtrl;
  late final Animation<double> _bounceAnim;
  late final AnimationController _steamCtrl;
  late final AnimationController _particleCtrl;
  late final AnimationController _rippleCtrl;
  late final AnimationController _shineCtrl;

  final List<Offset> _particlePositions = [];
  final List<double> _particleSizes = [];
  final int _particleCount = 30;
  final Random _rnd = Random(42);

  @override
  void initState() {
    super.initState();

    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _bounceAnim = CurvedAnimation(
      parent: _bounceCtrl,
      curve: Curves.elasticOut,
    );
    _bounceCtrl.forward();

    _steamCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _rippleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();

    _shineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();

    for (int i = 0; i < _particleCount; i++) {
      final dx = _rnd.nextDouble();
      final dy = _rnd.nextDouble();
      _particlePositions.add(Offset(dx, dy));
      _particleSizes.add(1.0 + _rnd.nextDouble() * 3.0);
    }

    Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    _steamCtrl.dispose();
    _particleCtrl.dispose();
    _rippleCtrl.dispose();
    _shineCtrl.dispose();
    super.dispose();
  }

  Widget _buildBackgroundPattern(Size size) {
    return Opacity(
      opacity: 0.12,
      child: Image.asset(
        'assets/images/baground.png',
        fit: BoxFit.cover,
        width: size.width,
        height: size.height,
        errorBuilder: (ctx, err, st) {
          return CustomPaint(
            size: size,
            painter: _BackgroundDotsPainter(),
          );
        },
      ),
    );
  }

  Widget _buildParticles(Size size) {
    return AnimatedBuilder(
      animation: _particleCtrl,
      builder: (context, child) {
        return CustomPaint(
          size: size,
          painter: _ParticlePainter(
            progress: _particleCtrl.value,
            relativePositions: _particlePositions,
            sizes: _particleSizes,
          ),
        );
      },
    );
  }

  Widget _buildSteam(Size size) {
    return AnimatedBuilder(
      animation: _steamCtrl,
      builder: (context, child) {
        return CustomPaint(
          size: size,
          painter: _SteamPainter(progress: _steamCtrl.value),
        );
      },
    );
  }

  Widget _buildRipple(double diameter) {
    return SizedBox(
      width: diameter,
      height: diameter,
      child: AnimatedBuilder(
        animation: _rippleCtrl,
        builder: (context, child) {
          return CustomPaint(
            painter: _SwirlPainter(value: _rippleCtrl.value),
          );
        },
      ),
    );
  }

  Widget _buildShine(double diameter) {
    return AnimatedBuilder(
      animation: _shineCtrl,
      builder: (context, child) {
        final left = -diameter * 0.7 + _shineCtrl.value * diameter * 1.4;
        return IgnorePointer(
          child: Transform.translate(
            offset: Offset(left, -diameter * 0.1),
            child: Container(
              width: diameter * 0.35,
              height: diameter * 1.4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.00),
                    Colors.white.withOpacity(0.25),
                    Colors.white.withOpacity(0.00),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final logoDiameter = min(size.width * 0.44, 220.0);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3E2723),
                  Color(0xFF5D4037),
                  Color(0xFF795548),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          _buildBackgroundPattern(size),

          _buildParticles(size),
          _buildSteam(size),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: logoDiameter,
                  height: logoDiameter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildRipple(logoDiameter * 1.05),

                      Container(
                        width: logoDiameter * 0.95,
                        height: logoDiameter * 0.95,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.shade200.withOpacity(0.45),
                              blurRadius: 40,
                              spreadRadius: 12,
                            ),
                          ],
                        ),
                      ),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            width: logoDiameter * 0.78,
                            height: logoDiameter * 0.78,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.25),
                                width: 1.4,
                              ),
                            ),
                            child: ScaleTransition(
                              scale: _bounceAnim,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(999),
                                child: Image.asset(
                                  'assets/images/propil.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (ctx, err, st) {
                                    return Container(
                                      color: Colors.brown.shade200,
                                      child: const Icon(
                                        Icons.coffee,
                                        size: 56,
                                        color: Colors.white70,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: logoDiameter * 0.78,
                        height: logoDiameter * 0.78,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: Stack(
                            children: [
                              _buildShine(logoDiameter * 0.78),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                AnimatedOpacity(
                  opacity: 1,
                  duration: const Duration(milliseconds: 800),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.35),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _bounceCtrl,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: const Text(
                      'Coffee Time!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(
                    value: null,
                    minHeight: 4,
                    backgroundColor: Colors.white.withOpacity(0.20),
                    valueColor:
                        AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Menyeduh... ☕',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------- PAINTERS ----------------------------

class _BackgroundDotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.06);
    final spacing = 28.0;
    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x + 6, y + 6), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundDotsPainter oldDelegate) => false;
}

class _ParticlePainter extends CustomPainter {
  final double progress;
  final List<Offset> relativePositions;
  final List<double> sizes;

  _ParticlePainter({
    required this.progress,
    required this.relativePositions,
    required this.sizes,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.45);

    for (int i = 0; i < relativePositions.length; i++) {
      final rel = relativePositions[i];

      final dy = (rel.dy + progress * 0.40 + (i * 0.003)) % 1.0;
      final dx = (rel.dx + sin(progress * pi * 2 + i) * 0.008) % 1.0;

      final pos = Offset(dx * size.width, dy * size.height);
      final r = sizes[i] + 1;

      canvas.drawCircle(pos, r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

class _SteamPainter extends CustomPainter {
  final double progress;

  _SteamPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final baseline = size.height * 0.88;
    final width = size.width;

    for (int i = 0; i < 3; i++) {
      final phase = progress * 2 * pi + i * 0.9;
      final x = width * (0.28 + i * 0.18) + sin(phase) * 18;
      final y = baseline - (progress * size.height * 0.45) - i * 22;

      final rect = Rect.fromCenter(
        center: Offset(x, y),
        width: 58 + i * 10,
        height: 130,
      );

      final gradient = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withOpacity(0.18),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(rect);

      canvas.drawOval(rect, gradient);
    }
  }

  @override
  bool shouldRepaint(covariant _SteamPainter oldDelegate) => true;
}

class _SwirlPainter extends CustomPainter {
  final double value;
  _SwirlPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.white.withOpacity(0.25);

    for (int i = 0; i < 4; i++) {
      final t = (value * (1 + i * 0.4)) * 2 * pi;
      final radius = (size.width / 6) + i * (size.width / 10);
      final path = Path();

      final segments = 60;
      for (int s = 0; s <= segments; s++) {
        final ang = (s / segments) * 2 * pi;

        final rx = center.dx +
            cos(ang + t * 0.12) *
                radius *
                (1 + 0.02 * sin(ang * 3 + t));

        final ry = center.dy +
            sin(ang + t * 0.12) *
                radius *
                (1 + 0.02 * cos(ang * 2 + t));

        final pt = Offset(rx, ry);

        if (s == 0) {
          path.moveTo(pt.dx, pt.dy);
        } else {
          path.lineTo(pt.dx, pt.dy);
        }
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SwirlPainter oldDelegate) => true;
}
