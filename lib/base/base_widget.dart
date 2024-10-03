// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:provider/provider.dart';
import 'package:focus_detector/focus_detector.dart';

// Internal Modules
// import 'package:chomchob/base/base_screen_size.dart';
// import 'package:chomchob/extensions/basic_extensions.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    T model,
    Widget? child,
    // CCScreenSize size,
  ) builder;

  final T model;
  final Widget? child;
  final void Function(T model)? onModelReady;
  final void Function(T model)? onAppResume;
  final void Function(T model)? onAppPause;
  final void Function(T model)? onPageResume;
  final void Function(T model)? onPagePause;
  final VoidCallback? onDispose;

  /// Handle event when pressed on the system back button on Android
  ///
  /// return false: navigate to previous page (like pop)
  ///
  /// return true: do nothing
  final Future<bool> Function(T model)? onBackButtonPressed;

  const BaseWidget({
    required this.builder,
    required this.model,
    this.child,
    this.onModelReady,
    this.onDispose,
    this.onAppResume,
    this.onAppPause,
    this.onPageResume,
    this.onPagePause,
    this.onBackButtonPressed,
    Key? key,
  }) : super(key: key);

  @override
  BaseWidgetState<T> createState() => BaseWidgetState<T>();
}

class BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  late T model;

  bool get _isNeedFocusDetector =>
      widget.onAppResume != null ||
      widget.onAppPause != null ||
      widget.onPageResume != null ||
      widget.onPagePause != null;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!();
    }

    super.dispose();
  }

  Widget _focusDetector({required Widget child}) => _isNeedFocusDetector
      ? FocusDetector(
          onFocusGained: () {
            if (widget.onPageResume != null) {
              widget.onPageResume!(model);
            }
          },
          onFocusLost: () {
            if (widget.onPagePause != null) {
              widget.onPagePause!(model);
            }
          },
          onForegroundGained: () {
            if (widget.onAppResume != null) {
              widget.onAppResume!(model);
            }
          },
          onForegroundLost: () {
            if (widget.onAppPause != null) {
              widget.onAppPause!(model);
            }
          },
          child: child,
        )
      : child;

  Widget _backButtonListener({required Widget child}) => widget.onBackButtonPressed != null
      ? BackButtonListener(
          onBackButtonPressed: () => widget.onBackButtonPressed!(model),
          child: child,
        )
      : child;

  Widget _mainContainer() => ChangeNotifierProvider<T>(
        create: (_) => model,
        child: Consumer<T>(
          builder: (context, value, child) {
            // var size = context.screenSize();
            // if (context.isMobile() && size.isLaptop) {
            //   size = CCScreenSize.tablet;
            // }
            return widget.builder(context, model, child);
          },
          child: widget.child,
        ),
      );

  @override
  Widget build(BuildContext context) => _focusDetector(
        child: _backButtonListener(
          child: _mainContainer(),
        ),
      );
}
