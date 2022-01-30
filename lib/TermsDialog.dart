import 'package:flutter/cupertino.dart';

class TermsDialogComponent extends StatelessWidget {
  const TermsDialogComponent({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Accept Terms'),
      content: const Text('To continue press Yes'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: const Text('No'),
          onPressed: () {
            print("Refused");
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: const Text('Yes'),
          isDestructiveAction: true,
          onPressed: () {
            print("Accepted");
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}