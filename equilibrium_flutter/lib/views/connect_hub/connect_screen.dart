import 'package:equilibrium_flutter/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';

class ConnectScreen extends StatelessWidget {

  final HubConnectionHandler connectionHandler = GetIt.instance<HubConnectionHandler>();

  ConnectScreen({super.key});

  final _hubUriController = TextEditingController(text: "192.168.27.51:8000");

  /*@override
  void dispose() {
    _hubUriController.dispose();
    super.dispose();
  }*/

  void handleLoginButtonPress(BuildContext context) async  {
    await connectionHandler.connect(_hubUriController.text);
    if (context.mounted) context.go("/scenes");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Enter the URL of your hub to continue'),
              SizedBox(height: 26),
              TextField(
                controller: _hubUriController,
                decoration: InputDecoration(
                  labelText: 'Hub URL',
                  hintText: "192.168.0.123:8000",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 26),
              SizedBox(
                width: 200,
                height: 49,
                child: ElevatedButton(
                  onPressed: () {
                    handleLoginButtonPress(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Connect',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}