import 'package:flutter/material.dart';

IconData getIconForName(String iconName) {
  switch (iconName) {
    case 'facebook':
      {
        return Icons.facebook;
      }

    default:
      {
        return Icons.interests;
      }
  }
}
