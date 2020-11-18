import 'package:flutter/cupertino.dart';
import 'package:gendotest/external/api_github.dart';
import 'package:gendotest/models/repos_model.dart';
import 'package:gendotest/shared/repo_card_type.dart';

class ReposDataSingleton extends ChangeNotifier{

  static final ReposDataSingleton _ReposDataSingleton = ReposDataSingleton._internal();
  ApiGithub api;
  List<ReposModel> list;


  factory ReposDataSingleton() {
    return _ReposDataSingleton;
  }

  ReposDataSingleton._internal();


  Future<List<ReposModel>> getRepos(RepoCardType type) async {
    api = ApiGithub();
    if (type == RepoCardType.REPOS) {
      list = await api.getRepos();
      notifyListeners();
    } else {
      list = await api.getReposStarred();
      notifyListeners();
    }
    return list;
  }

  Future<List<ReposModel>>  searchRepos(String value, RepoCardType type) async{
    List<ReposModel> results = List<ReposModel>();
    list.forEach((repos) {
      if (repos.title.contains(value)) {
        results.add(repos);
      }
    });
    if(results.isEmpty){
      getRepos(type);
      notifyListeners();
      return list;
    }else{
      list = results;
      notifyListeners();
      return list;
    }
  }

  int getLength(){
    if(list == null){
      return 0;
    }
    return list.length;
  }


}