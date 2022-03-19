import 'package:flutter/material.dart';
import 'package:todo_fire/app/app.dart';

import 'boostrap.dart';

void main() async {
  await bootstrap(builder: () => const Application());
}
