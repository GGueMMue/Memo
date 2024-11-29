import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '사용자 이름',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.note),
            title: Text('메모'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/memolist');
            },
          ),
          ListTile(
            leading: Icon(Icons.alarm),
            title: Text('리마인더'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/reminderlist');
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('휴지통'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/trash');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('설정'),
            onTap: () {
              // TODO: 설정 화면으로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('로그아웃'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}

