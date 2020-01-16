import 'package:auto_route/auto_route_annotations.dart';

import '../ui/screens/screens.dart';

@autoRouter
class $AppRouter {
  @initial
  GoalsScreen goalsScreen;

  TagsScreen tagsScreen;

  TestScreen testScreen;
}
