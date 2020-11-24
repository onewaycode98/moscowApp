import 'package:flutter/material.dart';
import 'package:todoapp/core/models/CRUD_model.dart';
import 'package:todoapp/core/models/task_model.dart';
import 'package:todoapp/size_config.dart';
import 'package:todoapp/const.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/ui/widgets/category_button.dart';

class AddNewTaskScreen extends StatefulWidget {
  @override
  _AddNewTaskScreenState createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  int currentSelectedIndex;
  String title;
  String categoryName;
  List<String> titleList = ['Must', 'Should', 'Could', 'Won\'t'];

  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<CRUDModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 8,
              left: SizeConfig.blockSizeHorizontal * 6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios)),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                Text(
                  'Create \nnew task',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 4.5,
                      color: kDarkGrey,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -SizeConfig.blockSizeVertical * 0.2),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: SizeConfig.blockSizeVertical * 70,
            decoration: BoxDecoration(
                color: kBackground, borderRadius: BorderRadius.circular(30.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 6,
                      right: SizeConfig.blockSizeHorizontal * 6,
                      top: SizeConfig.blockSizeVertical * 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 1.9,
                          color: kLightGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextField(
                        onChanged: (newValue) {
                          title = newValue;
                        },
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 1.9,
                          color: kDarkGrey,
                          fontWeight: FontWeight.w500,
                        ),
                        cursorColor: kDarkText,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kDarkGrey),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 5),
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 1.9,
                          color: kLightGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
                      SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: titleList.length,
                              itemBuilder: (context, index) {
                                return CategoryButton(
                                  title: titleList[index],
                                  onSelect: () {
                                    setState(() {
                                      currentSelectedIndex = index;
                                      categoryName = titleList[index];
                                    });
                                  },
                                  isSelected: currentSelectedIndex == index,
                                );
                              })),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 8),
                  child: ButtonTheme(
                    minWidth: SizeConfig.blockSizeHorizontal * 50,
                    height: SizeConfig.blockSizeVertical * 6,
                    child: RaisedButton(
                      onPressed: () async {
                        await taskProvider.addTask(
                            Task(title: title, category: categoryName));

                        Navigator.pop(context, categoryName);
                      },
                      elevation: 0.5,
                      color: kDarkText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        "Create task",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeVertical * 1.8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
