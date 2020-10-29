import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/calculation.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

const defaultColor = Color(0xFF1D1E33);
const activeColor = Color(0xFF111328);

Color maleColor = defaultColor;
Color femaleColor = defaultColor;

enum Gender {
  MALE,
  FEMALE,
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 180;
  int weight = 60;
  int age = 18;

  decWeight() {
    setState(() {
      if (weight > 50) weight--;
    });
  }

  incWeight() {
    setState(() {
      if (weight < 150) weight++;
    });
  }

  decAge() {
    setState(() {
      if (age > 15) age--;
    });
  }

  incAge() {
    setState(() {
      if (age < 100) age++;
    });
  }

  void updateColor(Gender gender) {
    setState(() {
      if (gender == Gender.MALE) {
        if (maleColor == defaultColor) {
          maleColor = activeColor;
          femaleColor = defaultColor;
        } else {
          maleColor = defaultColor;
        }
      } else if (gender == Gender.FEMALE) {
        if (femaleColor == defaultColor) {
          femaleColor = activeColor;
          maleColor = defaultColor;
        } else {
          femaleColor = defaultColor;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'BMI Calculator',
          )),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: theContainer(
                        color: selectedGender == Gender.MALE
                            ? activeColor
                            : defaultColor,
                        containerChild: icon(
                            gender: 'MALE', theIcon: FontAwesomeIcons.mars),
                      ),
                      onTap: () {
                        setState(() {
                          selectedGender = Gender.MALE;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: theContainer(
                        color: selectedGender == Gender.FEMALE
                            ? activeColor
                            : defaultColor,
                        containerChild: icon(
                          gender: 'FEMALE',
                          theIcon: FontAwesomeIcons.venus,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedGender = Gender.FEMALE;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: theContainer(
                color: defaultColor,
                containerChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HEIGHT',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          '${height}',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'cm',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 5,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Color(0xFF8D8E98),
                        thumbColor: Color(0xFFEB1555),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30),
                        overlayColor: Color(0xFFEB1555).withOpacity(0.3),
                      ),
                      child: Slider(
                        min: 120,
                        max: 220,
                        value: height.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.toInt();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: theContainer(
                      color: defaultColor,
                      containerChild: secondContainer(
                        text: 'WEIGHT',
                        value: weight,
                        IncFunction: incWeight,
                        DecFunction: decWeight,
                      ),

                      //containerChild: icon(),
                    ),
                  ),
                  Expanded(
                    child: theContainer(
                      color: defaultColor,
                      containerChild: secondContainer(
                        text: 'AGE',
                        value: age,
                        IncFunction: incAge,
                        DecFunction: decAge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                height: 50,
                width: double.infinity,
                //margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFEB1555),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'RESULT',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 3,
                        shadows: [
                          Shadow(
                            offset: Offset(3, 3),
                            color: Color(0xFF1D1E33),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {

                  Calculation calc = Calculation(height: height, weight: weight);

                  Navigator.of(context).pushReplacementNamed('/result', arguments: {
                    'bmi' : calc.calculateBMI(),
                    'result' : calc.result(),
                    'msg' : calc.Message(),

                    /*
                    'gender': (selectedGender.toString() == 'Gender.MALE') ? 'Male' : 'Female' ,
                    'height' : height,
                    'weight' : weight,
                    'age' : age,
                    */
                  });
                });
              },
            ),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class icon extends StatelessWidget {
  String gender;
  IconData theIcon;

  icon({this.gender, this.theIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          theIcon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          gender,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class theContainer extends StatelessWidget {
  final Color color;
  final Widget containerChild;

  theContainer({@required this.color, this.containerChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: containerChild,
    );
  }
}

class secondContainer extends StatelessWidget {
  String text;
  int value;
  Function IncFunction;
  Function DecFunction;

  secondContainer({this.text, this.value, this.IncFunction, this.DecFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${text}',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          '${value}',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              shape: CircleBorder(),
              color: Color(0xFF111328),
              onPressed: () {
                DecFunction();
              },
            ),
            RaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              shape: CircleBorder(),
              color: Color(0xFF111328),
              onPressed: () {
                IncFunction();
              },
            ),
          ],
        ),
      ],
    );
  }
}
