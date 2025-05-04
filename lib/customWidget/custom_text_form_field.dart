import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/utils/text_style.dart';
import 'package:rxdart/rxdart.dart';

class CustomTextFormField extends StatefulWidget {
  final String? formFieldLabel;
  final double? labelSize;
  final FontWeight? labelWeight;
  final double? labelPadding;
  final TextEditingController? controller;
  final TextStyle? formFieldStyle;
  final Widget? prefix;
  final Widget? suffix;
  final bool setPassword;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;
  final bool readOnly;
  final void Function()? onTap;
  final String? initialValue;
  final void Function()? onEditingComplete;
  final bool setError;
  final TextInputType? keyboardType;
  final EdgeInsetsDirectional? contentPadding, margin, suffixPadding;
  final Color? backgroundColor;
  final double? formFieldHeight;
  final double? formFieldWidth;
  final String? hintText;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    this.formFieldLabel,
    this.labelSize,
    this.labelWeight,
    this.labelPadding,
    this.controller,
    this.formFieldStyle,
    this.prefix,
    this.suffix,
    this.setPassword = false,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.initialValue,
    this.onEditingComplete,
    this.setError = true,
    this.keyboardType,
    this.contentPadding,
    this.backgroundColor,
    this.margin,
    this.formFieldHeight,
    this.formFieldWidth, this.hintText, this.suffixPadding, this.maxLines,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final GlobalKey<FormFieldState> _fieldKey =
      GlobalKey<FormFieldState>(); //  for setting the error message to tooltip using another variable
  final passwordVisibilitySubject = BehaviorSubject<bool>.seeded(false);
  final errorMessageSubject = BehaviorSubject<String?>.seeded(null);
  final GlobalKey _tooltipKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.formFieldLabel != null) ...[
          Text(
            widget.formFieldLabel!,
            style: bodyText(
              textColor: colorCommonBrown,
              fontSize: widget.labelSize ?? textSize20px,
              fontWeight: widget.labelWeight ?? FontWeight.w500,
            ),
          ),
          SizedBox(height: widget.labelPadding ?? commonPadding10px),
        ],
        StreamBuilder<bool>(
          stream: passwordVisibilitySubject,
          builder: (context, snapVisible) {
            return Container(
              margin: widget.margin,
              height: widget.formFieldHeight,
              width: widget.formFieldWidth,
              alignment: AlignmentDirectional.center,
              child: TextFormField(
                key: _fieldKey,
                controller: widget.controller,
                textAlignVertical: TextAlignVertical.center,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: widget.formFieldStyle ?? formFieldStyle(),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: bodyText(
                    fontSize: textSize12px, fontWeight: FontWeight.w300, textColor: colorHintGrey
                  ),
                  fillColor: widget.backgroundColor ?? colorFormFieldBg,
                  filled: true,
                  border: formFieldBorder,
                  focusedBorder: formFieldBorder,
                  enabledBorder: formFieldBorder,
                  errorBorder: formFieldBorder,
                  focusedErrorBorder: formFieldBorder,
                  prefixIcon: widget.prefix,
                  suffixIcon: _buildSuffixIcon(snapVisible.data ?? false),
                  errorStyle: widget.setError
                      ? const TextStyle(
                          fontSize: 0.01,
                          height: 0.01,
                          color: Colors.transparent,
                        )
                      : null,
                  isDense: true,
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.symmetric(
                        horizontal: commonPadding10px,
                        vertical: commonPadding10px,
                      ),
                ),
                validator: (value) {
                  final error = widget.validator?.call(value);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      errorMessageSubject.sink.add(error);
                    }
                  });
                  return error;
                },
                obscureText: snapVisible.data ?? false,
                onChanged: (value) {
                  widget.onChanged?.call(value);
                  // triggering validator on the onChanged method, and set tooltip
                  final error = widget.validator?.call(value);
                  errorMessageSubject.sink.add(error);
                },
                readOnly: widget.readOnly,
                onTap: widget.onTap,
                initialValue: widget.controller == null ? widget.initialValue : null,
                onEditingComplete: widget.onEditingComplete,
                keyboardType: widget.keyboardType,
                maxLines: widget.maxLines ?? 1,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSuffixIcon(bool isVisible) {
    List<Widget> icons = [];
    if (widget.suffix != null) icons.add(widget.suffix!);
    if (widget.setPassword) {
      icons.add(
        GestureDetector(
          onTap: () {
            passwordVisibilitySubject.sink.add(!isVisible);
          },
          child: Icon(
            isVisible ? Icons.visibility_off : Icons.visibility,
            color: colorPrimary,
            size: iconSize24px,
          ),
        ),
      );
    }
    if (widget.setError) {
      icons.add(
        StreamBuilder<String?>(
          stream: errorMessageSubject,
          builder: (context, snapErrorMsg) {
            if ((snapErrorMsg.data?.isNotEmpty ?? false)) {
              return GestureDetector(
                onTap: _showTooltip,
                child: Tooltip(
                  key: _tooltipKey,
                  message: snapErrorMsg.data ?? "",
                  textStyle: bodyText(fontSize: textSize14px),
                  child: Icon(
                    Icons.error,
                    color: colorRed,
                    size: iconSize24px,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );
    }
    return icons.isNotEmpty
        ? Padding(
            padding: widget.suffixPadding??EdgeInsetsDirectional.symmetric(horizontal: deviceWidth * 0.01),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Important!
              children: icons,
            ),
          )
        : const SizedBox.shrink();
  }

  OutlineInputBorder formFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius13px),
    borderSide: BorderSide(color: colorFormFieldBg),
  );

  void _showTooltip() {
    final dynamic tooltip = _tooltipKey.currentState;
    tooltip?.ensureTooltipVisible();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Tooltip.dismissAllToolTips();
      },
    );
  }

  @override
  void dispose() {
    passwordVisibilitySubject.close();
    errorMessageSubject.close();
    super.dispose();
  }
}
