/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/levir.dart';
import 'package:shrine_portal/api/endpoint.dart';
import 'package:shrine_portal/api/error_handler.dart';
import 'package:shrine_portal/api/types/authc/access_token.dart';
import 'package:shrine_portal/api/types/authc/login_params.dart';

extension Authc on Service {
  Stream<AccessToken> signIn(LoginParams params) {
    return observeFor(
      ClientHttpRequest(
        body: params,
        path: "/api/v1/authc/login",
        method: HttpMethod.post,
        baseUrl: Endpoint.authc.rawValue,
      ),
    ).map(($0) => AccessToken.fromJson($0));
  }
}
