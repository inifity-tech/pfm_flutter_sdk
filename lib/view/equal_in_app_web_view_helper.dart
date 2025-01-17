import 'package:equal_sdk_flutter/helper/web_view_settings_helper.dart';
import 'package:equal_sdk_flutter/model/event_response.dart';
import 'package:equal_sdk_flutter/view/i_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class EqualInAppWebViewWidget extends IWebView {
  final ValueNotifier<InAppWebViewController?> _webViewController =
      ValueNotifier(null);

  EqualInAppWebViewWidget({
    required super.initialUrl,
    required super.onSubmit,
    required super.onError,
  });

  // SDK Event Handling
  void _handleSdkEvents(String url, BuildContext context) {
    try {
      final uri = Uri.parse(url); 
      final message = uri.queryParameters['message'];
      if (url.contains('URL_SDK_EVENT')) {
        if (url.contains('ON_CLOSE')) {
          onError.call(
            EventResponse(status: 'CLOSED_SDK', message: message).toJson(),
          );
        } else if (url.contains('ON_ERROR')) {
          onSubmit.call(EventResponse(
                  status: 'ON_ERROR', message: message)
              .toJson());
        }
      }
    } catch (e) {
      onError.call(
        EventResponse(status: 'ON_ERROR', message: e.toString()).toJson(),
      );
    } finally {
      Navigator.pop(context);
    }
  }

  // Exit Confirmation Dialog
  Future<void> _showExitDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            child: const Text('No'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              onError.call(
                EventResponse(
                  status: 'CLOSED_SDK',
                ).toJson(),
              );
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _showExitDialog(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(initialUrl)),
                initialSettings: getWebViewOptions(),
                onWebViewCreated: (controller) {
                  _webViewController.value = controller;
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final url = navigationAction.request.url.toString();
                  if (url.contains('URL_SDK_EVENT')) {
                    _handleSdkEvents(url, context);
                    return NavigationActionPolicy.CANCEL;
                  }
                  return NavigationActionPolicy.ALLOW;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
