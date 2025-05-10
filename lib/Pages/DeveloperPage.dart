import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({super.key});

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // To pick the image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // To upload image to Firebase Storage and get the image URL
  Future<String?> _uploadImage(File imageFile) async {
    final ref = FirebaseStorage.instance
        .ref('game_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  // Create a game entry in Firestore
  Future<void> _createGame() async {
    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl = await _uploadImage(_selectedImage!); // Upload image if selected
    }

    // Save game details to Firestore
    await FirebaseFirestore.instance.collection('games').add({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'price': _priceController.text,
      'imageUrl': imageUrl ?? '',
      'timestamp': Timestamp.now(),
    });

    // Clear the form after saving
    _titleController.clear();
    _descriptionController.clear();
    _priceController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Manage Games"),
        backgroundColor: const Color.fromARGB(255, 0, 255, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: "Price",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text("Pick Image"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 255, 0),
                  ),
                ),
                const SizedBox(width: 10),
                _selectedImage != null
                    ? Image.file(_selectedImage!, height: 50)
                    : const Text("No image selected",
                        style: TextStyle(color: Colors.white54)),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _createGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 255, 0),
              ),
              child: const Text("Create Game"),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white30),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('games')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Card(
                        color: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.greenAccent),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: data['imageUrl'] != null && data['imageUrl'] != ''
                              ? Image.network(data['imageUrl'], width: 50, height: 50, fit: BoxFit.cover)
                              : const Icon(Icons.videogame_asset, color: Colors.white),
                          title: Text(data['title'], style: const TextStyle(color: Colors.white)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['description'], style: const TextStyle(color: Colors.white70)),
                              if (data['price'] != null)
                                Text('💵 ${data['price']}', style: const TextStyle(color: Colors.greenAccent)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
