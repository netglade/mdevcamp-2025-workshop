import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Account')), body: const Center(child: Text('Account')));
  }
}

// * Firebase Auth Path

// class AccountPage extends StatefulWidget {
//   const AccountPage({super.key});

//   @override
//   State<AccountPage> createState() => _AccountPageState();
// }

// class _AccountPageState extends State<AccountPage> {
//   @override
//   Widget build(BuildContext context) {
//     final user = firebase_auth.FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       return ProfileScreen(
//         appBar: AppBar(title: const Text('Account - Profile')),
//         providers: [
//           //  EmailAuthProvider(),
//         ],
//         // actions: [
//         //   SignedOutAction((context) {
//         //     setState(() {});
//         //   }),
//         //   AccountDeletedAction((context, user) {
//         //     ScaffoldMessenger.of(context).showSnackBar(
//         //       const SnackBar(
//         //         content: Text('Account deleted'),
//         //       ),
//         //     );

//         //     setState(() {});
//         //   }),
//         // ],
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text('Account - ${user?.uid ?? 'NOT SIGNED IN'}')),
//       body: SignInScreen(
//         showPasswordVisibilityToggle: true,
//         providers: [
//           // EmailAuthProvider(),
//         ],
//         actions: [
//           // AuthStateChangeAction<UserCreated>((context, state) {
//           //   ScaffoldMessenger.of(context).showSnackBar(
//           //     const SnackBar(
//           //       content: Text('Profile created'),
//           //     ),
//           //   );
//           //   setState(() {});
//           // }),
//           // AuthStateChangeAction<SignedIn>((context, state) {
//           //   ScaffoldMessenger.of(context).showSnackBar(
//           //     const SnackBar(
//           //       content: Text('Signed in'),
//           //     ),
//           //   );

//           //   setState(() {});
//           // }),
//         ],
//       ),
//     );
//   }
// }
