import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: const TextSpan(
      style: TextStyle(fontSize: 50),
      children: <TextSpan>[
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
      ],
    ),
  );
}

Container SignInSignOutButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    height: 50,
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width - 48,
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
      child: Text(
        isLogin ? 'Log in' : 'Sign up',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}
