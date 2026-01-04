import 'package:flutter/material.dart';
import 'dart:async';

class TetCountdownPage extends StatefulWidget {
  const TetCountdownPage({super.key});

  @override
  State<TetCountdownPage> createState() => _TetCountdownPageState();
}

class _TetCountdownPageState extends State<TetCountdownPage> {
  // Tết Nguyên Đán 2026: 17/02/2026 (Mùng 1 Tết - Năm Bính Ngọ)
  final DateTime tetDate = DateTime(2026, 2, 17, 0, 0, 0);

  Duration _remaining = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateRemaining();
    });
  }

  void _updateRemaining() {
    final now = DateTime.now();
    setState(() {
      _remaining = tetDate.difference(now);
      if (_remaining.isNegative) {
        _remaining = Duration.zero;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return Title(
      title: 'Đếm Ngược Tết 2026',
      color: const Color(0xFFB71C1C),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFB71C1C), // Dark red
                Color(0xFFD32F2F), // Red
                Color(0xFFFF5722), // Orange red
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  const Text(
                    'COUNTDOWN TO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 8,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Tết Title with decoration
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFFFFD700),
                        Color(0xFFFFA500),
                        Color(0xFFFFD700),
                      ],
                    ).createShader(bounds),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'TẾT BÍNH NGỌ 2026',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),
                  const Text(
                    '17 Tháng 2, 2026',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white60,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Countdown boxes
                  if (_remaining == Duration.zero)
                    const Text(
                      'CHÚC MỪNG NĂM MỚI!',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTimeBox(days.toString().padLeft(2, '0'), 'NGÀY'),
                        _buildSeparator(),
                        _buildTimeBox(hours.toString().padLeft(2, '0'), 'GIỜ'),
                        _buildSeparator(),
                        _buildTimeBox(
                            minutes.toString().padLeft(2, '0'), 'PHÚT'),
                        _buildSeparator(),
                        _buildTimeBox(
                            seconds.toString().padLeft(2, '0'), 'GIÂY'),
                      ],
                    ),

                  const SizedBox(height: 60),

                  // Greeting message
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.yellow.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: const Text(
                      'Chúc Mừng Năm Mới',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.yellow,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeBox(String value, String label) {
    return Container(
      width: 75,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.yellow.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black45,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        ':',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
