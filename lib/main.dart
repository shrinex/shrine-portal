/*
 * Created by Archer on 2022/12/10.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:levir/levir.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrine_portal/basics/environment.dart';
import 'package:shrine_portal/basics/services.dart';
import 'package:shrine_portal/routes/routes.dart';

void main() async {
  // setup
  GoogleFonts.config.allowRuntimeFetching = false;
  final prefs = await SharedPreferences.getInstance();
  final env = Environment.fromStorage(
    apiService: Services.local,
    userDefaults: prefs.asKeyValueStore(),
  );
  // run!
  runApp(ShrinePlatformApp(env: env));
}

class ShrinePlatformApp extends StatelessWidget {
  final Environment env;

  const ShrinePlatformApp({
    super.key,
    required this.env,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: env,
      child: MaterialApp.router(
        routerConfig: shrineRouter,
      ),
    );
  }
}
