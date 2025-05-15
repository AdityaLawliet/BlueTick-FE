import 'dart:convert';
import 'package:bluetick/Screens/signin.dart';
import 'package:bluetick/env.dart';
import 'package:bluetick/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  String? _name;
  String? _email;
  String? _phoneNumber;
  bool _isLoading = true;
  String? _error;
  static const double _spacing = 16.0;
  // late TabController _tabController;
  // bool _isInitialized = false; // Track if tabController is initialized

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this);
    // _isInitialized = true; // Set flag after initialization
    _fetchUserData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    try {
      final token = await TokenManager.getToken();
      if (token == null) {
        _navigateToSignIn();
        return;
      }

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

  void _handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'settings':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
        break;
      case 'logout':
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Log Out',
                style: Theme.of(context).dialogTheme.titleTextStyle),
            content: Text(
              'Are you sure you want to log out?',
              style: Theme.of(context).dialogTheme.contentTextStyle,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textButtonTheme
                      .style!
                      .textStyle!
                      .resolve({}),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await TokenManager.clearToken();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logged out successfully'),
                        backgroundColor:
                            Theme.of(context).snackBarTheme.backgroundColor,
                        action: SnackBarAction(
                          label: 'OK',
                          textColor:
                              Theme.of(context).snackBarTheme.actionTextColor,
                          onPressed: () {},
                        ),
                      ),
                    );
                    _navigateToSignIn();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logout failed: $e'),
                        backgroundColor:
                            Theme.of(context).snackBarTheme.backgroundColor,
                      ),
                    );
                  }
                },
                child: Text(
                  'Log Out',
                  style: Theme.of(context)
                      .elevatedButtonTheme
                      .style!
                      .textStyle!
                      .resolve({}),
                ),
              ),
            ],
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'BlueTick',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [
            // Only show tab-specific actions if tabController is initialized
            if (_selectedIndex == 0)
              IconButton(
                icon: Icon(
                  Icons.message,
                  color: Theme.of(context).appBarTheme.actionsIconTheme!.color,
                ),
                tooltip: 'New chat',
                onPressed: () {
                  // Start new chat
                },
              ),
            if (_selectedIndex == 1)
              IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).appBarTheme.actionsIconTheme!.color,
                ),
                tooltip: 'New status',
                onPressed: () {
                  // Add status
                },
              ),
            PopupMenuButton<String>(
              tooltip: 'More options',
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).appBarTheme.actionsIconTheme!.color,
              ),
              onSelected: (value) => _handleMenuSelection(context, value),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Theme.of(context).iconTheme.color,
                        size: Theme.of(context).iconTheme.size,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Settings',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Theme.of(context).colorScheme.error,
                        size: Theme.of(context).iconTheme.size,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
              color: Theme.of(context).dialogTheme.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: const Offset(0, 50),
              elevation: 4,
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : _error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error,
                          color: Theme.of(context).colorScheme.error,
                          size: 48,
                        ),
                        SizedBox(height: _spacing),
                        Text(
                          _error!,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: _spacing),
                        ElevatedButton(
                          onPressed: _fetchUserData,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ChatsScreen(name: _name ?? 'User'),
                      const StatusScreen(),
                      const CallLogsScreen(),
                    ],
                  ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          selectedLabelStyle:
              Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
          unselectedLabelStyle:
              Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle,
          showUnselectedLabels: true,
          elevation: 8,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
              tooltip: 'View chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fiber_manual_record),
              label: 'Status',
              tooltip: 'View status updates',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Calls',
              tooltip: 'View call logs',
            ),
          ],
        )
        // Avoid rendering BottomNavigationBar until initialized
        );
  }
}

class ChatsScreen extends StatelessWidget {
  final String name;
  const ChatsScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 10,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text('U${index + 1}',
              style: const TextStyle(color: Colors.white)),
        ),
        title: Text(
          'User ${index + 1}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          'Hello, $name! How are you?',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Text(
          '12:${index < 10 ? '0$index' : index} PM',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        onTap: () {
          // Navigate to chat
        },
      ),
    );
  }
}

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            'My Status',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text(
            'Add status update',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          onTap: () {
            // Add status
          },
        ),
        Divider(
          color: Theme.of(context).dividerTheme.color,
          thickness: Theme.of(context).dividerTheme.thickness,
        ),
        ...List.generate(
          5,
          (index) => ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text('U${index + 1}',
                  style: const TextStyle(color: Colors.white)),
            ),
            title: Text(
              'User ${index + 1}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              'Today, ${10 + index}:00 AM',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              // View status
            },
          ),
        ),
      ],
    );
  }
}

class CallLogsScreen extends StatelessWidget {
  const CallLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 10,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text('U${index + 1}',
              style: const TextStyle(color: Colors.white)),
        ),
        title: Text(
          'User ${index + 1}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          index % 2 == 0 ? 'Outgoing, 5 min' : 'Incoming, 3 min',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Icon(
          index % 2 == 0 ? Icons.call_made : Icons.call_received,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () {
          // Initiate call
        },
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Account',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              // Navigate to account settings
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Notifications',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              // Navigate to notification settings
            },
          ),
          Divider(
            color: Theme.of(context).dividerTheme.color,
            thickness: Theme.of(context).dividerTheme.thickness,
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'About',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              // Navigate to about page
            },
          ),
        ],
      ),
    );
  }
}
