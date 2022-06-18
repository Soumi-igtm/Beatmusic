import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference categoriesCollection = FirebaseFirestore.instance.collection("categories");
CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");
CollectionReference musicsCollection = FirebaseFirestore.instance.collection("musics");
CollectionReference playlistsCollection = FirebaseFirestore.instance.collection("playlists");
CollectionReference artistsCollection = FirebaseFirestore.instance.collection("artists");
CollectionReference creatorsCollection = FirebaseFirestore.instance.collection("creators");