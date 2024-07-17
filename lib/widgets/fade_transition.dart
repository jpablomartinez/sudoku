import 'package:flutter/material.dart';

//FROM CHATGPT
class FadeRoute extends PageRouteBuilder {
  final Widget page;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  FadeRoute({required this.page})
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
                  curve: Curves.easeInOut,
                ),
                child: child,
              ),
            ],
          ),
        );
}
