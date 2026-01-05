import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/countdown_bloc.dart';
import '../bloc/countdown_event.dart';
import '../bloc/countdown_state.dart';

class TetCountdownPage extends StatelessWidget {
  const TetCountdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountdownBloc()..add(const CountdownStarted()),
      child: const _TetCountdownView(),
    );
  }
}

class _TetCountdownView extends StatelessWidget {
  const _TetCountdownView();

  @override
  Widget build(BuildContext context) {
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
                  BlocBuilder<CountdownBloc, CountdownState>(
                    builder: (context, state) {
                      final duration = state.duration;
                      final days = duration.inDays;
                      final hours = duration.inHours % 24;
                      final minutes = duration.inMinutes % 60;
                      final seconds = duration.inSeconds % 60;

                      if (duration == Duration.zero) {
                        return const Text(
                          'CHÚC MỪNG NĂM MỚI!',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        );
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTimeBox(
                              days.toString().padLeft(2, '0'), 'NGÀY'),
                          _buildSeparator(),
                          _buildTimeBox(
                              hours.toString().padLeft(2, '0'), 'GIỜ'),
                          _buildSeparator(),
                          _buildTimeBox(
                              minutes.toString().padLeft(2, '0'), 'PHÚT'),
                          _buildSeparator(),
                          _buildTimeBox(
                              seconds.toString().padLeft(2, '0'), 'GIÂY'),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 60),

                  // Greeting message
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.yellow.withValues(alpha: 0.5),
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
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.yellow.withValues(alpha: 0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
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
