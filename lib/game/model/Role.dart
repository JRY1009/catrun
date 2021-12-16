
import 'package:catrun/game/model/prop.dart';

class Role {

  num? id;
  String? name;
  num? life;    //生命
  num? maxlife; //最大生命
  num? attack;  //攻击
  num? defence; //防御
  num? power;   //力量
  num? physic;  //体格
  num? skill;   //灵巧
  num? explosion; //暴击
  num? block;   //格挡
  num? dodge;   //闪避

  List<Prop>? props;

  Role({
    this.id,
    this.name,
    this.life,
    this.maxlife,
    this.attack,
    this.defence,
    this.power,
    this.physic,
    this.skill,
    this.explosion,
    this.block,
    this.dodge,
    this.props
  });

}

