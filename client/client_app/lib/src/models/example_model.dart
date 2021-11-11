class ExampleModel {
  final String id;
  final String name;
  final String file;
  final int integer;
  final num number;

  ExampleModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['_id'],
        name = parsedJson['name'],
        file = parsedJson['file'],
        integer = parsedJson['integer'],
        number = parsedJson['number'];
}

class ExampleFormModel {
  String name;
  int integer;

  ExampleFormModel({this.name = '', this.integer = 0});
}
