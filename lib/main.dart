import 'package:advent9_advent_door/widget/calendar_door_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'AdventDoor';
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appTitle,
        theme: ThemeData(
            primaryColor: Colors.red,
            textTheme: TextTheme(headline: TextStyle(fontSize: 64.0))),
        home: MainPage(
          appTitle: appTitle,
        ),
      );
}

class MainPage extends StatelessWidget {
  final String appTitle;

  const MainPage({this.appTitle});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: Center(
          child: Container(
            width: 200.0,
            height: 200.0,
            child: CalendarDoorWidget(
              child: Image.asset('images/advent9.png', fit: BoxFit.fill),
              outerDoor: buildOuterDoor(context, number: 8),
              innerDoor: buildInnerDoor(context),
            ),
          ),
        ),
      );

  Widget buildOuterDoor(BuildContext context, {int number}) => Container(
        color: Colors.red,
        child: Center(
            child: Text('$number',
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: Colors.white))),
      );

  Widget buildInnerDoor(BuildContext context) => Container(
        color: Colors.green[700],
      );
}
