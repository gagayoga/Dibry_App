import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/changepassword_controller.dart';

class ChangepasswordView extends GetView<ChangepasswordController> {
  const ChangepasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangepasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChangepasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
