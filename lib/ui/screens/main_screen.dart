import 'package:flutter/material.dart';
import 'package:todoapp/const.dart';
import 'package:todoapp/size_config.dart';
import 'package:todoapp/ui/screens/add_new_task.dart';
import 'package:todoapp/ui/widgets/category_button.dart';
import 'package:todoapp/ui/views/tasks_list.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentSelectedIndex;
  bool currentState = false;
  String categoryName;

  List<String> titleList = ['All', 'Must', 'Should', 'Could', 'Won\'t'];

  @override
  void initState() {
    super.initState();
    currentSelectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.blockSizeHorizontal * 6,
                  SizeConfig.blockSizeVertical * 10,
                  SizeConfig.blockSizeHorizontal * 5,
                  SizeConfig.blockSizeVertical * 3),
              child: Column(children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Text(
                    'Your tasks',
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 4.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -SizeConfig.blockSizeVertical * 0.2),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Category',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeVertical * 2.5,
                        fontWeight: FontWeight.w700,
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
                                  currentState = !currentState;
                                  categoryName = titleList[index];
                                });
                              },
                              isSelected: currentSelectedIndex == index,
                            );
                          }),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 6),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xFF25262D),
              ),
              child: TasksList(
                categoryName: categoryName,
              ),
            ),
          )),
          Padding(
            padding: EdgeInsets.only(
              bottom: SizeConfig.blockSizeVertical * 6,
              top: SizeConfig.blockSizeVertical * 3,
            ),
            child: Container(
              height: 55.0,
              child: RaisedButton(
                onPressed: () async {
                  var selectedButton = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
                  );
                  setState(() {
                    if (selectedButton == 'Must') {
                      categoryName = 'Must';
                      currentSelectedIndex = 1;
                    } else if (selectedButton == 'Should') {
                      categoryName = 'Should';
                      currentSelectedIndex = 2;
                    } else if (selectedButton == 'Could') {
                      categoryName = 'Could';
                      currentSelectedIndex = 3;
                    } else if (selectedButton == 'Won\'t') {
                      categoryName = 'Won\'t';
                      currentSelectedIndex = 4;
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: kGradient,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: SizeConfig.blockSizeHorizontal * 60,
                        minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Add new task",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeVertical * 1.8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
