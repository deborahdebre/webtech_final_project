import 'package:final_proj_14/view_profile_page.dart';
import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'logout_page.dart';
import 'create_post_page.dart';
import 'feed_page.dart';
import 'global_vars.dart';
import 'view_profile_page.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int userId = globalVars.idNumber;

    return MaterialApp(
      title: 'Deb Social Media App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultPage(),
      routes: {
        '/edit_profile': (context) =>
            EditProfilePage(
              idNumber: '${globalVars.idNumber}',
              name: '${globalVars.name}',
              email: '${globalVars.email}',
              dob: '${globalVars.dob}',
              yearGroup: globalVars.yearGroup,
              major: '${globalVars.major}',
              hasResidence: globalVars.hasResidence,
              bestFood: '${globalVars.bestFood}',
              bestMovie: '${globalVars.bestMovie}',
            ),
        '/logout': (context) => LogoutPage(),
        '/create_post': (context) => CreatePostPage(),
        '/feed': (context) => FeedPage(),
        '/view_profile': (context) => ViewProfilePage(),
      },
    );
  }
}

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  Future<String>? _nameFuture;

  @override
  void initState() {
    super.initState();
    _nameFuture = _loadName();
  }

  Future<String> _loadName() async {
    return globalVars.name ?? 'Guest';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: FutureBuilder<String>(
          future: _nameFuture,
          builder: (context, snapshot) {
            return Row(
              children: [
                Text(
                  'Welcome, ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  snapshot.data ?? 'Guest',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Deb Social Media App',
                style: TextStyle(fontSize: 18),
              ),
              decoration: BoxDecoration(
                color: Colors.blue[900],
              ),
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('View Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/view_profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/edit_profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Create Post'),
              onTap: () {
                Navigator.pushNamed(context, '/create_post');
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Feed'),
              onTap: () {
                Navigator.pushNamed(context, '/feed');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushNamed(context, '/logout');
              },
            ),
          ],
        ),
      ),
      body: Navigator(
        initialRoute: '/feed',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/edit_profile':
              builder = (BuildContext context) =>
                  EditProfilePage(
                idNumber: '${globalVars.idNumber}',
                name: '${globalVars.name}',
                email: '${globalVars.email}',
                dob: '${globalVars.dob}',
                yearGroup: globalVars.yearGroup,
                major: '${globalVars.major}',
                hasResidence: globalVars.hasResidence,
                bestFood: '${globalVars.bestFood}',
                bestMovie: '${globalVars.bestMovie}',
              );
              break;
            case '/logout':
              builder = (BuildContext context) => LogoutPage();
              break;
            case '/create_post':
              builder = (BuildContext context) => CreatePostPage();
              break;
            case '/view_profile':
              builder = (BuildContext context) => ViewProfilePage();
              break;
            case '/feed':
            default:
              builder = (BuildContext context) => FeedPage();
              break;
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
