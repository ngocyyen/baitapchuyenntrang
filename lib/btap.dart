import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

// Màn hình đăng nhập
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (!_isValidEmail(email)) {
      _showDialog('Email sai định dạng');
    } else if (email.length < 6 || password.length < 6) {
      _showDialog('Username hoặc password không hợp lệ');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListViewScreen(),
        ),
      );
    }
  }

  bool _isValidEmail(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Nhập Email:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Nhập mật khẩu:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// Màn hình hiển thị cả ListView tĩnh và động
class ListViewScreen extends StatelessWidget {
  final List<Map<String, String>> dynamicUsers = [
  {'name': 'User A', 'email': 'userA@example.com'},
{'name': 'User B', 'email': 'userB@example.com'},
    {'name': 'User C', 'email': 'userC@example.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('User 1 (TĨNH)'),
                  subtitle: Text('Email: user1@example.com'),
                  onTap: () {
                    _showDetail(
                      context,
                      'User 1 (TĨNH)',
                      'user1@example.com',
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('User 2 (Tĩnh)'),
                  subtitle: Text('Email: user2@example.com'),
                  onTap: () {
                    _showDetail(
                      context,
                      'User 2 (TĨNH)',
                      'user2@example.com',
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('User 3 (TĨNH)'),
                  subtitle: Text('Email: user3@example.com'),
                  onTap: () {
                    _showDetail(
                      context,
                      'User 3 (TĨNH)',
                      'user3@example.com',
                    );
                  },
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: dynamicUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(dynamicUsers[index]['name']!),
                  subtitle: Text('Email: ${dynamicUsers[index]['email']}'),
                  onTap: () {
                    _showDetail(
                      context,
                      dynamicUsers[index]['name']!,
                      dynamicUsers[index]['email']!,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDetail(BuildContext context, String name, String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(name: name, email: email),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String name;
  final String email;

  DetailScreen({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Thông tin chi tiết'),
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tên: $name',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}