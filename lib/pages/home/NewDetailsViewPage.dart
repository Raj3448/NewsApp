import 'package:flutter/material.dart';
import 'package:headline_hub/constant/app_theme.dart';
import 'package:lottie/lottie.dart';

class NewDetailsViewPage extends StatelessWidget {
  const NewDetailsViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 30,
          color: AppTheme.primaryColor,
        ),
        centerTitle: true,
        title: const Text('News Details', style: AppTheme.displayLarge),
        actions: [
          LottieBuilder.asset(
            'assets/animations/saved.json',
            height: 50,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
