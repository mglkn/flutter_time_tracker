import 'package:auto_route/auto_route_annotations.dart';

import '../ui/screens/screens.dart';

@autoRouter
class $AppRouter {
  @initial
  HomeScreen homeScreen;

  TestScreen testScreen;
}
