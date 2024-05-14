part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeChanged extends ThemeState {
  final ThemeData theme;

  const ThemeChanged(this.theme);
}
