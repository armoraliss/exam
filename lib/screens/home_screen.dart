import 'dart:io';

import 'package:exam/screens/account_screen.dart';
import 'package:exam/screens/animate.dart';
import 'package:exam/screens/login_screen.dart';
import 'package:exam/screens/news.dart';
import 'package:exam/screens/qrcode.dart';
import 'package:exam/screens/signup_screen.dart';
import 'package:exam/screens/story.dart';
import 'package:exam/screens/todo.dart';
import 'package:exam/screens/todoItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todosList = Todo.todoList();
  List<Todo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF151026),
          title: const Text('Books'),
          actions: [
            IconButton(
              onPressed: () {
                if ((user == null)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountScreen()),
                  );
                }
              },
              icon: Icon(
                Icons.person,
                color: (user == null) ? Colors.white : Colors.yellow,
              ),
            ),
          ],
        ),
        drawer: const NavigationDrawer(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(children: [
                searchBox(),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text(
                        'All books',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                    ),
                    // ignore: prefer_const_constructors

                    for (Todo todo in _foundToDo.reversed)
                      ToDoItem(
                        todo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      ),
                  ],
                )),
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: (user != null)
                  ? Row(children: [
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.only(bottom: 20, right: 20, left: 20),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0),
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _todoController,
                            decoration: InputDecoration(
                                hintText: 'Add a new book',
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20, right: 20),
                        child: ElevatedButton(
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 40),
                          ),
                          onPressed: () {
                            _addToDoItem(_todoController.text);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              minimumSize: Size(60, 60),
                              elevation: 10),
                        ),
                      )
                    ])
                  : Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text(
                        'To add books please register!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF151026),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
            )
          ],
        ));
  }

  void _handleToDoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String todo) {
    setState(() {
      todosList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
    _todoController.clear();
  }

  void _runFilter(String search) {
    List<Todo> results = [];
    if (search.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              item.todoText!.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 223, 217, 217),
            borderRadius: BorderRadius.circular(20)),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 50, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Color.fromARGB(253, 69, 71, 66),
            ),
          ),
        ));
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: Color(0xFF151026),
        padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://branditechture.agency/brand-logos/wp-content/uploads/wpdm-cache/Apple-Books-900x0.png'),
            ),
            SizedBox(height: 22),
            Text(
              'BOOKS APP',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(runSpacing: 16, children: [
          ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () => {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    )),
                  }),
          ListTile(
            leading: const Icon(Icons.app_registration),
            title: const Text('Register'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text('News'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NewsScreen(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text('Qr-Code'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Qrcode(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Stories'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Story(),
              ));
            },
          ),
          const Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              exit(0);
            },
          ),
        ]),
      );
}
