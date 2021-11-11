part of 'example_bloc.dart';

@immutable
abstract class ExampleState {
  final List<ExampleModel> examples;
  final ExampleModel example;
  final HttpException error;

  const ExampleState(this.examples, this.example, this.error);
}

class ExampleInitial extends ExampleState {
  const ExampleInitial() : super(null, null, null);
}

class ExampleLoading extends ExampleState {
  final List<ExampleModel> examples;
  final ExampleModel example;
  final HttpException error;
  // input
  const ExampleLoading(
    this.examples,
    this.example,
    this.error,
  ) : super(
          examples,
          example,
          error,
        );
}

class ExampleLoaded extends ExampleState with EquatableMixin {
  final List<ExampleModel> examples;
  final ExampleModel example;
  final HttpException error;
  const ExampleLoaded(
    this.examples,
    this.example,
    this.error,
  ) : super(
          examples,
          example,
          error,
        );

  @override
  List<Object> get props => [examples];
}
