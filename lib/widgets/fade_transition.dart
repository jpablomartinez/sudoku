import 'package:flutter/material.dart';

//FROM CHATGPT
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  final int duration;

  @override
  Duration get transitionDuration => Duration(milliseconds: duration);

  FadeRoute({required this.page, this.duration = 450})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: [
              Container(color: Colors.black),
              FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.linear,
                ),
                child: child,
              ),
            ],
          ),
        );
}
