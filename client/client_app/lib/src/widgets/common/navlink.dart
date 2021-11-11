import 'package:flutter/material.dart';

class NavLink extends StatelessWidget {
  final String text;
  final String link;

  const NavLink({
    @required this.text,
    @required this.link,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context).settings.name;

    bool isActive() {
      if (currentRoute == link) {
        return true;
      }

      return false;
    }

    final ButtonStyle style = TextButton.styleFrom().copyWith(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed) ||
              isActive()) {
            return Colors.orange;
          }
          return Colors.white;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed) ||
              isActive()) {
            return Colors.white;
          }
          // else if active route ?
          return Colors.transparent;
        },
      ),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (_) {
          return TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
        },
      ),
      padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
        return EdgeInsets.all(15);
      }),
    );

    return TextButton(
      style: style,
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(link);
      },
      child: Text(text),
    );
  }
}
