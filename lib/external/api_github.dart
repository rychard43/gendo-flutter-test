import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gendotest/models/repos_model.dart';
import 'package:gendotest/models/user_model.dart';

class ApiGithub {
  var resBody;

  Future<UserModel> getUser() async {
    try {
      UserModel user = UserModel();
      var response = await http.get("https://api.github.com/users/rychard43");
      resBody = json.decode(response.body);
      user.nameUser = resBody['name'];
      user.imageUrl = resBody['avatar_url'];
      user.bioUser = resBody['bio'];
      return user;
    } catch (e) {
      print(e);
    }
  }



  Future<List<ReposModel>> getRepos() async {
    List<ReposModel> list = List<ReposModel>();
    try {
      var response =
          await http.get("https://api.github.com/users/rychard43/repos");
      resBody = json.decode(response.body);
      for (var repo in resBody) {
        list.add(new ReposModel(
          title: repo['name'],
          forked: repo['forks'],
          language: repo['language'],
          subtitle: repo['description'],
        ));
      }
      return list;
    } catch (e) {
      print(e);
    }
  }

  Future<List<ReposModel>> getReposStarred() async {
    List<ReposModel> list = List<ReposModel>();
    try {
      var response =
      await http.get("https://api.github.com/users/rychard43/starred");
      resBody = json.decode(response.body);
      for (var repo in resBody) {
        list.add(new ReposModel(
          title: repo['name'],
          forked: repo['forks'],
          subtitle: repo['description'],
          nameUser: repo['owner']['login'],
          numberStars: repo['stargazers_count']
        ));
      }
      return list;
    } catch (e) {
      print(e);
    }
  }

  Future<List<ReposModel>> searchRepos(String repo) async {
    List<ReposModel> list = List<ReposModel>();
    try {
      var response =
      await http.get("https://api.github.com/users/rychard43/"+repo);
      resBody = json.decode(response.body);
      for (var repo in resBody) {
        list.add(new ReposModel(
            title: repo['name'],
            forked: repo['forks'],
            subtitle: repo['description'],
            nameUser: repo['owner']['login'],
            numberStars: repo['stargazers_count']
        ));
      }
      return list;
    } catch (e) {
      print(e);
    }
  }



}
