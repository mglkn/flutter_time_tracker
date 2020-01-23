import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './src/app.dart';
import './src/store/home_store.dart';
import './src/data/db_repository.dart';

void main() {
  runApp(
    Provider<HomeStore>(
      create: (_) => HomeStore(repo: DbDataRepository.db()),
      child: App(),
    ),
  );
}
