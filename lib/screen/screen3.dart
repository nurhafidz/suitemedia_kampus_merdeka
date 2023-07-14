import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screen2.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List<dynamic> users = [];
  int currentPage = 1;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchUsers();
    scrollController.addListener(() {
      if (_isBottomReached(scrollController)) {
        fetchNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$currentPage&per_page=10'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        users = data['data'];
        currentPage++;
        isLoading = false;
      });
    } else {
      // Handle the error case
      print('Failed to fetch users. Error: ${response.statusCode}');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchNextPage() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$currentPage&per_page=10'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        users.addAll(data['data']);
        currentPage++;
        isLoading = false;
      });
    } else {
      // Handle the error case
      print('Failed to fetch users. Error: ${response.statusCode}');
      setState(() {
        isLoading = false;
      });
    }
  }

  bool _isBottomReached(ScrollController scrollController) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    return currentScroll >=
        maxScroll - 200; // 200 is the threshold to start fetching the next page
  }

  void _handleUserTap(dynamic user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Screen2(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Third Screen', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF554AF0)),
      ),
      body: RefreshIndicator(
        onRefresh: fetchUsers,
        child: ListView.builder(
          itemCount: users.length + 1,
          itemBuilder: (context, index) {
            if (index == users.length) {
              return _buildLoader();
            } else {
              final user = users[index];
              return GestureDetector(
                onTap: () => _handleUserTap(user),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  margin: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Container(
                              child: ClipOval(
                                child: Image.network(
                                  user['avatar'],
                                  width: 49,
                                  height: 49,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user['first_name']} ${user['last_name']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    user['email'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              );
            }
          },
          controller: scrollController,
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return isLoading
        ? Container(
            height: 80,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container();
  }
}
