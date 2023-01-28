import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/utils/habit_tile.dart';


class HomePage extends StatefulWidget {
    const HomePage({Key? key}) : super(key: key);
  
    @override
    State<HomePage> createState() => _HomePageState();
  }
  
  class _HomePageState extends State<HomePage> {

    //overall habit Summary
    List habitList = [
      //[HabitName , habitStarted , timeSpent , GoalTIme]
      ['Exercise' , false , 0 , 10 ],
      ['Read' , false , 0 , 50 ],
      ['Meditate' , false , 0 , 20 ],
      ['Code' , false , 0 , 15 ],

    ];

    void habitStarted(int index) {
      var startTime = DateTime.now();
      int elapsedTime = habitList[index][2];
        setState(() {
          habitList[index][1] =!habitList[index][1];
        });
        if(habitList[index][1]){
          Timer.periodic(
              Duration(seconds: 1) , (timer) {
            //check when user stopped timer
            setState(() {
              if(habitList[index][1] == false){
                timer.cancel();
              }
              //    calculate time elapsed by comparing current time and start time
              var currentTime = DateTime.now();
              habitList[index][2] = elapsedTime +
                  currentTime.second -
                  startTime.second +
                  60 * (currentTime.minute - startTime.minute) +
                  3600*(currentTime.hour - startTime.hour);
            });
          }
          );
        }

    }
    void settingsOpened(int index) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('Settings for ' + habitList[index][0]),
        );
      }
      );
    }
      @override
    Widget build(BuildContext context) {
      return Scaffold(

        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text('Consistency is the Key.'),

          centerTitle: false,
        ),
        body:
        ListView.builder(
            itemCount: habitList.length,
            itemBuilder: ((context , index) {
          return HabitTile(
              habitName: habitList[index][0],
              onTap: () {
                habitStarted(index);
              },
              settingsTapped: () {
                settingsOpened(index);
              },
              habitStarted: habitList[index][1],
              timeSpent: habitList[index][2],
              goalTime: habitList[index][3],

          );
        }))
      );
    }
  }
  