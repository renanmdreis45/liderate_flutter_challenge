import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
    this.label, {
    super.key,
    required this.onButtonPress,
    this.textStyle,
    this.borderRadius,
    this.buttonColor,
    this.loadingColor,
    this.isLoading = false,
    this.buttonHeight,
    this.width,
    this.border,
    this.isDisable = false,
    this.hasShadow = false,
    this.textColor,
    this.disabledTextColor,
  });

  final VoidCallback onButtonPress;
  final String? label;
  final TextStyle? textStyle;
  final double? borderRadius;
  final Color? buttonColor;
  final Color? loadingColor;
  final bool? isLoading;
  final double? buttonHeight;
  final double? width;
  final BoxBorder? border;
  final bool? isDisable;
  final bool? hasShadow;
  final Color? textColor;
  final Color? disabledTextColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final btnHeight = buttonHeight ?? theme.buttonTheme.height * 1.5;

    final buttonShape = Theme.of(context).buttonTheme.shape;
    final borderRadiusGeometry = (buttonShape is RoundedRectangleBorder)
        ? buttonShape.borderRadius
        : BorderRadius.circular(24);

    final resolvedRadius = (borderRadiusGeometry is BorderRadius)
        ? borderRadiusGeometry.topLeft.x
        : 8.0;

    return Container(
        height: btnHeight,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius ?? 32,
            ),
          ),
          color: _getButtonColor(context),
          border: border,
          boxShadow: hasShadow == true
              ? [
                  BoxShadow(
                    color: _getButtonColor(context).withValues(alpha: 0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: ElevatedButton(
          onPressed: _validOnTap(),
          style: ElevatedButton.styleFrom(
            backgroundColor: _getButtonColor(context),
            foregroundColor: textColor ?? Colors.white,
            elevation: hasShadow == true ? 6 : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? resolvedRadius,
              ),
            ),
            minimumSize:
                Size(width ?? MediaQuery.of(context).size.width, btnHeight),
          ),
          child: isLoading == true
              ? SizedBox(
                  width: btnHeight / 2,
                  height: btnHeight / 2,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      loadingColor ?? Colors.white,
                    ),
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  label ?? '',
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
        ));
  }

  VoidCallback? _validOnTap() {
    if (isDisable == true) {
      return null;
    }
    return isLoading == true ? null : onButtonPress;
  }

  Color _getButtonColor(BuildContext context) {
    final theme = Theme.of(context);
    final btnColor =
        theme.buttonTheme.colorScheme?.surface ?? theme.primaryColor;
    final btnDisabledColor =
        theme.buttonTheme.colorScheme?.onSurface ?? theme.disabledColor;

    if (isDisable == true) {
      return btnDisabledColor;
    }
    return buttonColor ?? btnColor;
  }
}
