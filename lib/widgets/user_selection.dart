import 'package:flutter/material.dart';
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

  @override
  void initState() {
    getData();
    super.initState();
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: (() => widget.usersCtrCallback(0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                  Text(
                    'Choose your account here ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 600,
            //  width: 100,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
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
                        width: 100,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
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
                        )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
