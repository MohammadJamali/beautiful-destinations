import 'package:equatable/equatable.dart';

class PlaceFailures with EquatableMixin implements Exception {
  const PlaceFailures(this.error, this.stackTrace);

  final Object error;

  final StackTrace stackTrace;

  @override
  List<Object?> get props => [error, stackTrace];
}
