import 'package:flutter/material.dart';

import 'utils/app_theme.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [surface, onPrimary, surface],
                stops: [.15, .60, .80])),
        child: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ERRO 404", style: textTheme.titleLarge),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text("Perdão, esse endereço não existe", style: textTheme.titleMedium),
              ),
              TextButton(
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home, size: 18),
                    Text("Retornar à página inicial", style: TextStyle(fontSize: 18)),
                  ],
                ),
                onPressed: () => Navigator.of(context).pushNamed("/"),
              )
            ],
          ),
        ),
    );
  }
}