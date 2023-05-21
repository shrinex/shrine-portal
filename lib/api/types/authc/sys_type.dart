/*
 * Created by Archer on 2023/5/20.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/levir.dart';

enum SysType implements RawEnum<int> {
  platform(1),
  merchant(2),
  portal(3),
  ;

  @override
  final int rawValue;

  const SysType(
    this.rawValue,
  );
}
