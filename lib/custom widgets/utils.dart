import 'package:file_picker/file_picker.dart';

Future filepicker({required filetype, allowedextensions}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: filetype,
    allowedExtensions: allowedextensions,
  );
  if (result != null) {
    return result.files.single.path.toString();
  } else {
    return '';
  }
}
