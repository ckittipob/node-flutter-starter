import 'package:client_app/src/utils/responsive.dart';
import 'package:client_app/src/widgets/common/navbar.dart';
import 'package:client_app/src/widgets/example/example_edit_widget.dart';
import 'package:flutter/material.dart';

class ExampleEditScreen extends StatelessWidget {
  static const routeName = '/examples/manage';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: Navbar(),
      body: Responsive(
        mobile: ExampleEditWidget(id),
        tablet: ExampleEditWidget(id),
        desktop: ExampleEditWidget(id),
      ),
    );
  }
}
