import 'package:go_router/go_router.dart';
import '../../features/countdown/presentation/pages/tet_countdown_page.dart';
import '../../features/home/presentation/pages/landing_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/countdown',
      builder: (context, state) => const TetCountdownPage(),
    ),
  ],
);
