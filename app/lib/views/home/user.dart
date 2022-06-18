import 'package:app/models/user.dart';
import 'package:app/providers/get_user.dart';
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
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
                        color: Color(0XFF04BE96),
                      )),
                    );
                  }

                  // récupérer le level le plus élevé automatiquement

                  double p = 0;
                  for (var i = 0; i < snapshot.data!.cursusUsers.length; i++) {
                    p = snapshot.data!.cursusUsers[i]["level"];
                  }

                  for (var i = 0;
                      i <
                          snapshot
                              .data!
                              .cursusUsers[snapshot.data!.cursusUsers.length -
                                  1]["skills"]
                              .length;
                      i++) {
                    print(snapshot.data!
                            .cursusUsers[snapshot.data!.cursusUsers.length - 1]
                        ["skills"][i]["name"]);
                    print(snapshot.data!
                            .cursusUsers[snapshot.data!.cursusUsers.length - 1]
                        ["skills"][i]["level"]);
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(20), // Image border
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(48), // Image radius
                            child: Image.network(snapshot.data!.imgUrl,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text(
                        snapshot.data!.login,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF434343),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text(
                        snapshot.data!.email,
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
                        "Evalutation points : ${snapshot.data!.pointCorrec.toString()}",
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
                        "Wallet : ${snapshot.data!.wallet.toString()} ₳",
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
                        "level : ${p.toString()}",
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
                        "grade : ${snapshot.data!.cursusUsers[snapshot.data!.cursusUsers.length - 1]["grade"].toString()}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF434343),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      for (var i = 0;
                          i <
                              snapshot
                                  .data!
                                  .cursusUsers[
                                      snapshot.data!.cursusUsers.length - 1]
                                      ["skills"]
                                  .length;
                          i++)
                        Center(
                          child: Wrap(children: [
                            Text(
                                "${snapshot.data!.cursusUsers[snapshot.data!.cursusUsers.length - 1]["skills"][i]["name"]} : ${snapshot.data!.cursusUsers[snapshot.data!.cursusUsers.length - 1]["skills"][i]["level"]}%"),
                          ]),
                        ),
                      for (var i = 0;
                          i < snapshot.data!.projectUsers.length;
                          i++)
                        Text(snapshot.data!.projectUsers[i]["project"]["name"]),
                    ],
                  );
                } else if (snapshot.hasError) {
                  Future.delayed(const Duration(seconds: 1),
                      () => {if (mounted) setState(() {})});
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Color(0XFF04BE96),
                    )),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Color(0XFF04BE96),
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
