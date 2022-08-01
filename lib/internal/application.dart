import 'package:crypto_signals_july/internal/pages/splash_screen/splash_screen.dart';
import 'package:crypto_signals_july/internal/pages/workspace.dart';
import 'package:crypto_signals_july/internal/services/settings.dart';
import 'package:crypto_signals_july/internal/utils/infrastructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, _) => MaterialApp(
        title: Settings.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          fontFamily: 'Arial',
        ),
        onGenerateRoute: (routeSettings) {
          Route? route;

          switch (routeSettings.name) {
            case '/':
              route = MaterialPageRoute(builder: (context) => const SplashScreen());
              break;
            case '/workspace':
              route = MaterialPageRoute(builder: (context) => const Workspace());
              break;
          }

          return route;
        },
      ),
    );
  }
}
