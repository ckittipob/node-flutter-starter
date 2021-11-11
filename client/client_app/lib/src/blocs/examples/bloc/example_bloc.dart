import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client_app/src/models/example_model.dart';
import 'package:client_app/src/repositories/example_repository.dart';
import 'package:client_app/src/utils/http_exception.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final ExampleRepository _exRepository;

  ExampleBloc(this._exRepository) : super(ExampleInitial());

  @override
  Stream<ExampleState> mapEventToState(
    ExampleEvent event,
  ) async* {
    if (event is ListExample) {
      yield ExampleLoading(
        state.examples,
        state.example,
        state.error,
      );

      try {
        final examples = await _exRepository.list();
        yield ExampleLoaded(examples, state.example, null);
      } on HttpException catch (error) {
        yield ExampleLoaded(
          state.examples,
          state.example,
          error,
        );
      }
    } else if (event is DetailExample) {
      print('yield example loading');
      yield ExampleLoading(
        state.examples,
        state.example,
        state.error,
      );
      try {
        final example = await _exRepository.detail(event.id);
        yield ExampleLoaded(state.examples, example, null);
      } on HttpException catch (error) {
        yield ExampleLoaded(
          state.examples,
          state.example,
          error,
        );
      }
    } else if (event is CreateExample) {
      yield ExampleLoading(
        state.examples,
        state.example,
        state.error,
      );
      try {
        final example = await _exRepository.create(event.example);
        yield ExampleLoaded(state.examples, state.example, null);
      } on HttpException catch (error) {
        yield ExampleLoaded(
          state.examples,
          state.example,
          error,
        );
      }
    } else if (event is EditExample) {
      yield ExampleLoading(
        state.examples,
        state.example,
        state.error,
      );
      try {
        final example = await _exRepository.edit(event.id, event.example);
        yield ExampleLoaded(state.examples, state.example, null);
      } on HttpException catch (error) {
        yield ExampleLoaded(
          state.examples,
          state.example,
          error,
        );
      }
    } else if (event is DeleteExample) {
      yield ExampleLoading(
        state.examples,
        state.example,
        state.error,
      );
      try {
        final example = await _exRepository.delete(event.id);
        yield ExampleLoaded(state.examples, state.example, null);
      } on HttpException catch (error) {
        yield ExampleLoaded(
          state.examples,
          state.example,
          error,
        );
      }
    }
  }
}
