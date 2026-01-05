import 'package:equatable/equatable.dart';

sealed class CountdownState extends Equatable {
  const CountdownState(this.duration);

  final Duration duration;

  @override
  List<Object> get props => [duration];
}

class CountdownInitial extends CountdownState {
  const CountdownInitial(super.duration);
}

class CountdownRunInProgress extends CountdownState {
  const CountdownRunInProgress(super.duration);
}
