import 'package:app/models/user.dart';
import 'package:app/providers/get_user.dart';
import 'package:app/views/search/widgets/profile.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  static const String routeName = '/user';

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final GlobalKey<ExpansionTileCardState> profile = GlobalKey();
  final GlobalKey<ExpansionTileCardState> skills = GlobalKey();
  final GlobalKey<ExpansionTileCardState> projects = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String login = arg["login"];
    final LocalStorage storage = LocalStorage('client_info');

    Future<User> user = Provider.of<GetUser>(context, listen: false)
        .fetchUser(storage.getItem("client")["access_token"], login);

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color.fromARGB(255, 138, 135, 135)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0XFF434343),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: FutureBuilder<User>(
              future: user,
              builder: (context, AsyncSnapshot<User> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Color(0XFF434343),
                      )),
                    );
                  }

                  // récupérer le level le plus élevé automatiquement

                  double p = 0;
                  for (var i = 0; i < snapshot.data!.cursusUsers.length; i++) {
                    p = snapshot.data!.cursusUsers[i]["level"];
                  }

                  return Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Profile(
                          imgUrl: snapshot.data!.imgUrl,
                          login: snapshot.data!.login,
                          email: snapshot.data!.email,
                          grade: snapshot
                              .data!
                              .cursusUsers[snapshot.data!.cursusUsers.length -
                                  1]["grade"]
                              .toString(),
                          correc: snapshot.data!.pointCorrec,
                          level: p,
                          wallet: snapshot.data!.wallet),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ExpansionTileCard(
                          key: skills,
                          leading: const SizedBox(
                            child: Icon(Icons.science),
                          ),
                          title: const Text(
                            "Skills",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
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
                            for (var i = 0;
                                i <
                                    snapshot
                                        .data!
                                        .cursusUsers[
                                            snapshot.data!.cursusUsers.length -
                                                1]["skills"]
                                        .length;
                                i++)
                              Center(
                                child: Wrap(children: [
                                  Text(
                                    "${snapshot.data!.cursusUsers[snapshot.data!.cursusUsers.length - 1]["skills"][i]["name"]} : ${snapshot.data!.cursusUsers[snapshot.data!.cursusUsers.length - 1]["skills"][i]["level"]} %",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0XFF434343),
                                    ),
                                  ),
                                ]),
                              ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ExpansionTileCard(
                          key: projects,
                          leading: const SizedBox(
                            child: Icon(Icons.work),
                          ),
                          title: const Text(
                            "Projects",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
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
                            for (var i = 0;
                                i < snapshot.data!.projectUsers.length;
                                i++)
                              Text(
                                snapshot.data!.projectUsers[i]["project"]
                                    ["name"],
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
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  try {
                    if (mounted) {
                      setState(() {});
                    }
                  } catch (e) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "$login n'est pas un étudiant de 42, merci de réessayer !",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0XFF434343),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Color(0XFF434343),
                    )),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Color(0XFF434343),
                  )),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
