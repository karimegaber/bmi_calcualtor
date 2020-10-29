import 'package:flutter/material.dart';

class result_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var info = ModalRoute.of(context).settings.arguments as Map;

    Color resultColor = (info['result'] == 'OVERWEIGHT'
        ? Colors.redAccent
        : ((info['result'] == 'NORMAL') ? Colors.teal : Colors.yellowAccent));

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'BMI Calculator',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'YOUR',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' RESULT',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEB1555).withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    info['result'],
                    style: TextStyle(
                      fontSize: 25,
                      color: resultColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    info['bmi'],
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    info['msg'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: RaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'RE-CALCULATE',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 3),
                        color: Color(0xFF1D1E33),
                      ),
                    ],
                  ),
                ),
              ),
              color: Color(0xFFEB1555).withOpacity(0.8),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/input');
              },
            ),
          ),
        ],
      ),
    );
  }
}
