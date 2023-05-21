/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/levir.dart';

enum StatusCode implements RawEnum<int> {
  todo(1);

  @override
  final int rawValue;

  const StatusCode(
    this.rawValue,
  );
}
