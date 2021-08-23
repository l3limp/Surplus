import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:surplus/screens/sign_in.dart';
import 'package:surplus/screens/user_info.dart';
import 'package:surplus/utils/authentication.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
                user.displayName!,
              style: TextStyle(
                  color: Colors.orange
              ),
            ),
            accountEmail: Text(
                user.email!,
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(user.photoURL!),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.amber[400],
            ),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => UserInfoScreen(
                    user: user,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.amber[400],
            ),
            title: Text('Cart'),
            onTap: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.amber[400],
            ),
            title: Text('Logout'),
            onTap: () async {
              await Authentication.signOut(context: context);
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(
                builder: (context) => SignInScreen()
                ),
              );
            },
          )
        ],
      ),
    );
  }
}