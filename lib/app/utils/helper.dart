import 'package:flutter/material.dart';

import 'get_it_injection.dart';
import 'navigation_helper.dart';

navigateTo(Widget page , {bool removeAll = false ,bool replace = false ,Function? onResult })async{
  getIt<NavHelper>().navigate(page,
    removeAll: removeAll,
    replace: replace,
    onResult: onResult,
);
}

void goBack(B){
  getIt<NavHelper>().goBack();
}

hideKeyboard(BuildContext context){
  FocusScopeNode scope = FocusScope.of(context);
  if(!scope.hasPrimaryFocus){
    FocusScope.of(context).requestFocus(FocusNode());
  }

}

