import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {

  static initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static String baseUrl = dotenv.env['API_URL'] ?? 'No configurado el API_URL';

}