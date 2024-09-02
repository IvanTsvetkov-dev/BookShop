
import 'package:http/http.dart';

Future<Response> pingServer(Uri serverUri) {
  return get(serverUri);
}