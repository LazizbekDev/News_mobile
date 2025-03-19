import 'package:flutter/material.dart';
import 'package:news_app/screens/manage_news_screen.dart';
import 'package:news_app/widgets/tile.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Icon(
              Icons.newspaper,
              size: 80,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(25),
            child: Divider(),
          ),
          Tile(
            text: "Manage news",
            icon: Icons.edit_square,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const ManageNewsScreen(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
