import 'package:app/providers/token.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final nameController = TextEditingController();

  @override
  void initState() {
    Provider.of<TokenProvider>(context, listen: false).fetchToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color.fromARGB(255, 138, 135, 135)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Swifty-Companion",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          backgroundColor: const Color(0XFF434343),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: screenWidth * 0.5,
                  child: const Image(
                    image: AssetImage("assets/images/42.png"),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Center(
                child: SizedBox(
                  width: screenWidth * 0.85,
                  child: Card(
                    shadowColor: Colors.grey,
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 208, 208, 208),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        ListTile(
                          title: TextFormField(
                            controller: nameController,
                            autofocus: false,
                            obscureText: false,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.search_rounded,
                                  color: Colors.black),
                              border: UnderlineInputBorder(),
                              hintText: 'Login 42 ...',
                              hintStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                final LocalStorage storage =
                                    LocalStorage('client_info');
                                storage.ready.then((_) async {
                                  if (storage
                                          .getItem("client")["access_token"] !=
                                      null) {
                                    return;
                                  } else {
                                    Provider.of<TokenProvider>(context,
                                            listen: false)
                                        .fetchToken();
                                  }
                                });
                                if (nameController.text.isEmpty) {
                                } else {
                                  Object arguments = {
                                    "login": nameController.text,
                                  };
                                  String query = '/user';
                                  Navigator.pushNamed(context, query,
                                      arguments: arguments);
                                }
                                nameController.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  primary: const Color(0XFF434343),
                                  elevation: 0.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Rechercher'.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
