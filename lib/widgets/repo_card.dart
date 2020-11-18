import 'package:flutter/material.dart';
import 'package:gendotest/shared/repo_card_type.dart';

class RepoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final RepoCardType cardType;
  final int numberStars;
  final int forked;
  final String language;
  final String nameUser;

  RepoCard({
    this.title,
    this.subtitle,
    this.cardType,
    this.numberStars,
    this.forked,
    this.language,
    this.nameUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardType == RepoCardType.STARRED
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "$nameUser /",
                        style: TextStyle(fontSize: 17, color: Colors.blue),
                      ),
                      Text(
                        " $title",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    " $title",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: subtitle == null
                ? Text(
                    "without description",
                    style: TextStyle(color: Color(0xFF666666)),
                  )
                : Text(
                    "$subtitle",
                    style: TextStyle(color: Color(0xFF666666)),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                cardType == RepoCardType.STARRED
                    ? Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 17,
                            color: Colors.grey[800],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("$numberStars")
                        ],
                      )
                    : Row(
                        children: [
                          Image.asset(
                            'assets/images/language.png',
                            fit: BoxFit.contain,
                            height: 17,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("$language")
                        ],
                      ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/fork.png',
                      fit: BoxFit.contain,
                      height: 17,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("$forked")
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
