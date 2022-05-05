import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import '../../app/locator.dart';
import '../../data/models/app_user.dart';
import '../../data/sites_repo.dart';
import '../../services/firestore_service.dart';
import '../../services/image_upload_service.dart';

enum DrawerState {
  main,
  language,
  scheme,
}

class DrawerVM extends ChangeNotifier {
  final _dataRepo = locator<DataRepo>();
  final _fireStoreService = locator<FirestoreService>();
  final _imageUploaderService = locator<ImageUploaderService>();
  DrawerState state = DrawerState.main;

  AppUser get user => _dataRepo.user;

  String get imageUrl => user.picture!;

  bool get haveImage => user.picture != null;

  void switchState(DrawerState state) {
    this.state = state;
    notifyListeners();
  }

  bool uploading = false;

  Future<void> userPhotoClicked(BuildContext context) async {
    final ImageUploadData response =
        await _imageUploaderService.showImagePickerModal(context);

    if (response.imageBytes.isEmpty) {
      return;
    }

    final Uint8List compressedBytes = await _imageUploaderService.compressBytes(
      response.imageBytes,
    );

    uploading = true;
    notifyListeners();

    final photoUrl = await _fireStoreService.uploadImage(compressedBytes);
    await _fireStoreService.updateUserPhoto(photoUrl);

    uploading = false;
    await Future.delayed(const Duration(seconds: 2));
    notifyListeners();
  }
}
