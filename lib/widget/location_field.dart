import 'package:carwash/consts/const_colors.dart';
import 'package:flutter/material.dart';
class LocationField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: size.width,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: KbtnColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          style: TextStyle(
            fontSize: 20,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
              border: InputBorder.none,
              hintText: 'Your Location',
              hintStyle: TextStyle(
                fontSize: 18,
                color: KtextColor.withOpacity(.7),
              ),
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.location_on,
                  color: KbtnColor,
                  size: 25,
                ),
              )),
        ),
      ),
    );
  }
}
