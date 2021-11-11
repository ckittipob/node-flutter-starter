import 'package:client_app/src/utils/responsive.dart';
import 'package:client_app/src/widgets/auth/auth_widget.dart';
import 'package:client_app/src/widgets/common/navbar.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: Responsive(
        mobile: AuthWidget(),
        tablet: AuthWidget(),
        desktop: AuthWidget(),
      ),
    );
  }
}
