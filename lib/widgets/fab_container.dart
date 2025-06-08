import 'package:flutter/material.dart';

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
      child: Center(child: child),
    );
  }
}
