import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        height: 60,
        width: 300,
        child: TabBar(
          tabs: <Widget>[
            Tab(
                icon: Icon(
                  Icons.home,
                  size: 28,
                ),
                //child: Text('홈', style: TextStyle(fontSize: 9))
            ),
            Tab(
                icon: Icon(
                  Icons.add_circle,
                  size: 28,
                ),
                //child: Text('게시물 등록', style: TextStyle(fontSize: 9))
            ),
            Tab(
                icon: Icon(Icons.account_circle,size: 28,),
            ),
          ],
          labelColor: Color(0xFF957DAD),
          unselectedLabelColor:
          Theme.of(context).highlightColor.withOpacity(0.8),
          indicatorColor: Colors.transparent,
        ),
      ),
    );
  }

}
