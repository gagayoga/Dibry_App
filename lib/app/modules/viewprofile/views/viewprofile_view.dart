import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/viewprofile_controller.dart';

class ViewprofileView extends GetView<ViewprofileController> {
  const ViewprofileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ViewprofileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ViewprofileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
