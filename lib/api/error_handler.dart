/*
 * Created by Archer on 2023/5/20.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/levir.dart';

extension ShrineApi on Service {
  Stream<Map<String, dynamic>> observeFor(HttpRequest request) {
    return observe(request, responseErrorHandler: const _ShrineErrorHandler());
  }
}

class _ShrineErrorHandler implements ResponseErrorHandler {
  const _ShrineErrorHandler();

  @override
  bool hasError(HttpResponse response) {
    if (response.body == null) {
      return true;
    }

    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 300) {
      return true;
    }

    return false;
  }

  @override
  ErrorEnvelope handleError(HttpRequest request, HttpResponse response) {
    if (response.body == null) {
      return ErrorEnvelope.internal;
    }

    final JSON json;
    if (response.body is String) {
      json = JSON.parse(response.body);
    } else {
      json = JSON.from(response.body);
    }
    return ErrorEnvelope(
      code: json["code"].integer ?? ErrorEnvelope.internal.code,
      message: json["message"].string ?? ErrorEnvelope.internal.message,
    );
  }
}
