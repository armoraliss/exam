import 'package:exam/firebase_options.dart';
import 'package:exam/screens/account_screen.dart';
import 'package:exam/screens/home_screen.dart';
import 'package:exam/screens/login_screen.dart';
import 'package:exam/screens/news.dart';
import 'package:exam/screens/qrcode.dart';
import 'package:exam/screens/reser_password_screen.dart';
import 'package:exam/screens/signup_screen.dart';
import 'package:exam/screens/story.dart';
import 'package:exam/screens/verify_email_screen.dart';
import 'package:exam/services/firebase_stream.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      routes: {
        '/': (context) => const FirebaseStream(),
        '/home': (context) => HomeScreen(),
        '/account': (context) => const AccountScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/verify_email': (context) => const VerifyEmailScreen(),
        '/qr': (context) => Qrcode(),
        '/story': (context) => Story(),
        NewsScreen.routeName: (context) => const NewsScreen(),
        ArticleScreen.routeName: (context) => const ArticleScreen(),
      },
      initialRoute: '/',
    );
  }
}
