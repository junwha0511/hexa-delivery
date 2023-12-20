import 'package:flutter/material.dart';

class CreateGroupPage extends StatefulWidget {
  final String restaurant;
  final String url;
  const CreateGroupPage(
      {super.key, required this.restaurant, required this.url});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('모임 열기'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }, // 뒤로가기
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 10,
              bottom: 80,
            ),
            child: Column(
              children: [
                Text("Restaurant: ${widget.restaurant}"),
                Text("URL: ${widget.url}"),
              ],
            ),
          ),
        ));
  }
}
