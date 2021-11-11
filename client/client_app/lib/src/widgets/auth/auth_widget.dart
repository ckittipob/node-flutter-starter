import 'package:client_app/src/blocs/auth/bloc/auth_bloc.dart';
import 'package:client_app/src/screens/examples/example_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // error handling
      },
      builder: (context, state) {
        if (state is AuthInitial) {
          return buildInitialInput();
        } else if (state is AuthLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AuthLoaded) {
          //Navigator.of(context).pushReplacementNamed("/");
          return Redirect(context);
        } else {
          return buildInitialInput();
        }
      },
    ));
  }

  Widget buildInitialInput() {
    return Center(child: LoginField());
  }
}

class LoginField extends StatefulWidget {
  @override
  _LoginFieldState createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  final formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: ListView(padding: EdgeInsets.all(16), children: [
          buildUsername(),
          SizedBox(height: 16),
          buildPassword(),
          SizedBox(height: 16),
          buildSubmit(),
        ]));
  }

  Widget buildUsername() => TextFormField(
      decoration: InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value.length < 4) {
          return 'Enter atleast 4 characters';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() => username = value));

  Widget buildPassword() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 5) {
            return 'Password must be at least 5 characters long';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => password = value),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
      );

  Widget buildSubmit() => Builder(
        builder: (context) => ElevatedButton(
          child: Text('Log in'),
          style: ElevatedButton.styleFrom(onPrimary: Colors.white),
          onPressed: () {
            final isValid = formKey.currentState.validate();
            // FocusScope.of(context).unfocus();

            if (isValid) {
              formKey.currentState.save();

              //final message = 'Username: $username\nPassword: $password';
              Map credential = {'username': username, 'password': password};
              submitLogin(context, credential);
            }
          },
        ),
      );

  void submitLogin(BuildContext context, Map<dynamic, dynamic> credential) {
    final authBloc = context.read<AuthBloc>();
    authBloc.add(Login(credential['username'], credential['password']));
  }
}

class Redirect extends StatefulWidget {
  final BuildContext ctx;

  const Redirect(this.ctx);
  @override
  _RedirectState createState() => _RedirectState(ctx);
}

class _RedirectState extends State<Redirect> {
  final BuildContext ctx;

  _RedirectState(this.ctx);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.of(ctx).pushReplacementNamed("/"));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
