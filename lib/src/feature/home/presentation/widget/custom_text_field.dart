import 'package:flutter/material.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/util/dimension.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.readOnly = false,
    super.key,
    this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.onChanged,
    this.location = false,
    this.onTap,
    this.onLocationTap,
  });

  final TextEditingController? controller;
  final int minLines;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final bool location;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onLocationTap;

  @override
  Widget build(BuildContext context) => TextField(
    readOnly: readOnly,
    onTap: onTap,
    controller: controller,
    minLines: minLines,
    maxLines: maxLines,
    textAlignVertical: .top,
    cursorColor: context.color.blue,
    onChanged: onChanged,
    decoration: InputDecoration(
      suffixIcon: onLocationTap == null
          ? null
          : GestureDetector(
              onTap: onLocationTap,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(Icons.location_on, color: context.color.blue),
              ),
            ),
      filled: true,
      fillColor: context.color.grey,
      contentPadding: Dimension.pAll12,
      border: const OutlineInputBorder(borderRadius: Dimension.rAll8, borderSide: .none),
      enabledBorder: const OutlineInputBorder(borderRadius: Dimension.rAll8, borderSide: .none),
      focusedBorder: const OutlineInputBorder(borderRadius: Dimension.rAll8, borderSide: .none),
    ),
  );
}
