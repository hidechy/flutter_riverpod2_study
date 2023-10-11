import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photolog_data.g.dart';

@riverpod
Stream<QuerySnapshot<Map<String, dynamic>>> photologs(PhotologsRef ref) {
  return FirebaseFirestore.instance.collection('photolog').snapshots();
}
