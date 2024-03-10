

import 'package:flutter/material.dart';

class DashBoardProvider extends ChangeNotifier
{

   int value = 0;
  getVlaue(int x) {
    value = x;
  
  }
}