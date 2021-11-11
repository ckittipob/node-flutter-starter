import 'dart:convert';
import 'package:client_app/src/models/example_model.dart';
import 'package:client_app/src/utils/agent.dart';
import 'package:client_app/src/utils/http_exception.dart';

const _root = 'http://localhost:5000/api';

class ExampleRepository {
  Future<List<ExampleModel>> list() async {
    try {
      final response = await Agent(url: '$_root/examples/protected').get();
      return response
          .map<ExampleModel>((res) => ExampleModel.fromJson(res))
          .toList();
    } on HttpException catch (error) {
      throw error;
    }
  }

  Future<ExampleModel> detail(String id) async {
    try {
      final response = await Agent(url: '$_root/examples/$id').get();
      return ExampleModel.fromJson(response);
    } on HttpException catch (error) {
      throw error;
    }
  }

  Future<void> create(ExampleFormModel ex) async {
    try {
      final Map<String, dynamic> body = {
        'name': ex.name,
        'integer': ex.integer,
        'number': 0
      };
      final response = await Agent(url: '$_root/examples').post(body);
      return response;
    } on HttpException catch (error) {
      throw error;
    }
  }

  // edit
  Future<void> edit(String id, ExampleFormModel ex) async {
    try {
      final Map<String, dynamic> body = {
        'name': ex.name,
        'integer': ex.integer,
        'number': 0
      };
      final response = await Agent(url: '$_root/examples/$id').put(body);
      return response;
    } on HttpException catch (error) {
      throw error;
    }
  }

  // delete
  Future<void> delete(String id) async {
    try {
      final response = await Agent(url: '$_root/examples/$id').delete();
      return response;
    } on HttpException catch (error) {
      throw error;
    }
  }
}
