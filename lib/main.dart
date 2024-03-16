import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_hub/db/localdb.dart';
import 'package:headline_hub/pages/home/home_view.dart';
import 'package:headline_hub/pages/shared/cubit/all_article_cubit.dart';

import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'pages/Auth/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await openDB();
  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp()));
  // const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => AllArticleCubit())
      ],
      child: KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: const TextTheme(
                displayLarge: TextStyle(
                    fontFamily: 'MyUniqueFont',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                displayMedium: TextStyle(
                    fontFamily: 'MyUniqueFont',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54)),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeView(),
          //home: const AuthScreen(),
        ),
      ),
    );
  }
}
