import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.loadingText});

  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator.adaptive(),
            const Gap.vertical(height: 10),
            Text(
              loadingText,
              textAlign: TextAlign.center,
              style: context.textTheme.displayLarge!.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
