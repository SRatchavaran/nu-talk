import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutalk/helper/navigator_helper_app.dart';
import 'package:nutalk/provider/main_provider.dart';
import 'package:nutalk/provider/navigator_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  CustomNavigatorHelperApp.instance;
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('th'),
        ],
        path: 'assets/language',
        child: const MyApp(),
      ),
    );
  }, (error, stackTrace) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<NavigatorProvider>(create: (_) => NavigatorProvider()),
        ListenableProvider<MainProvider>(create: (_)=> MainProvider())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'NUtalk',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        routerConfig: CustomNavigatorHelperApp.router,
        builder: (context, child) => child ?? Container(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
