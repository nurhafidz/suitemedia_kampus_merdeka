import 'package:flutter/material.dart';
import 'screen3.dart';

class Screen2 extends StatelessWidget {
  final dynamic user;

  const Screen2({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Second Screen', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF554AF0)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Welcome"),
                  Text(
                    "John Doe",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (user != null && user['avatar'] != null)
                    Container(
                      child: ClipOval(
                        child: Image.network(
                          user['avatar'],
                          width: 49,
                          height: 49,
                        ),
                      ),
                    ),
                  if (user != null) SizedBox(height: 10),
                  Text(
                    user != null &&
                            user['first_name'] != null &&
                            user['last_name'] != null
                        ? '${user['first_name']} ${user['last_name']}'
                        : 'Selected User Name',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  if (user != null) SizedBox(height: 10),
                  Text(
                    user != null && user['email'] != null ? user['email'] : '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                margin: const EdgeInsets.only(bottom: 8),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Screen3()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF2B637B),
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('NEXT'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
