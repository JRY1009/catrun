

import 'game/page/game_over.dart';
import 'game/page/main_page.dart';
import 'game/page/menu_page.dart';
import 'game/page/story_page.dart';
import 'game/page/time_page.dart';
import 'router/i_router.dart';
import 'router/page_builder.dart';
import 'router/routers.dart';

class MainRouter implements IRouter{

  @override
  List<PageBuilder> getPageBuilders() {
    return [
      PageBuilder(Routers.menuPage, (_) => MenuPage()),
      PageBuilder(Routers.mainPage, (_) => MainPage()),
      PageBuilder(Routers.storyPage, (_) => StoryPage()),
      PageBuilder(Routers.timePage, (_) => TimePage()),
      PageBuilder(Routers.gameOver, (_) => GameOver()),
    ];
  }

}