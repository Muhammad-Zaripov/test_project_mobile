import 'package:flutter/material.dart';
import '../../../../common/constant/gen/assets.gen.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/util/dimension.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.onChanged,
    this.location = false,
  });

  final TextEditingController? controller;
  final int minLines;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final bool location;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    minLines: minLines,
    maxLines: maxLines,
    textAlignVertical: .top,
    cursorColor: context.color.blue,
    onChanged: onChanged,
    decoration: InputDecoration(
      suffixIcon: location
          ? Padding(padding: Dimension.pAll12, child: Assets.icons.location.svg(width: 17, height: 17))
          : null,
      filled: true,
      fillColor: context.color.grey,
      contentPadding: Dimension.pAll12,
      border: const OutlineInputBorder(borderRadius: Dimension.rAll8, borderSide: .none),
      enabledBorder: const OutlineInputBorder(borderRadius: Dimension.rAll8, borderSide: .none),
      focusedBorder: const OutlineInputBorder(borderRadius: Dimension.rAll8, borderSide: .none),
    ),
  );
}
