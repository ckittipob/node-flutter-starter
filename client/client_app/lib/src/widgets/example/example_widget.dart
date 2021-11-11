import 'package:client_app/src/blocs/examples/bloc/example_bloc.dart';
import 'package:client_app/src/screens/auth/auth_screen.dart';
import 'package:client_app/src/screens/examples/example_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExampleWidget extends StatefulWidget {
  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      final exBloc = context.read<ExampleBloc>();
      exBloc.add(ListExample());
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
        if (state is ExampleInitial) {
          final exBloc = context.read<ExampleBloc>();
          exBloc.add(ListExample());
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ExampleLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ExampleLoaded) {
          return RefreshIndicator(
              onRefresh: () async {
                final exBloc = context.read<ExampleBloc>();
                exBloc.add(ListExample());
                return;
              },
              child: state.examples != null
                  ? examplesTable(context, state)
                  : Text('error'));
        }
        return Container();
      }),
    );
  }

  Widget examplesTable(BuildContext context, ExampleState state) {
    void _delete(BuildContext context, String id) {
      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
              title: Text('Please Confirm'),
              content: Text('Are you sure to remove $id?'),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (_) => Colors.white,
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (_) => Colors.red,
                    ),
                  ),
                  child: Text('DELETE'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    final exBloc = context.read<ExampleBloc>();
                    exBloc.add(DeleteExample(id));
                    Navigator.of(context).pushReplacementNamed("/");
                    // refresh page
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (_) => Colors.white,
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (_) => Colors.grey,
                    ),
                  ),
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ]);
        },
      );
    }

    return ListView(children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 20.0,
          bottom: 16.0,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (_) => Colors.white,
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.all(15),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(
                '${ExampleEditScreen.routeName}',
              );
            },
            icon: Icon(Icons.add_box_outlined),
            label: Text('New Item'),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith((_) => Colors.orange),
          headingTextStyle: TextStyle(color: Colors.white),
          showCheckboxColumn: false,
          columns: const <DataColumn>[
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Value')),
            DataColumn(label: Text('Delete')),
          ],
          rows: state.examples.map<DataRow>((ex) {
            return DataRow(
                onSelectChanged: (bool selected) {
                  if (selected) {
                    Navigator.of(context).pushNamed(
                        '${ExampleEditScreen.routeName}',
                        arguments: ex.id);
                  }
                },
                cells: <DataCell>[
                  DataCell(Text(ex.name)),
                  DataCell(Text(ex.integer.toString())),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.delete_forever),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        _delete(context, ex.id);
                      },
                    ),
                  ),
                ]);
          }).toList(),
        ),
      )
    ]);
  }
}
