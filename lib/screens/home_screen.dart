import 'package:flutter/material.dart';
import 'package:gendotest/external/api_github.dart';
import 'package:gendotest/shared/data_singleton.dart';

import 'package:gendotest/widgets/tabwidget.dart';
import 'package:gendotest/widgets/user_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final Widget svgIcon = SvgPicture.asset(
    'assets/images/github.svg',
    color: Colors.white,
    width: 30,
    height: 30,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5C646D),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: svgIcon,
            ),
            Text(
              "Github ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "profiles",
              style: TextStyle(
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          UserCard(),
          Expanded(
            child: TabWidget(),
          ),
        ],
      ),
    );
  }
}
