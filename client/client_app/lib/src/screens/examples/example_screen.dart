import 'package:client_app/src/utils/responsive.dart';
import 'package:client_app/src/widgets/example/example_widget.dart';
import 'package:client_app/src/widgets/common/navbar.dart';
import 'package:flutter/material.dart';

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: Responsive(
        mobile: ExampleWidget(),
        tablet: ExampleWidget(),
        desktop: ExampleWidget(),
      ),
    );
  }
}
