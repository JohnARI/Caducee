import 'package:caducee/common/const.dart';
import 'package:flutter/material.dart';
import 'package:caducee/services/authentication.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {

final user = AuthenticationService().getCurrentUser();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: myGreen,
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // image
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/iconLogo.png'),
                        ),
                      ),
                    ),
                    Text('Caducée', style: TextStyle(color: Colors.grey[200], fontSize: 18.0)),
                    Text(user!.email ?? '', style: TextStyle(color: Colors.grey[200], fontSize: 14.0)),                   
                  ],
                ),
              ),
              const ListTile(
                leading: Text('🅹'),
                title: Text('Je'),
                
              ),
              const ListTile(
                leading: Text('🆃'),
                title: Text('T\'aime'),
                
              ),
              const ListTile(
                leading: Text('🅼'),
                title: Text('Manon'),
                
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Déconnexion"),
                onTap: () {
                  // Make me log out
                  AuthenticationService().signOut();
                },
              ),
            ],
          ),
        ),
      );
  }
}