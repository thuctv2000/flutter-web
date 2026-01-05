import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'countdown_event.dart';
import 'countdown_state.dart';

class CountdownBloc extends Bloc<CountdownEvent, CountdownState> {
  // Tết Nguyên Đán 2026: 17/02/2026
  static final DateTime _tetDate = DateTime(2026, 2, 17, 0, 0, 0);
  Timer? _timer;

  CountdownBloc() : super(CountdownInitial(_calculateRemaining())) {
    on<CountdownStarted>(_onStarted);
    on<CountdownTicked>(_onTicked);
  }

  static Duration _calculateRemaining() {
    final now = DateTime.now();
    final remaining = _tetDate.difference(now);
    return remaining.isNegative ? Duration.zero : remaining;
  }

  void _onStarted(CountdownStarted event, Emitter<CountdownState> emit) {
    _timer?.cancel();
    emit(CountdownRunInProgress(_calculateRemaining()));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(CountdownTicked(duration: _calculateRemaining()));
    });
  }

  void _onTicked(CountdownTicked event, Emitter<CountdownState> emit) {
    emit(CountdownRunInProgress(event.duration));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
