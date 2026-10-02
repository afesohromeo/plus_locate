import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField(
      {super.key,
      required this.onChanged,
      required this.labelText,
      this.padding,
      this.initialValue,
      this.inputController,
      this.labelColor,
      this.bgColor,
      this.showSuffixIcon = true,
      this.shape,
      this.focusNode,
      this.onEditingComplete,
      this.onSuffixPressed});
  final void Function(String)? onChanged;
  final String labelText;
  final EdgeInsets? padding;
  final String? initialValue;
  final TextEditingController? inputController;
  final Color? labelColor;
  final Color? bgColor;
  final bool? showSuffixIcon;
  final ShapeBorder? shape;
  final FocusNode? focusNode;

  /// Called when the keyboard's action key is pressed.
  final VoidCallback? onEditingComplete;

  /// When set, the search icon becomes a button that calls this.
  final VoidCallback? onSuffixPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveLayout.isMobile(context)
          ? null
          : MediaQuery.sizeOf(context).width * .4,
      child: InputField(
        borderRadius: BorderRadius.circular(
          10,
        ),

        labelColor: labelColor,
        bgColor: bgColor,
        controller: inputController,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        padding: padding ?? EdgeInsets.zero,
        validator: null,
        radius: 10,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),

        // hintText: 'Recherche',
        initialValue: initialValue,
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        labelText: labelText,

        suffixIcon: !showSuffixIcon!
            ? null
            : onSuffixPressed != null
                ? IconButton(
                    icon: Icon(Icons.search_rounded, color: labelColor),
                    onPressed: onSuffixPressed,
                  )
                : Icon(
                    Icons.search_rounded,
                    color: labelColor,
                  ),
      ),
    );
  }
}
