import 'package:client_app/src/blocs/auth/bloc/auth_bloc.dart';
import 'package:client_app/src/screens/auth/auth_screen.dart';
import 'package:client_app/src/utils/responsive.dart';
import 'package:client_app/src/widgets/common/navlink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Navbar extends StatelessWidget with PreferredSizeWidget {
  final navTitle = 'temp';

  // TO DO:

  // style and active link
  // responsive design

  @override
  Widget build(BuildContext context) {
    // get route

    return Responsive(
      desktop: desktopNavbar(context),
      tablet: mobileNavbar(context),
      mobile: mobileNavbar(context),
    );
  }

  Widget desktopNavbar(BuildContext context) {
    return AppBar(
        centerTitle: true,

        // if case
        leading: Image(image: AssetImage('assets/images/logo.png')),

        // Change styling
        // actions
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NavLink(text: "Example", link: "/"),
            SizedBox(width: 10),
            NavLink(text: "Auth", link: AuthScreen.routeName),
          ],
        ),

        // Change to drop down
        actions: <Widget>[
          PopupMenuButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/auth");
                        },
                        icon: Icon(Icons.settings),
                        label: Text('Settings'),
                      ),
                    ),
                    PopupMenuItem(
                        child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is AuthLoaded) {
                                return TextButton.icon(
                                  onPressed: () {
                                    final authBloc = context.read<AuthBloc>();
                                    authBloc.add(Logout());
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.power_settings_new),
                                  label: Text('Logout'),
                                );
                              }

                              return TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pushNamed("/auth");
                                },
                                icon: Icon(Icons.person),
                                label: Text('Login'),
                              );
                            })),
                  ])
        ]);
  }

  Widget mobileNavbar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: <Widget>[
          PopupMenuButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/");
                        },
                        icon: Icon(Icons.list_alt),
                        label: Text('Example'),
                      ),
                    ),
                    PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/auth");
                        },
                        icon: Icon(Icons.settings),
                        label: Text('Settings'),
                      ),
                    ),
                    PopupMenuItem(
                        child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is AuthLoaded) {
                                return TextButton.icon(
                                  onPressed: () {
                                    final authBloc = context.read<AuthBloc>();
                                    authBloc.add(Logout());
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.power_settings_new),
                                  label: Text('Logout'),
                                );
                              }

                              return TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pushNamed("/auth");
                                },
                                icon: Icon(Icons.person),
                                label: Text('Login'),
                              );
                            })),
                  ])
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
