import 'package:app/pages/emailsettings.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/balances.dart';
import 'package:app/pages/qr.dart';
import 'package:app/pages/settings.dart';
import 'thememanager.dart'; // Import the theme manager
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider<ThemeManager>(
      create: (_) => ThemeManager(),
      child: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        return MaterialApp(
          home: AccountPage(),
          theme: themeManager.themeData,
        );
      },
    );
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/assets/logo2.jpg',
                width: 50.0,
                height: 60.0,
              ),
            ),
            Text(
              'EcoExpence',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue, // Customize the color as needed
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 40, // Adjust the size of the circle avatar as needed
                  child: Text(
                    "JD",
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Keep text aligned to the right
                    children: <Widget>[
                      Text(
                        "John Doe",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "john.doe@example.com",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "1234567891",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.qr_code,
              size: 30,
            ),
            title: Text(
              'Scan Code',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to balances page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRScanPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_balance_wallet,
              size: 30,
            ),
            title: Text(
              'Balance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BalancePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 30,
            ),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              size: 30,
            ),
            title: Text(
              'Email Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to email settings page
            Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmailSettingsPage()),
    );

            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 30,
            ),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
