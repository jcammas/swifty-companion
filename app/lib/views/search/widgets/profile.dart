import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String imgUrl;
  final String login;
  final String email;
  final String grade;
  final int correc;
  final int wallet;
  final double level;

  Profile({
    Key? key,
    required this.imgUrl,
    required this.login,
    required this.email,
    required this.grade,
    required this.correc,
    required this.level,
    required this.wallet,
  }) : super(key: key);

  final GlobalKey<ExpansionTileCardState> profile = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTileCard(
        key: profile,
        leading: SizedBox(
          child: Image.network(imgUrl, fit: BoxFit.cover),
        ),
        title: Text(
          login,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0XFF434343),
          ),
        ),
        subtitle: Text(
          email,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0XFF434343),
          ),
        ),
        children: <Widget>[
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Text(
            "Evalutation points : ${correc.toString()}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0XFF434343),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Text(
            "Wallet : ${wallet.toString()} ₳",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0XFF434343),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Text(
            "level : ${level.toString()} %",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0XFF434343),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Text(
            "grade : $grade",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0XFF434343),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
        ],
      ),
    );
  }
}
