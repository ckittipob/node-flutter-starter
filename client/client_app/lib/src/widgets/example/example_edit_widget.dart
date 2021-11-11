import 'package:client_app/src/blocs/examples/bloc/example_bloc.dart';
import 'package:client_app/src/models/example_model.dart';
import 'package:client_app/src/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExampleEditWidget extends StatefulWidget {
  final String id;

  ExampleEditWidget(this.id);

  @override
  _ExampleEditWidgetState createState() => _ExampleEditWidgetState();
}

class _ExampleEditWidgetState extends State<ExampleEditWidget> {
  final formKey = GlobalKey<FormState>();

  ExampleFormModel example = ExampleFormModel();

  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      if (widget.id != null) {
        final exBloc = context.read<ExampleBloc>();
        exBloc.add(DetailExample(widget.id));
      }
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocConsumer<ExampleBloc, ExampleState>(listener: (
      context,
      state,
    ) {
      if (state is ExampleLoaded) {
        if (state.error != null) {
          if (state.error.statusCode == 401) {
            Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error fetching data'),
              ),
            );
          }
        }
      }
    }, builder: (context, state) {
      if (widget.id == null) {
        // build Empty form
        return exampleForm(state.example);
      } else if (state is ExampleLoaded && _isInit) {
        if (state.example == null && widget.id != null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // build Edit Form
        return exampleForm(state.example);
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    }));
  }

  Widget exampleForm(ExampleModel ex) {
    return Form(
        key: formKey,
        child: ListView(padding: EdgeInsets.all(16), children: [
          buildName(widget.id != null ? ex.name : ''),
          SizedBox(height: 16),
          buildValue(widget.id != null ? ex.integer : 0),
          SizedBox(height: 16),
          buildSubmit(),
        ]));
  }

  Widget buildName(String name) {
    return TextFormField(
        initialValue: name,
        decoration: InputDecoration(
          labelText: "Example's Name",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 4) {
            return 'Enter atleast 4 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => example.name = value));
  }

  Widget buildValue(int value) {
    return TextFormField(
        initialValue: value.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Example's Value",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          final isDigitsOnly = int.tryParse(value);
          return isDigitsOnly == null ? 'Input needs to be digits only' : null;
        },
        onSaved: (value) => setState(() => example.integer = int.parse(value)));
  }

  Widget buildSubmit() => Builder(
      builder: (context) => ElevatedButton(
            child: Text('SAVE'),
            onPressed: () {
              final isValid = formKey.currentState.validate();

              if (isValid) {
                formKey.currentState.save();
              }

              submitData(context, example);
            },
          ));

  void submitData(BuildContext context, ExampleFormModel ex) {
    if (widget.id == null) {
      final exBloc = context.read<ExampleBloc>();
      exBloc.add(CreateExample(ex));
      Navigator.of(context).pushReplacementNamed("/");
    } else {
      final exBloc = context.read<ExampleBloc>();
      exBloc.add(EditExample(widget.id, ex));
      Navigator.of(context).pushReplacementNamed("/");
    }
  }
}
