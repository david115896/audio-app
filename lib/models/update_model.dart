import 'package:flutter/material.dart';

class Update {
  int id;
  String name;
  String description;

  Update({
    @required this.id,
    @required this.name,
    @required this.description,
  });

  Update.fromJson(Map<String, dynamic> jsonUpdate)
      : id = jsonUpdate['id'],
        name = jsonUpdate['name'],
        description = jsonUpdate['description'];
}
