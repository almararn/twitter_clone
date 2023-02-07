import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/alert_dialogs.dart';
import '../services/api_service.dart';
import '../models/users.dart';
import '../settings.dart';

class UserSelection extends StatefulWidget {
  final Function(int i) usersCtrCallback;
  const UserSelection({super.key, required this.usersCtrCallback});

  @override
  State<UserSelection> createState() => _UserSelectionState();
}

class _UserSelectionState extends State<UserSelection> {
  List<Users>? user = [];
  bool isLoaded = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> _clearPage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    Settings.reset = true;
    setState(() {
      Settings.initialPage = true;
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
    int actualWidth = MediaQuery.of(context).size.width.toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: actualWidth < 600 ? 15 : 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: !Settings.initialPage,
                    replacement: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
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
                    ),
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onTap: (() => widget.usersCtrCallback(0)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 15.0, top: 5.0, bottom: 5.0),
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
                    ),
                  ),
                  Visibility(
                    visible: actualWidth > 600,
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
                visible: actualWidth < 600,
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
        const SizedBox(
          height: 2,
        ),
        Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: CircularProgressIndicator(),
            ),
          ),
          child: Expanded(
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
                            visible: index + 1 == Settings.userId &&
                                !Settings.initialPage,
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
                                    showAlertDialog3(context, _clearPage);
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
}
