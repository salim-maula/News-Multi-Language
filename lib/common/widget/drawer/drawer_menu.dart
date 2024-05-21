import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Container(
              child: Image.asset('assets/images/icon_user.png'),
            ),
            accountName: const Text('Develop kolink'), 
            accountEmail: const Text('developkolink.com')),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Beranda'),
            onTap: (){
            },
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text('Technology'),
            onTap: (){
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('Business'),
            onTap: (){
              
            },
          ),
          ],
      ),
    );
  }
}