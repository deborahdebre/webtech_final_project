import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'login_page.dart';

class StartupPage extends StatefulWidget {
  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  void _handleRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  void _handleLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..forward();
    _animation = Tween<Offset>(
      begin: Offset(0.0, 2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Page'),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 30),
            SlideTransition(
              position: _animation,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Text(
                  "Welcome to Deb's Social Media App 😊",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 150,
                width: 150,
                child: Icon(
                  Icons.link,
                  color: Colors.blue[900],
                  size: 100,
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _handleRegister,
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20, color: Colors.grey[100]),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      onPrimary: Color(0x000221),
                      minimumSize: Size(200, 60),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[900],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[100],
                      onPrimary: Colors.blue[900],
                      minimumSize: Size(200, 60),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
