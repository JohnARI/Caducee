import 'package:caducee/common/const.dart';
import 'package:caducee/models/category.dart';
import 'package:caducee/models/drug.dart';
import 'package:caducee/models/user.dart';
import 'package:caducee/screens/splashscreen_wrapper.dart';
import 'package:caducee/services/authentication.dart';
import 'package:caducee/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.light,
        textTheme: const TextTheme(
          bodyText1: TextStyle(
              color: Colors.black),
          bodyText2: TextStyle(
            color: Colors.black54,
          ),
        ),
        cardColor: Colors.white,
        shadowColor: Colors.white12,
        colorScheme: const ColorScheme.light(),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: myGreen,
          selectionColor: myGreen,
          selectionHandleColor: myGreen,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: myTransparent,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      dark: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            color: Colors.white54,
          ),
        ),
        // convert #303030
        
        cardColor: const Color.fromARGB(255, 48, 48, 48),
        primaryColor: Colors.grey[900],
        shadowColor: Colors.black26,
        colorScheme: const ColorScheme.dark(),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: myGreen,
          selectionColor: myGreen,
          selectionHandleColor: myGreen,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: myTransparent,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      builder: (theme, darkTheme) => MultiProvider(
        providers: [
          StreamProvider<AppUser?>.value(
            value: AuthenticationService().user,
            initialData: null,
          ),
          StreamProvider<List<AppDrugData>>.value(
            value: DatabaseService(uid: '').drugs,
            initialData: const [],
          ),
          StreamProvider<List<Category>>.value(
            value: DatabaseService(uid: '').categories,
            initialData: const [],
          ),
        ],
        child: MaterialApp(
          title: 'Caducée',
          debugShowCheckedModeBanner: false,
          home: const SplashScreenWrapper(),
          theme: theme,
          darkTheme: darkTheme,
        ),
      ),
      initial: AdaptiveThemeMode.light,
    );
  }
}
