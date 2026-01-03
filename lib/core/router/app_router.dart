import 'package:go_router/go_router.dart';
import '../../features/countdown/presentation/pages/tet_countdown_page.dart';

final appRouter = GoRouter(
  initialLocation: '/countdown',
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => '/countdown',
    ),
    GoRoute(
      path: '/countdown',
      builder: (context, state) => const TetCountdownPage(),
    ),
  ],
);
