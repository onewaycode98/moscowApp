import 'package:flutter/material.dart';
import 'package:todoapp/const.dart';
import 'package:todoapp/size_config.dart';

class CategoryButton extends StatefulWidget {
  String title;
  VoidCallback onSelect;
  Color backgroundButtonColor;
  Color textColor;
  bool isSelected;

  CategoryButton(
      {@required this.title,
      this.isSelected,
      this.onSelect,
      this.backgroundButtonColor,
      this.textColor});

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  List<String> titleList = ['All', 'Must', 'Should', 'Could', 'Won\'t'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 1,
        ),
        child: Container(
            decoration: widget.isSelected
                ? BoxDecoration(
                    gradient: kGradient,
                    borderRadius: BorderRadius.circular(30.0),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xFF25262D),
                  ),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 3.0,
              ),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 1.7,
                    color: widget.isSelected ? Colors.white : kLightGrey,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0),
              ),
            )),
      ),
    );
  }
}
