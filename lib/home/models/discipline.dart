import 'package:flutter/material.dart';

class Discipline {
  final String id;
  final String name;
  final String icon; 
  final String? tag;
  final int? count;
  final Color? color;

  Discipline({
    required this.id,
    required this.name,
    required this.icon,
    this.tag,
    this.count,
    this.color,
  });
}
