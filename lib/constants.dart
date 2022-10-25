import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

double? responsiveHW(ctx, {ht, wd}) {
  return (ht != null)
      ? MediaQuery.of(ctx).size.height * ht / 100
      : (wd != null)
          ? MediaQuery.of(ctx).size.width * wd / 100
          : null;
}

var font_family = 'Poppins-Regular';
var font_family_bold = 'Poppins-Bold';

final loginbox = GetStorage('login_session');
final playlistbox = GetStorage('playlist');
