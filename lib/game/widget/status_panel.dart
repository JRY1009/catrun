import 'package:catrun/res/styles.dart';
import 'package:catrun/utils/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusPanel extends StatefulWidget {
  @override
  _StatusPanelState createState() => _StatusPanelState();
}

class _StatusPanelState extends State<StatusPanel> {

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildStatus(name, value) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 5.dp),
      padding: EdgeInsets.symmetric(horizontal: 5.dp, vertical: 3.dp),
      child: Text.rich(TextSpan(
          children: [
            TextSpan(text: '${name}: ', style: TextStyles.textMain14),
            TextSpan(text: '${value}', style: TextStyles.textMain14),
          ]
      ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 3.dp),
      child: Column(
        children: [
          Container(child: Text('第一天', style: TextStyles.textMain16_w700)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatus('生命', 100),
                  _buildStatus('饱食', 100),
                  _buildStatus('攻击', 10),
                  _buildStatus('防御', 0),
                ]
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatus('力量', 100),
                    _buildStatus('体格', 100),
                    _buildStatus('灵巧', 10),
                  ]
              )
            ],
          ),
        ],
      ),
    );
  }

}
