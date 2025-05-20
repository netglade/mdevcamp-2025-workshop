import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final loggedUser = firebase_auth.FirebaseAuth.instance.currentUser;

    if (loggedUser != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
        ),
        body: ProfileScreen(
          providers: [
            EmailAuthProvider(),
          ],
          actions: [
            SignedOutAction((context) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Signed out'),
                ),
              );
              setState(() {});
            }),
            AccountDeletedAction((context, user) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deleted'),
                ),
              );

              setState(() {});
            }),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: SignInScreen(
        providers: [
          EmailAuthProvider(),
        ],
        showPasswordVisibilityToggle: true,
        actions: [
          AuthStateChangeAction<UserCreated>((context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile created'),
              ),
            );
            setState(() {});
          }),
          AuthStateChangeAction<SignedIn>((context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Signed in'),
              ),
            );

            setState(() {});
          }),
        ],
      ),
    );
  }
}
