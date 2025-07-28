import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSelector {
  File? imageFile;
  XFile? xFile;

// picking the image from gallery
  Future pickImageFromGallery(BuildContext context) async {
    try {
      xFile = (await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 100))!;
      imageFile = File(xFile!.path);
      return imageFile;
    } catch (error) {
      if (context.mounted) {
        // openSimpleSnackBar("Error occurred: $error");
        debugPrint('Error occurred: $error');
      }
    }
  }

//  picking the image from camera
  Future pickImageFromCamera(BuildContext context) async {
    try {
      xFile = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 100);
      imageFile = File(xFile!.path);
      return imageFile;
    } catch (error) {
      if (context.mounted) {
        // openSimpleSnackBar("Error occurred: $error");
        debugPrint('Error occurred: $error');
      }
    }
  }

//  for the image picker bottomSheet
  void imagePickerBottomSheet(
      BuildContext context, {
        required void Function(File? selectedImage) onGalleryImageSelected,
        required void Function(File? selectedImage) onCameraImageSelected,
      }) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      context: context,
      builder: (builder) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    File? selectedImage = await pickImageFromGallery(context);
                    if (selectedImage != null) {
                      imageFile = selectedImage;
                      onGalleryImageSelected.call(selectedImage);
                    }
                    debugPrint("Selected Image: $selectedImage");
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.image_outlined, size: 30),
                      SizedBox(height: 12),
                      Text(
                        'Gallery',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    File? selectedImage = await pickImageFromCamera(context);
                    if (selectedImage != null) {
                      imageFile = selectedImage;
                      onCameraImageSelected.call(selectedImage);
                    }
                    debugPrint("Selected Image: $selectedImage");
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.camera_alt_outlined, size: 30),
                      SizedBox(height: 12),
                      Text(
                        'Camera',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void handlePermission(
      BuildContext context, {
        required void Function(File? selectedImage) onGalleryImageSelected,
        required void Function(File? selectedImage) onCameraImageSelected,
      }) async {
    Map<Permission, PermissionStatus> statuses = await [Permission.storage, Permission.camera].request();
    if (context.mounted) {
      if (statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted) {
        imagePickerBottomSheet(
          context,
          onGalleryImageSelected: (selectedImage) => onGalleryImageSelected.call(selectedImage),
          onCameraImageSelected: (selectedImage) => onCameraImageSelected.call(selectedImage),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Allow camera and storage permissions to store the image.'),
          ),
        );
        Map<Permission, PermissionStatus> newStatus = await [Permission.storage, Permission.camera].request();
        if (context.mounted) {
          if (newStatus[Permission.storage]!.isGranted && newStatus[Permission.camera]!.isGranted) {
            imagePickerBottomSheet(
              context,
              onGalleryImageSelected: (selectedImage) => onGalleryImageSelected.call(selectedImage),
              onCameraImageSelected: (selectedImage) => onCameraImageSelected.call(selectedImage),
            );
          }
        }
      }
    }
  }
}
