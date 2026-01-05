import 'package:equatable/equatable.dart';

sealed class CountdownEvent extends Equatable {
  const CountdownEvent();

  @override
  List<Object> get props => [];
}

class CountdownStarted extends CountdownEvent {
  const CountdownStarted();
}

class CountdownTicked extends CountdownEvent {
  final Duration duration;

  const CountdownTicked({required this.duration});

  @override
  List<Object> get props => [duration];
}
