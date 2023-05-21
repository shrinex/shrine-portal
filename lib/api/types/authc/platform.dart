/*
 * Created by Archer on 2023/5/19.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/levir.dart';

enum Platform implements RawEnum<String> {
  web("web"),
  iOS("iOS"),
  android("Android"),
  ;

  @override
  final String rawValue;

  const Platform(
    this.rawValue,
  );
}
