import 'package:flutter/widgets.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/core/values/icons.dart';

List<Icon> getIcons() {
  return [
    const Icon(
      IconData(personIcon, fontFamily: 'MaterialIcons'),
      color: purple,
    ),
    const Icon(
      IconData(workIcon, fontFamily: 'MaterialIcons'),
      color: pink,
    ),
    const Icon(
      IconData(movieIcon, fontFamily: 'MaterialIcons'),
      color: green,
    ),
    const Icon(
      IconData(sportIcon, fontFamily: 'MaterialIcons'),
      color: yellow,
    ),
    const Icon(
      IconData(travelIcon, fontFamily: 'MaterialIcons'),
      color: deepPink,
    ),
    const Icon(
      IconData(shopIcon, fontFamily: 'MaterialIcons'),
      color: lightBlue,
    ),
  ];
}
