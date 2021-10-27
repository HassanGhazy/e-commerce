import 'package:flutter/material.dart';
import 'package:shop/helpers/app_router.dart';
import 'package:shop/helpers/strings.dart';

class TextLine extends StatelessWidget {
  final String? text;
  final String? route;
  TextLine(this.text, [this.route]);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Divider(
            color: Colors.black,
          ),
        ),
        SizedBox(width: 20),
        TextButton(
            onPressed: () {
              if (route != null) AppRouter.route.pushNamed(route!, {});
            },
            child: Text(
              Strings.seeAll,
              style: TextStyle(color: Colors.redAccent),
            ))
      ],
    );
  }
}
