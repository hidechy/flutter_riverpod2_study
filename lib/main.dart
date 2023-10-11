import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_riverpod2_firebase_study/photolog_data.dart';

import 'firebase_options.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

@riverpod
String hello(HelloRef ref) {
  return 'hello2';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hello = ref.watch(helloProvider);

    final photologs = ref.watch(photologsProvider);

    return Scaffold(
      body: SafeArea(
//        child: Center(child: Text(hello)),

        child: photologs.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                final logdata = data.docs[index].data();

                return ListTile(title: Text(logdata['index']));
              },
            );
          },
          error: (e, s) => Center(child: Text('error')),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
