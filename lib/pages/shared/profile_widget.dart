import 'package:flutter/material.dart';
import 'package:headline_hub/constant/app_theme.dart';
import 'package:headline_hub/pages/Auth/auth_screen.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 80,
        ),
        const CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage('assets/images/user.png'),
        ),
        const Text(
          'Raj Chavan',
          style: AppTheme.displayLarge,
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          width: screenSize.width * 0.9,
          decoration: BoxDecoration(
              color: const Color(0xFFEBEAEA),
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: SizedBox(
              height: 50,
              child: Icon(
                Icons.settings,
                size: 30,
                color: Colors.cyan.shade200,
              ),
            ),
            title: const Text(
              'Notification, Theme',
              style: AppTheme.displayLarge,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 25,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.bounceInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const AuthScreen();
                  },
                ),
                (route) => false);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: const Color(0xFFEBEAEA),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: SizedBox(
                height: 50,
                child: Icon(
                  Icons.logout_rounded,
                  size: 30,
                  color: Colors.cyan.shade200,
                ),
              ),
              title: const Text(
                'Log Out',
                style: AppTheme.displayLarge,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 25,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
