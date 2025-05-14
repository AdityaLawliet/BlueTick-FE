import 'dart:convert';
import 'package:bluetick/Screens/signin.dart';
import 'package:bluetick/env.dart';
import 'package:bluetick/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _name;
  String? _email;
  String? _phoneNumber;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final token = await TokenManager.getToken();
      if (token == null) {
        _navigateToSignIn();
        return;
      }

      // Decode JWT to get userId
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      final userId = payload['userId'];

      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/user/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          _name = jsonResponse['user']['name'];
          _email = jsonResponse['user']['email'];
          _phoneNumber = jsonResponse['user']['phoneNumber'];
          _isLoading = false;
        });
      } else {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          _error = jsonResponse['message'] ?? 'Failed to fetch user data';
          _isLoading = false;
        });
        if (response.statusCode == 401) {
          await TokenManager.clearToken();
          _navigateToSignIn();
        }
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  void _navigateToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'BlueTick',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () async {
              await TokenManager.clearToken();
              _navigateToSignIn();
            },
          ),
        ],
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _error != null
                ? Text(
                    _error!,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.red,
                        ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome, $_name!',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Email: ${_email ?? "Not provided"}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Phone: $_phoneNumber',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
      ),
    );
  }
}
