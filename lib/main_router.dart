

import 'router/i_router.dart';
import 'router/page_builder.dart';
import 'router/routers.dart';

class MainRouter implements IRouter{

  @override
  List<PageBuilder> getPageBuilders() {
    return [
      //PageBuilder(Routers.mainPage, (_) => MainPage()),
    ];
  }

}