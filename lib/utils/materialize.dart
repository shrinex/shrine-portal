/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/levir.dart';
import 'package:rxdart/rxdart.dart';

extension Materialize<R, N extends Notification<R>> on Stream<N> {
  Stream<ErrorEnvelope> errors({bool share = false}) {
    final downstream = where((event) {
      return event.isOnError;
    }).map((event) {
      return event.errorAndStackTrace?.error;
    }).map((event) {
      if (event is ErrorEnvelope) {
        return event;
      }

      return ErrorEnvelope.internal;
    }).debounceTime(const Duration(seconds: 1));

    if (share) {
      return downstream.share();
    }

    return downstream;
  }

  Stream<E> values<E>({bool share = false}) {
    final downstream = where((event) => event.isOnData)
        .map((event) => event.requireData)
        .whereType<E>();

    if (share) {
      return downstream.share();
    }

    return downstream;
  }
}
