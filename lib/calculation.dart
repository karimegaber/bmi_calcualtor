import 'dart:math';

import 'package:flutter/material.dart';

class Calculation
{

  final int height;
  final int weight;

  double _bmi;

  Calculation({ this.height, this.weight });

  String calculateBMI()
  {
    _bmi = weight / pow(height / 100 , 2);
    return _bmi.toStringAsFixed(1);
  }

  String result()
  {
    if ( _bmi >= 25 )
      {
        return 'OVERWEIGHT';
      }
    else if ( _bmi < 25 && _bmi > 18.5 )
      {
        return 'NORMAL';
      }
    else
      {
        return 'UNDERWEIGHT';
      }
  }

  String Message()
  {
    if ( _bmi >= 25 )
    {
      return 'You have a higher than normal body weight, \nTry to exercise more.';
    }
    else if ( _bmi < 25 && _bmi > 18.5 )
    {
      return 'You have a normal body weight, \nGOOD JOB!';
    }
    else
    {
      return 'You have a lower than normal body weight, \nYou can eat more.';
    }
  }


}