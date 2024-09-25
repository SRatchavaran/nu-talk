import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension BuildContextProvider on BuildContext {
  T provide<T>({bool listen = true}) => Provider.of<T>(this, listen: listen);

  MediaQueryData get media => MediaQuery.of(this);

  Size get mediaSize => MediaQuery.of(this).size;
}
