import 'package:flutter/material.dart';
import 'screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key, required this.enabled}) : super(key: key);

  final bool enabled;

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sentenceController = TextEditingController();

  bool isSentencePalindrome = false;

  void checkPalindrome(String sentence) {
    String sanitizedSentence = sentence.toLowerCase().replaceAll(' ', '');
    String reversedSentence =
        String.fromCharCodes(sanitizedSentence.runes.toList().reversed);
    isSentencePalindrome = sanitizedSentence == reversedSentence;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Palindrome Check'),
          content: Text('Is Palindrome: $isSentencePalindrome'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sentenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = widget.enabled
        ? () {
            String name = _nameController.text;
            String palindrome = _sentenceController.text;
            checkPalindrome(palindrome);
          }
        : null;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'images/ic_photo@3x.png',
                  height: 116,
                  width: 116,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 12,
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color(0xFF686777),
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Color(0xFF686777),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 16, 16, 16),
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextField(
                        controller: _sentenceController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 12,
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color(0xFF686777),
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Color(0xFF686777),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 16, 16, 16),
                          labelText: 'Palindrome',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      margin: const EdgeInsets.only(top: 8),
                      child: ElevatedButton(
                        onPressed: onPressed,
                        child: const Text('CHECK'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF2B637B),
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      margin: const EdgeInsets.only(top: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Screen2(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF2B637B),
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('NEXT'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
