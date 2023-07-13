import 'package:flutter/material.dart';
import 'package:flutter_laboratory/app/router/router.dart';
import 'package:flutter_laboratory/app/theme/color_schemes.g.dart';

class FlutterLaboratory extends StatelessWidget {
  const FlutterLaboratory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.i.router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: 'UbuntuMono',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: 'UbuntuMono',
      ),
    );
  }
}
