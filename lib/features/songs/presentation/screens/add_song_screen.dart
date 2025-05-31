import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:listefy_applciation/config/di/injection_container.dart';
import 'package:listefy_applciation/features/songs/data/models/song_model.dart';
import 'package:listefy_applciation/features/songs/domain/usecase/add_local_song_usecase.dart';

class AddSongScreen extends StatefulWidget {
  const AddSongScreen({super.key});

  @override
  State<AddSongScreen> createState() => _AddSongScreenState();
}

class _AddSongScreenState extends State<AddSongScreen> {
  File? selectedFile;
  bool isLoading = false;

  Future<void> _pickSongFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      setState(() {
        selectedFile = file;
      });
    }
  }

  Future<void> _addSongToLibrary() async {
    if (selectedFile == null) return;

    setState(() => isLoading = true);
    try {
      final song = await SongModel.fromFile(selectedFile!);
      await sl<AddLocalSongUseCase>().call(song);

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add song')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Song'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.music_note, size: 80, color: Colors.white70),
            const SizedBox(height: 32),
            Text(
              selectedFile != null
                  ? 'Selected: ${selectedFile!.path.split('/').last}'
                  : 'No song selected',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: isLoading ? null : _pickSongFile,
              icon: const Icon(Icons.folder_open),
              label: const Text('Pick a Song'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),
            if (selectedFile != null)
              ElevatedButton.icon(
                onPressed: isLoading ? null : _addSongToLibrary,
                icon: isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: const Text('Add to Library'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent.shade700,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
