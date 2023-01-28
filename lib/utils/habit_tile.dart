import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsTapped;
  final int timeSpent;
  final int goalTime;
  final bool habitStarted;
  const HabitTile({Key? key, required this.habitName,
    required this.onTap,
    required this.settingsTapped,
    required this.timeSpent,
    required this.goalTime,
    required this.habitStarted
  }) : super(key: key);


  //convert seconds into minutes
  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);
    if(secs.length == 1){
      secs = '0' + secs;
    }
    if(mins[1] == '.'){
      mins = mins.substring(0,1);
    }

    return mins + ':' + secs;
  }
  double percentCompleted() {
    return timeSpent / (goalTime*60) ;
  }
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double blockWidth = screenWidth / 100;         //4.11
    double blockHeight = screenHeight/ 100;        //6.83
    final textScale =  MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.only(left:20.0,right:20,top:20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    height: blockHeight * 8.78,
                    width: blockWidth * 14.59,
                    child: Stack(
                      children: [
                        CircularPercentIndicator(
                          radius: blockHeight * 4.39,
                          percent : percentCompleted() < 1 ? percentCompleted():1,
                          progressColor: percentCompleted() > 0.5 ?
                          (percentCompleted() > 0.75 ? Colors.green : Colors.orange ) : Colors.red,
                        ),
                        Center(
                            child: Icon(
                                habitStarted ? Icons.pause : Icons.play_arrow)),
                      ],
                    ),
                  ),
                ),
                // Text('$blockHeight'),         //6.83
                 SizedBox(width: blockWidth * 4.866,),
                // Text('$blockWidth'),         //4.11
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(habitName,
                      style:  TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 18.0 * textScale),
                    ),
                     SizedBox(height: blockHeight*1.46
                     ),
                    Text(
                      formatToMinSec(timeSpent) + '/' + goalTime.toString() + '=' + (percentCompleted()*100).toStringAsFixed(0) + '%',
                      style: const TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ],
            ),

            GestureDetector(
                onTap: settingsTapped,
                child: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
