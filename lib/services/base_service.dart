import '../env.dart';

class BaseService {
  static final String baseUrl = environment['baseUrl'];
  static final headers = {"Content-Type": "application/json"};
}
