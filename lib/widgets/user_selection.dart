import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/settings.dart';
import '../models/users.dart';
import '../services/api_service.dart';

class UserSelection extends StatefulWidget {
  final Function(int i) usersCtrCallback;
  const UserSelection({super.key, required this.usersCtrCallback});

  @override
  State<UserSelection> createState() => _UserSelectionState();
}

class _UserSelectionState extends State<UserSelection> {
  List<Users>? user = [];
  bool isLoaded = false;
  bool initialPage = true;

  @override
  void initState() {
    getData();
    _loadPage();
    super.initState();
  }

  Future<void> _loadPage() async {
    final prefs = await SharedPreferences.getInstance();
    if ((prefs.getInt('user')) != null) {
      setState(() {
        initialPage = false;
      });
    }
  }

  Future<void> _clearPage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    Settings.reset = true;
    setState(() {
      initialPage = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      widget.usersCtrCallback(0);
    });
  }

  getData() async {
    user = await FetchUsers().getAllUsers();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width < 600 ? 15 : 40,
        ),
        GestureDetector(
          onTap: (() => widget.usersCtrCallback(0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: !initialPage,
                      replacement: Row(
                        children: const [
                          Image(
                            image: AssetImage('assets/images/twitter.png'),
                            height: 20,
                            width: 20,
                            color: Colors.lightBlue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Welcome to Twitter Clone',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back),
                          Container(
                            color: Colors.transparent,
                            width: 20,
                            height: 20,
                          ),
                          const Text(
                            'Go back',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: MediaQuery.of(context).size.width > 600,
                      child: Text(
                        'Choose your account here ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: MediaQuery.of(context).size.width < 600,
                  child: Text(
                    'Choose your account here ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: CircularProgressIndicator(),
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 90,
            child: ListView.builder(
              itemCount: user!.length,
              itemBuilder: (context, index) {
                int userId = user![index].userId as int;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onTap: () {
                      widget.usersCtrCallback(userId);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white10,
                      ),
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      'assets/images/user$userId.jpeg'),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        user![index].firstName.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        user![index].lastName.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    user![index].handle.toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Visibility(
                            visible:
                                index + 1 == Settings.userId && !initialPage,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image(
                                    image: AssetImage('assets/images/tick.png'),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                  icon: const Icon(Icons.more_vert),
                                  color: Theme.of(context).primaryColorLight,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
  // Alert Dialogs

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Logout", style: TextStyle(color: Colors.red)),
      onPressed: () {
        _clearPage();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Logout Default User"),
      content: const Text(
          'Press "Logout" if you want to logout the default user and get the\nUser Selection Screen next time you run this application'),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
