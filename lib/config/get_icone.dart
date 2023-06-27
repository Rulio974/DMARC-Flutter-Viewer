import 'package:flutter/material.dart';

IconData getIconForName(String iconName) {
  switch (iconName) {
    case 'facebook':
      {
        return Icons.facebook;
      }
    case 'add':
      {
        return Icons.arrow_circle_down;
      }

    default:
      {
        return Icons.interests;
      }
  }
}
