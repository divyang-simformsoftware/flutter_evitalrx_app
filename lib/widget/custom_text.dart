import 'package:flutter/material.dart';


class CustomTextDisplay extends StatelessWidget {
  final String data;
  final String headerText;
  const CustomTextDisplay(
      {super.key, required this.data, required this.headerText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    
      text: TextSpan(
        text: headerText,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(color: Colors.grey, fontSize: 12),
        children: [
          TextSpan(
            text: data,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(color: Colors.indigo, fontSize: 15),
          )
        ],
      ),
    );
  }
}
