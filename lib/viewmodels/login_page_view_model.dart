/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/levir.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shrine_portal/api/authc.dart';
import 'package:shrine_portal/api/types/authc/access_token.dart';
import 'package:shrine_portal/api/types/authc/login_params.dart';
import 'package:shrine_portal/api/types/authc/platform.dart';
import 'package:shrine_portal/api/types/authc/sys_type.dart';
import 'package:shrine_portal/basics/globals.dart';
import 'package:shrine_portal/utils/materialize.dart';
import 'package:shrine_portal/utils/tuple.dart';

abstract class LoginPageViewModelType extends ViewModel {}

abstract class LoginPageViewModelInputs extends ViewModelInputs {
  void signIn(String uname, String passwd);
}

abstract class LoginPageViewModelOutputs extends ViewModelOutputs {
  Stream<ErrorEnvelope> get errorOccurred;

  Stream<AccessToken> get accessToken;
}

class LoginPageViewModel
    implements
        LoginPageViewModelType,
        LoginPageViewModelInputs,
        LoginPageViewModelOutputs {
  LoginPageViewModel() {
    final login = _signIn
        .map((event) => LoginParams(
            username: event.$0,
            password: event.$1,
            platform: Platform.web.rawValue,
            sysType: SysType.portal.rawValue))
        .flatMap((value) => Globals.apiService.signIn(value))
        .materialize()
        .share();

    errorOccurred = login.errors();

    accessToken = login.values<AccessToken>();
  }

  final _signIn = PublishSubject<Tuple<String, String>>();

  @override
  void signIn(String uname, String passwd) {
    _signIn.add(Tuple(uname, passwd));
  }

  @override
  void dispose() {
    _signIn.close();
  }

  @override
  late final Stream<ErrorEnvelope> errorOccurred;

  @override
  late final Stream<AccessToken> accessToken;

  @override
  LoginPageViewModelInputs get inputs => this;

  @override
  LoginPageViewModelOutputs get outputs => this;
}
