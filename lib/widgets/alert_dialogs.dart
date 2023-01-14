import 'package:flutter/material.dart';

showAlertDialog1(BuildContext context, VoidCallback deleteTweet) {
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Delete", style: TextStyle(color: Colors.red)),
    onPressed: () {
      deleteTweet();
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Delete Tweet"),
    content: const Text(
        "Are you sure you want to delete this tweet?\nThis action cannot be undone."),
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

showAlertDialog2(BuildContext context) {
  Widget cancelButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Delete Tweet"),
    content: const Text("You can't delete this tweet because it's not yours."),
    actions: [
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

showAlertDialog3(BuildContext context, VoidCallback clearPage) {
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Logout", style: TextStyle(color: Colors.red)),
    onPressed: () {
      clearPage();
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
