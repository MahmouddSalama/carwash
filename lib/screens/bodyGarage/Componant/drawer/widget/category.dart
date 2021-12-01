import 'package:carwash/consts/const_colors.dart';
import 'package:flutter/material.dart';

class CategoryListTile extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function function;

  const CategoryListTile({
    Key? key,
   required this.text,
   required this.iconData,
   required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>function(),
      title: Text(
        text,
        style: TextStyle(
          color: KbtnColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        color: KtextColor,
        size: 25,
      ),
      leading: Icon(
        iconData,
        color: KbtnColor,
        size: 25,
      ),
    );
  }
}
