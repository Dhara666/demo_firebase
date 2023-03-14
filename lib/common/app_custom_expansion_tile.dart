import 'package:flutter/material.dart';

import '../constants/color_constant.dart';
import 'app_text.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class AppCustomExpansionTile extends StatefulWidget {
  const AppCustomExpansionTile({
    Key? key,
    this.headerBackgroundColor,
    this.leading,
    @required this.title,
    this.subTitle,
    this.backgroundColor,
    this.iconColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.margin,
    this.textStyle,
    this.flex = 0,
  })  : assert(initiallyExpanded != null),
        super(key: key);
  final Widget? leading;
  final String? title;
  final String? subTitle;
  final ValueChanged<bool>? onExpansionChanged;

  final List<Widget>? children;

  final Color? backgroundColor;
  final TextStyle? textStyle;

  final Color? headerBackgroundColor;

  final Color? iconColor;
  final Widget? trailing;
  final bool? initiallyExpanded;
  final EdgeInsetsGeometry? margin;
  final int flex;

  @override
  AppCustomExpansionTileState createState() => AppCustomExpansionTileState();
}

class AppCustomExpansionTileState extends State<AppCustomExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  AnimationController? _controller;
  Animation<double>? _iconTurns;
  Animation<double>? _heightFactor;
  Animation<Color?>? borderColor;
  Animation<Color?>? headerColor;
  Animation<Color?>? _iconColor;
  Animation<Color?>? backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller!.drive(_easeInTween);
    _iconTurns = _controller!.drive(_halfTween.chain(_easeInTween));
    borderColor = _controller!.drive(_borderColorTween.chain(_easeOutTween));
    headerColor = _controller!.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller!.drive(_iconColorTween.chain(_easeInTween));
    backgroundColor =
        _controller!.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller!.value = 1.0;
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller!.forward();
      } else {
        _controller!.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(_isExpanded);
    }
  }

  Widget _buildChildren(BuildContext? context, Widget? child) {
    return Container(
      margin: widget.margin ??
          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(color: _iconColor!.value),
            child: Container(
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: widget.headerBackgroundColor ?? ColorConstant.appBlack,
              ),
              child: GestureDetector(
                onTap: handleTap,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: widget.flex,
                        child: AppText(
                          text: widget.title,
                          maxLines: 2,
                          textStyle: widget.textStyle ??
                              Theme.of(context!)
                                  .textTheme
                                  .headline2!
                                  .copyWith(color: ColorConstant.appWhite,fontSize: 13),
                        ),
                      ),
                      SizedBox(width: widget.subTitle != null ? 5 : 0),
                      widget.subTitle != null
                          ? AppText(
                              text: widget.subTitle,
                              textStyle: widget.textStyle ??
                                  Theme.of(context!)
                                      .textTheme
                                      .headline2!
                                      .copyWith(color: ColorConstant.appWhite,fontSize: 13),
                            )
                          : const SizedBox(),
                      const Spacer(),
                      widget.trailing ??
                          RotationTransition(
                            turns: _iconTurns!,
                            child: Icon(
                              Icons.expand_more,
                              size: 20,
                              color: widget.iconColor ?? Theme.of(context!).iconTheme.color,
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              heightFactor: _heightFactor!.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween.end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.subtitle1!.color
      ..end = theme.colorScheme.secondary;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.colorScheme.secondary;
    _backgroundColorTween.end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller!.isDismissed;
    return AnimatedBuilder(
      animation: _controller!.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children!),
    );
  }
}
