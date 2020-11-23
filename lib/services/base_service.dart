import 'package:http/http.dart' as http;

import '../env.dart';

class BaseService {
  static final client = http.Client();
  static final int requestTimeout = environment['requestTimeout'];
  static final String baseUrl = environment['baseUrl'];
  static final headers = {"Content-Type": "application/json", "Driver-ID": "1"};
}
