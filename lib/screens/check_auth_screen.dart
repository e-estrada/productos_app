import 'package:flutter/material.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Espere');

            // if(snapshot.data == ''){

            // }
            Future.microtask(() {
              Navigator.of(context).pushReplacementNamed('home');
            });

            return Container();
          },
        ),
      ),
    );
  }
}
