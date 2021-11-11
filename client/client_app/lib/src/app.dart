import 'package:client_app/src/repositories/auth_repository.dart';
import 'package:client_app/src/repositories/example_repository.dart';
import 'package:client_app/src/screens/auth/auth_screen.dart';
import 'package:client_app/src/screens/examples/example_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/bloc/auth_bloc.dart';
import 'blocs/examples/bloc/example_bloc.dart';
import 'screens/examples/example_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc(AuthRepository())),
          BlocProvider(create: (_) => ExampleBloc(ExampleRepository())),
        ],
        child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AuthInitial) {
                final authBloc = context.read<AuthBloc>();
                authBloc.add(CheckAuth());
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return MaterialApp(
                  debugShowCheckedModeBanner: false, // remove debug banner
                  title: 'Simple CRUD App',
                  theme: ThemeData(
                    primarySwatch: Colors.orange,
                    accentColor: Colors.amber,
                    // Font Family: 'font name',
                  ),
                  home: ExampleScreen(),
                  routes: {
                    AuthScreen.routeName: (ctx) => AuthScreen(),
                    ExampleEditScreen.routeName: (ctx) => ExampleEditScreen(),
                  },
                );
              }
            }));
  }
}
