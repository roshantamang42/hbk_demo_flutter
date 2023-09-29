import 'package:dio/dio.dart';
import 'package:hbk_demo/config/config.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  Future<void> uploadImage(XFile? pickedFile) async {
    try {
      Dio dio = Dio();

      if (pickedFile != null) {
        print(pickedFile.path);
        FormData formData = FormData.fromMap({
          'image': await MultipartFile.fromFile(pickedFile.path,
              filename: "image.jpg")
        });

        print(pickedFile);
        Response response = await dio.post(
          "http://10.0.2.2:90/category/add",
          data: formData,
        );

        if (response.statusCode == 200) {
          print("image success");
          print(response.data);
        } else {
          print(response.statusCode);
          print("Faileed!");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
