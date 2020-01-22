import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import '../../store/home_store.dart';
import '../../data/db_repository.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<HomeStore>(
      create: (_) => HomeStore(repo: DbDataRepository.db()),
      child: HomeLayout(),
    );
  }
}
