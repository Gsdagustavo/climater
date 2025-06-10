import 'package:flutter/material.dart';

/// This is a basic model [Container] to be used to display some infos in the
/// [Home Page]
class FabContainer extends StatelessWidget {
  const FabContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),

      padding: EdgeInsets.all(32),
      // width: double.infinity,
      child: Center(child: child),
    );
  }
}
