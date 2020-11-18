import 'package:flutter/material.dart';
import 'package:gendotest/external/api_github.dart';
import 'package:gendotest/models/user_model.dart';

class UserCard extends StatefulWidget {

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  UserModel user;
  ApiGithub api;

  Future<UserModel> getUser()async{
    api = ApiGithub();
    user = await api.getUser();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: getUser(),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot){
        if(snapshot.hasData){
          return Container(
            height: 170,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      snapshot.data.imageUrl)))),
                      SizedBox(
                        width: 13,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data.nameUser,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            snapshot.data.bioUser,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }
}
