import 'package:image_picker/image_picker.dart';

class FileModel {
  XFile? file;
  String name;
  String? fileType;
  String? size;
  int fromType; //1=take photo , 2 select from gallery, 3 = api
  String? url;
  String? base64;

  FileModel(
      {this.file,
      required this.name,
      this.fileType,
      this.size,
      required this.fromType,
      this.url,
      this.base64});
}
