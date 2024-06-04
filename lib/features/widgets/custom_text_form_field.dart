import 'package:bloc_boiler_plate/theme/colors.dart';
import 'package:bloc_boiler_plate/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.validator,
    this.onChanged,
    this.onSubmitted,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final Function(String)? onChanged;

  final Function(String)? onSubmitted;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  // bool passwordVisible = false;
  Widget textFormFieldWidget(BuildContext context) => SizedBox(
        width: widget.width ?? double.maxFinite,
        child: TextFormField(
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: widget.controller,
          autofocus: widget.autofocus!,
          style: widget.textStyle ??
              TextStyle(
                color: primaryColor,
                fontSize: 14.fSize,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
          obscureText: (widget.obscureText ?? false)? !passwordVisible : false,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines ?? 1,
          decoration: decoration,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: widget.hintText ?? "",
        hintStyle: widget.hintStyle ??
            TextStyle(
              color: primaryColor.withOpacity(0.4),
              fontSize: 14.fSize,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
        prefixIcon: widget.prefix,
        prefixIconConstraints: widget.prefixConstraints,
        suffixIcon: (widget.obscureText ?? false)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                icon: Icon(
                  passwordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: primaryColor.withOpacity(0.4),
                ),
        )
            : (widget.suffix),
        suffixIconConstraints: widget.suffixConstraints,
        isDense: true,
        contentPadding: widget.contentPadding ?? EdgeInsets.all(19.w),
        fillColor: widget.fillColor,
        filled: widget.filled,
        border: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.w),
              borderSide: BorderSide(
                color: primaryColor.withOpacity(0.1),
                width: 1,
              ),
            ),
        enabledBorder: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.w),
              borderSide: BorderSide(
                color: primaryColor.withOpacity(0.1),
                width: 1,
              ),
            ),
        focusedBorder: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.w),
              borderSide: const BorderSide(
                color: primaryColor,
                width: 1,
              ),
            ),
      );
}

/// Extension for [CustomTextFormField] to get different styles
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlineOnPrimaryTL14 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.w),
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.1),
          width: 1,
        ),
      );
}
