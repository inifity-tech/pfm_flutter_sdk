import 'package:equal_sdk_flutter/view/i_webview.dart';
import 'package:flutter/material.dart';

class EqualWebViewHelper extends IWebView {
  EqualWebViewHelper(
      {super.key,
      required super.initialUrl,
      required super.onSubmit,
      required super.onError});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
