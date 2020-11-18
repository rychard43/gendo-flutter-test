import 'package:flutter/material.dart';
import 'package:gendotest/models/repos_model.dart';
import 'package:gendotest/shared/data_singleton.dart';
import 'package:gendotest/shared/repo_card_type.dart';
import 'package:gendotest/widgets/repo_card.dart';

class CustomListView extends StatefulWidget {
  RepoCardType type;

  CustomListView(this.type);

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {

  List<ReposModel> list;
  final TextEditingController _textController = new TextEditingController();

  var data = ReposDataSingleton();

  void init() async{
    list = await data.getRepos(widget.type);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    list = List<ReposModel>();
    init();
  }

  @override
  Widget build(BuildContext context) {
    if (list.isNotEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              onSubmitted: (String value) async {
                if (value.isEmpty) {
                  list = await data.getRepos(widget.type);
                  setState(() {});
                } else {
                  list = await data.searchRepos(value, widget.type);
                  setState(() {});
                }
              },
              controller: _textController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Filter by name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.amber,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                ReposModel repo = list[index];
                return widget.type == RepoCardType.REPOS
                    ? RepoCard(
                        title: repo.title,
                        subtitle: repo.subtitle,
                        language: repo.language,
                        forked: repo.forked,
                        cardType: widget.type,
                      )
                    : RepoCard(
                        title: repo.title,
                        nameUser: repo.nameUser,
                        subtitle: repo.subtitle,
                        numberStars: repo.numberStars,
                        forked: repo.forked,
                        cardType: widget.type,
                      );
              },
            ),
          ),
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
