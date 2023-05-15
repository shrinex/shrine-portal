/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:flutter/foundation.dart';
import 'package:levir/levir.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shrine_portal/api/authc.dart';
import 'package:shrine_portal/api/types/authc/access_token.dart';
import 'package:shrine_portal/api/types/authc/login_req.dart';
import 'package:shrine_portal/basics/globals.dart';
import 'package:shrine_portal/utils/materialize.dart';
import 'package:shrine_portal/utils/tuple.dart';

abstract class LoginPageViewModelType extends ViewModel {}

abstract class LoginPageViewModelInputs extends ViewModelInputs {
  void signIn(String uname, String passwd);
}

abstract class LoginPageViewModelOutputs extends ViewModelOutputs {
  Stream<String> get errorOccurred;

  Stream<AccessToken> get accessToken;
}

class LoginPageViewModel
    implements
        LoginPageViewModelType,
        LoginPageViewModelInputs,
        LoginPageViewModelOutputs {
  LoginPageViewModel() {
    final login = _tapRelay
        .map((event) => LoginReq(
            platform: defaultTargetPlatform.name,
            username: event.$0,
            password: event.$1))
        .flatMap((value) => Globals.apiService.signIn(value))
        .materialize()
        .share();

    errorOccurred = login.asError();

    accessToken = login.asData<AccessToken>();
  }

  final _tapRelay = BehaviorSubject<Tuple<String, String>>();

  @override
  void signIn(String uname, String passwd) {
    _tapRelay.add(Tuple(uname, passwd));
  }

  @override
  void dispose() {
    _tapRelay.close();
  }

  @override
  late final Stream<String> errorOccurred;

  @override
  late final Stream<AccessToken> accessToken;

  @override
  LoginPageViewModelInputs get inputs => this;

  @override
  LoginPageViewModelOutputs get outputs => this;
}
