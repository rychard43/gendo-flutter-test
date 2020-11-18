import 'package:flutter/material.dart';
import 'package:gendotest/external/api_github.dart';
import 'package:gendotest/models/repos_model.dart';
import 'package:gendotest/shared/data_singleton.dart';
import 'package:gendotest/shared/repo_card_type.dart';
import 'package:gendotest/widgets/custom_list_view.dart';

class TabWidget extends StatefulWidget {
  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  var data = ReposDataSingleton();

  Future<String> getCountRepos() async {
    List<ReposModel> list = List<ReposModel>();
    var api = ApiGithub();
    list = await api.getRepos();
    return list.length.toString();
  }

  Future<String> getCountReposStarred() async {
    List<ReposModel> list = List<ReposModel>();
    var api = ApiGithub();
    list = await api.getReposStarred();
    return list.length.toString();
  }

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.0),
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.8,
                ))),
            child: TabBar(
              tabs: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: new Text(
                        'Repos',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Center(
                        child: FutureBuilder(
                          future: getCountRepos(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                      width: 30.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: new Text(
                        'Starred',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Center(
                        child: FutureBuilder(
                          future: getCountReposStarred(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                      width: 30.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              unselectedLabelColor: Colors.black54,
              indicatorColor: Color(0xFFE36209),
              labelColor: Colors.black,
              isScrollable: false,
              controller: _tabController,
              indicatorWeight: 7,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  child: CustomListView(RepoCardType.REPOS),
                ),
                Container(
                  child: CustomListView(RepoCardType.STARRED),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
