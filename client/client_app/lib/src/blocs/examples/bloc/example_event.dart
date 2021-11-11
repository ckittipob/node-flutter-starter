part of 'example_bloc.dart';

@immutable
abstract class ExampleEvent {}

class ListExample extends ExampleEvent {
  ListExample();
}

class DetailExample extends ExampleEvent {
  final String id;
  DetailExample(this.id);
}

class CreateExample extends ExampleEvent {
  final ExampleFormModel example;
  CreateExample(this.example);
}

class EditExample extends ExampleEvent {
  final String id;
  final ExampleFormModel example;
  EditExample(this.id, this.example);
}

class DeleteExample extends ExampleEvent {
  final String id;
  DeleteExample(this.id);
}
