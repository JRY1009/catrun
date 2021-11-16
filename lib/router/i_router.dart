import 'package:catrun/router/page_builder.dart';
import 'package:fluro/fluro.dart';

abstract class IRouter {
  List<PageBuilder> getPageBuilders();
}