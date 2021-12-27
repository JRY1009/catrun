

import 'game/page/diary_page.dart';
import 'game/page/game_over.dart';
import 'game/page/main_page.dart';
import 'game/page/menu_page.dart';
import 'game/page/time_page.dart';
import 'game/page/warehouse_page.dart';
import 'router/i_router.dart';
import 'router/page_builder.dart';
import 'router/routers.dart';

class MainRouter implements IRouter{

  @override
  List<PageBuilder> getPageBuilders() {
    return [
      PageBuilder(Routers.menuPage, (_) => MenuPage()),
      PageBuilder(Routers.mainPage, (_) => MainPage()),
      PageBuilder(Routers.diaryPage, (_) => DiaryPage()),
      PageBuilder(Routers.timePage, (_) => TimePage()),
      PageBuilder(Routers.warehousePage, (_) => WareHousePage()),
      PageBuilder(Routers.gameOver, (_) => GameOver()),
    ];
  }

}